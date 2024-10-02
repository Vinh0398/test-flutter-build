import 'dart:async';
import 'dart:collection';
import 'package:flutter/widgets.dart';

import 'package:aha_flutter_core/utils/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_build/src/core/constrain.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/fail_order_param.dart';
import 'package:test_flutter_build/src/presentation/controller/route_detail_controller.dart';
import 'package:test_flutter_build/src/presentation/views/cancel_order_view.dart';
import 'package:test_flutter_build/src/presentation/views/order_detail_view.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/bottom_button_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/route_detail_widget/extend_information_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/route_detail_widget/information_client_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/route_detail_widget/payment_detail_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/route_detail_widget/route_bottom_button_button.dart';
import 'package:test_flutter_build/src/utils/extension/number_format.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/colors.dart';
import '../../core/styles.dart';
import '../../data/model/response/order_detail/order_detail_model.dart';
import '../../data/model/response/route_path_model.dart';
import '../../utils/dialog_utils.dart';
import '../../utils/map_util.dart';
import '../../utils/platform_channel.dart';
import 'map_view.dart';
import 'widgets/commons/circle_button_widget.dart';

class RouteDetailView extends StatefulWidget {
  final OrderDetailModel? order;
  final int routeIndex;
  final Completer<MapWidgetController> _mapWidgetControllerCompleter =
      Completer();

  RouteDetailView({
    required this.order,
    required this.routeIndex,
  });

  @override
  _RouteDetailViewState createState() => _RouteDetailViewState();
}

class _RouteDetailViewState extends State<RouteDetailView>
    with TickerProviderStateMixin {
  late RouteDetailController routeController;
  final Completer<MapWidgetController> _mapWidgetControllerCompleter =
      Completer();
  final Completer<GoogleMapController> _mapControllerCompleter = Completer();
  final Set<Marker> _markers = {};
  late String userType = "Người gửi";
  late String payTitle = "Số tiền cần ứng";
  late String moneyString = "";
  late String confirmBtnTitle = "";
  late PageController _pageViewController;
  late TabController _tabController;
  int _currentPageIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    _drawMarkers(widget.order!.path);
    createPolylines();
    routeController = RouteDetailController(
        requestCompleteOrderUserCase: context.read(),
        requestFailOrderUseCase: context.read(),
        getPaymentListUseCase: context.read(),
        pickupOrderUseCase: context.read(),
        getOrderDetailUseCase: context.read());
    routeController.getPaymentList("pod");
    super.initState();
    _pageViewController = PageController();
    _currentPageIndex = widget.routeIndex;
    _tabController =
        TabController(length: widget.order!.path.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _pageViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: routeController,
      child: BlocBuilder<RouteDetailController, RouteDetailState>(
        builder: (BuildContext context, RouteDetailState state) {
          final pathData = widget.order?.path[widget.routeIndex];
          var buttonHeight = 70;

          if (_currentPageIndex == 0) {
            payTitle = "Số tiền cần ứng";
            moneyString =
                NumberUtils.formatCurrency(pathData?.supplierCod ?? 0, "VND");
            userType = "Người gửi";
            confirmBtnTitle = "Đã lấy hàng";

            if (widget.order!.isAssigning ||
                widget.order!.isAccepted ||
                widget.order!.isInProcess) {
              buttonHeight = 0;
            }
          } else {
            payTitle = "Số tiền cần thu";
            moneyString =
                NumberUtils.formatCurrency(pathData?.supplierCod ?? 0, "VND");
            userType = "Người nhận";
            print("_currentPageIndex $_currentPageIndex");
            if (widget.order!.path[_currentPageIndex].isCompleted) {
              buttonHeight = 0;
            }
            confirmBtnTitle = "Thành công";
          }
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () => Navigator.pop(context)),
              backgroundColor: navBarColor,
              title: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Đơn hàng #${widget.order?.id}",
                        style:
                            AppStyles.styleBody2.copyWith(color: Colors.white)),
                    Text(
                      OrderStatus.of(widget.order?.status ?? "")
                          .getLocalizedStatus(),
                      style: AppStyles.styleBody2.copyWith(color: Colors.white),
                    )
                  ],
                ),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  icon: const Icon(Icons.more_vert, color: white),
                  onPressed: () {
                    showCupertinoModalPopup<void>(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            child: const Text('Báo cáo đơn hàng này',
                                style: TextStyle(
                                    color: CupertinoColors.activeBlue)),
                            onPressed: () {
                              PlatformChannelMethod.openReportView(
                                  widget.order);
                            },
                          )
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          child: const Text('Huỷ',
                              style: TextStyle(
                                  color: CupertinoColors.destructiveRed)),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Map Section
                  SizedBox(
                    height: 400,
                    width: AppConstrain.size.width,
                    child: Stack(
                      children: [
                        buildMap(context),
                        PageView(
                          controller: _pageViewController,
                          onPageChanged: _handlePageViewChanged,
                          children: <Widget>[
                            ...List.generate(widget.order!.path.length,
                                (index) {
                              return Container();
                            })
                          ],
                        ),
                        AddressInfoSection(
                            tabController: _tabController,
                            currentPageIndex: _currentPageIndex,
                            onUpdateCurrentPageIndex: _updateCurrentPageIndex,
                            address: widget.order!.path[_currentPageIndex]
                                .getAddress(),
                            numberOfPages: widget.order!.numberOfPath()),
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 4,
                    color: gray4,
                  ),
                  InformationClientWidget(
                      title: _currentPageIndex == 0
                          ? "Thông tin người gửi"
                          : "Thông tin người nhận",
                      userName:
                          widget.order?.getRoutePath(_currentPageIndex).name ??
                              "",
                      userType: userType),
                  PaymentDetailWidget(
                      payDetailTitle: payTitle,
                      moneyString: moneyString,
                      moneyTextStyle: widget.routeIndex == 0
                          ? AppStyles.styleH1.copyWith(color: redCash)
                          : AppStyles.styleH1.copyWith(color: lightGreen),
                      paymentDetail: state.paymentList
                              ?.firstWhere((e) =>
                                  (widget.order?.codPaymentMethod ?? 'cash') ==
                                  e.code)
                              .nameViVn ??
                          "",
                      paymentIcon: state.paymentList
                              ?.firstWhere((e) =>
                                  (widget.order?.codPaymentMethod ?? 'cash') ==
                                  e.code)
                              .iconUrl ??
                          ""),
                  const Divider(
                    thickness: 4,
                    color: gray2,
                  ),
                  if (_currentPageIndex == 0)
                    ExtendInformationWidget(
                      hidden: widget.routeIndex == 0,
                      userName: widget.order?.userName ?? "",
                      rated: widget.order?.userRating?.toDouble() ?? 0.0,
                    ),
                  RouteBottomButtonsWidget(
                    failBtnTitle: "Thất bại",
                    failBtnTextStyle: AppStyles.styleButton2.copyWith(color: blue50),
                    needShowFailBtn: _currentPageIndex != 0,
                    completeBtnTitle: _currentPageIndex == 0 ? "Đã lấy hàng" : "Thành công",
                    completeBtnTextStyle: AppStyles.styleButton2.copyWith(color: Colors.white),
                    failTap: () => failStopPointTouch(),
                    completeTap: () => routeController.processOrder(
                        _currentPageIndex, widget.order!),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  _processOrder() async {
    var title = "Bạn đã sẵn sàng chấp nhận đơn hàng này?";
    var content =
        "Bạn nên liên hệ với khách hàng sau khi chấp nhận đơn hàng này ngay lập tức";
    var positiveTitle = "Xác nhận";
    var negativeTitle = "Hủy";
    if (widget.order!.isAccepted) {
      title = "Đã lấy hàng?";
      content = "Bạn đã lấy hàng thành công và sẵn sàng để đi giao hàng?";
      positiveTitle = "XÁC NHẬN";
      negativeTitle = "CHƯA";
    }
    DialogUtils.showPrimaryDialog(
        context: context,
        title: title,
        content: content,
        positiveTitle: positiveTitle,
        onPositiveTap: () {
          if (widget.order!.isAssigning) {
            routeController.processOrder(_currentPageIndex, widget.order!);
          }
        },
        negativeTitle: negativeTitle,
        onNegativeTap: () {});
  }

  Widget buildMap(BuildContext context) {
    return MapWidget(
      onMapCreated: onMapCreated,
      initialCameraPosition: LatLng(widget.order!.path.first.lat.toDouble(),
          widget.order!.path.first.lng.toDouble()),
      myLocationEnabled: true,
      delayMapMillis: 1000,
      loadingTransparent: true,
      order: widget.order!,
    );
  }

  void _handlePageViewChanged(int currentPageIndex) {
    _tabController.index = currentPageIndex;
    setState(() {
      _currentPageIndex = currentPageIndex;
    });
  }

  void _updateCurrentPageIndex(int index) {
    _tabController.index = index;
    _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
    _moveNewCameraPosition(index);
  }

  Future _moveNewCameraPosition(int index) async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      final stop = widget.order!.path[index];
      CameraPosition _newCamera = CameraPosition(
          bearing: 192.8334901395799,
          target: LatLng(stop.lat.toDouble(), stop.lng.toDouble()));

      final GoogleMapController controller =
          await _mapControllerCompleter.future;
      await controller
          .animateCamera(CameraUpdate.newCameraPosition(_newCamera));
    });
  }

  Future onMapCreated(GoogleMapController controller,
      MapWidgetController mapWidgetController) async {
    try {
      _mapWidgetControllerCompleter.complete(mapWidgetController);
      _mapControllerCompleter.complete(controller);
    } catch (e) {
      logger.e("Map error", e);
    }
  }

  Future _drawMarkers(List<RoutePathModel> routeStopList) async {
    if (!mounted) return;
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      _markers.clear();
      if (routeStopList.isNotEmpty) {
        final stop = routeStopList[0];
        final marker = await MapUtil.createPickupMarker(context, "pickup",
            LatLng(stop.lat.toDouble(), stop.lng.toDouble()));
        _markers.add(marker);
      }
      final controller = await _mapWidgetControllerCompleter.future;
      controller.addMarkers(_markers);
    });
  }

  Future createPolylines() async {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        if (widget.order?.polylines?.isNotEmpty == true) {
          final controller = await _mapWidgetControllerCompleter.future;
          List<LatLng>? points =
              MapUtil.decodePolylines(widget.order!.polylines ?? "");
          _drawPolyLines(
            points: points,
            controller: controller,
          );
        } else {
          _clearPolylines();
        }
      } catch (e) {
        logger.e("Animate polyline error", e);
      }
    });
  }

  void _drawPolyLines({
    List<LatLng>? points,
    required MapWidgetController controller,
  }) {
    // print('Points to be drawn on the polyline: $points');
    // _makeMarkersBounds(points);
    controller.animatePolylines(points, false);
  }

  Future _clearPolylines() async {
    final controller = await _mapWidgetControllerCompleter.future;
    controller.clearPolylines();
  }

  void failStopPointTouch() {
    DialogUtils.showPrimaryDialog(
        context: context,
        title: "Giao hàng thất bại",
        content: "Bạn đã hoàn thành việc giao hàng?",
        positiveTitle: "Xác nhận",
        onPositiveTap: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.9,
                child: CancelOrderView(
                  orderId: widget.order?.id ?? '',
                  isFailOrder: true,
                  handleFailReason: (reasonFail) async {
                    double lat = 10.769556570699754;
                    double lng = 106.66369722678648;
                    FailOrderParam param = FailOrderParam(
                        orderId: "${widget.order?.id ?? ""}-$_currentPageIndex",
                        lat: lat,
                        lng: lng,
                        comment: reasonFail);
                    final result = await routeController.requestFailStopPoint(param);
                    if (result["success"]) {
                      routeController.getOrderDetail(orderId: widget.order?.id ?? "");
                      if (_currentPageIndex < widget.order!.path.length - 1) {
                        setState(() {
                          _currentPageIndex += 1;
                        });
                      } else {
                        setState(() {});
                      }
                    }
                  },
                ),
              );
            },
          );
        },
        negativeTitle: "Hủy",
        onNegativeTap: () {});
  }
}

class AddressInfoSection extends StatelessWidget {
  const AddressInfoSection({
    super.key,
    required this.tabController,
    required this.currentPageIndex,
    required this.onUpdateCurrentPageIndex,
    required this.address,
    required this.numberOfPages,
  });

  final int currentPageIndex;
  final TabController tabController;
  final void Function(int) onUpdateCurrentPageIndex;
  final String address;
  final int numberOfPages;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 300.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircledButton(
            icon: Icons.arrow_back,
            onPressed: () {
              if (currentPageIndex == 0) {
                return;
              }
              onUpdateCurrentPageIndex(currentPageIndex - 1);
            },
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(address.split(':').first,
                  style: AppStyles.styleCaption1.copyWith(color: Colors.black),
                  textAlign: TextAlign.center),
              Text(address.split(':')[1],
                  style: AppStyles.styleBody2.copyWith(color: Colors.grey),
                  textAlign: TextAlign.center),
            ],
          )),
          CircledButton(
            icon: Icons.arrow_forward,
            onPressed: () {
              if (currentPageIndex == (numberOfPages - 1)) {
                return null;
              }
              onUpdateCurrentPageIndex(currentPageIndex + 1);
            },
          )
        ],
      ),
    );
  }
}
