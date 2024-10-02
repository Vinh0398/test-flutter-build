import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_build/src/core/colors.dart';
import 'package:test_flutter_build/src/core/styles.dart';
import 'package:test_flutter_build/src/data/model/entity/order_sever_driven_ui_entity/section_entity/section_data_entity.dart';
import 'package:test_flutter_build/src/data/model/entity/order_sever_driven_ui_entity/section_entity/sections_entity.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/data/model/response/order_sever_driven_ui/oder_sever_driven_ui_model.dart';
import 'package:test_flutter_build/src/presentation/controller/order_detail_controller.dart';
import 'package:test_flutter_build/src/presentation/controller/order_sever_driven_controller.dart';
import 'package:test_flutter_build/src/presentation/views/cancel_order_view.dart';
import 'package:test_flutter_build/src/presentation/views/route_detail_view.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/bottom_button_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/divider_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/image_right_text_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/left_right_text_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/text_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/order_detail_widget/header_route_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/order_detail_widget/rating_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/order_detail_widget/route_path_widget.dart';
import 'package:test_flutter_build/src/routes/route.dart';
import 'package:test_flutter_build/src/utils/extension/number_format.dart';
import 'package:test_flutter_build/src/utils/layout_sections_config.dart';
import 'package:test_flutter_build/src/utils/native_channel.dart';
import 'package:test_flutter_build/src/utils/platform_channel.dart';
import 'package:test_flutter_build/src/utils/remote_config_utils.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/datasource/remote/params/accept_order_param.dart';
import '../../data/model/entity/order_sever_driven_ui_entity/section_entity/action_data_entity.dart';
import '../../utils/dialog_utils.dart';
import 'widgets/order_detail_widget/billing_details_widget.dart';
import 'widgets/commons/header_section_widget.dart';
import 'widgets/commons/order_row_widget.dart';
import 'widgets/commons/search_tracking_number_widget.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  late OrderSeverDrivenController _orderSeverDrivenController;
  late OrderDetailController _orderDetailController;
  late LayoutModel _layoutConfig;
  OrderDetailModel? order;
  String? orderId;

  final sectionIds = [
    "rating_section",
    "cash_section",
    "fee_order_section",
    "total_cod_section",
    "pricing_details_section",
    "divider_section",
    "service_section",
    "divider_section_1",
    "route_header_section",
    "path0_content_section",
    "path1_content_section",
    "next_button_section"
  ];

  @override
  void initState() {
    _orderSeverDrivenController = OrderSeverDrivenController(
      orderSeverDrivenUIUseCase: context.read(),
      getOrderDetailUseCase: context.read(),
    );
    _orderDetailController =
        OrderDetailController(acceptOrderUseCase: context.read());
    getOrderIdFromNative();
    _orderSeverDrivenController.getOrderDrivenUI();
    _layoutConfig = RemoteConfigUtils.getLayoutSections();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final header = _layoutConfig.screens.first.layout.first;
    final body = _layoutConfig.screens.first.layout
        .firstWhere((element) => element.type == "body");
    final footer = _layoutConfig.screens.first.layout
        .firstWhere((e) => e.type == "footer");
    return BlocProvider.value(
      value: _orderSeverDrivenController,
      child: BlocBuilder<OrderSeverDrivenController, OrderSeverDrivenState>(
        builder: (BuildContext context, state) {
          if (state.drivenUI != null && state.orderDetail != null) {
            order = state.orderDetail!;
            _orderDetailController.updateOrderDetail(order);
            SectionsEntity? appbarData;
            SectionsEntity? bottomData;
            if (header.sectionIds.contains("navigation_section")) {
              appbarData = getHeaderSectionData(
                  headerId: header.sectionIds.first, data: state.drivenUI!);
            }
            if (footer.sectionIds.contains("next_button_section")) {
              bottomData = getFooterSectionData(
                  footerId: footer.sectionIds.first, data: state.drivenUI!);
            }
            return Scaffold(
              appBar: appbarData == null
                  ? AppBar()
                  : AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.arrow_back_ios,
                            color: Colors.white),
                        onPressed: () => PlatformChannelMethod.dismissView(
                            orderId: state.orderDetail!.id),
                      ),
                      backgroundColor: navBarColor,
                      title: Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (header.sectionIds
                                .contains("navigation_section"))
                              Text("Đơn hàng #${order?.id}",
                                  style: AppStyles.styleBody2
                                      .copyWith(color: Colors.white)),
                            Text(
                              OrderStatus.of(order?.status ?? "")
                                  .getLocalizedStatus(),
                              style: AppStyles.styleBody2
                                  .copyWith(color: Colors.white),
                            )
                          ],
                        ),
                      ),
                      centerTitle: false,
                      actions: [
                        IconButton(
                          icon: const Icon(Icons.search, color: white),
                          onPressed: () {
                            // Implement search functionality
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              builder: (BuildContext context) {
                                return SearchTrackingNumberWidget(order: order);
                              },
                            );
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.more_vert, color: white),
                          onPressed: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                actions: <CupertinoActionSheetAction>[
                                  CupertinoActionSheetAction(
                                    child: const Text('Báo cáo đơn hàng này',
                                        style: TextStyle(
                                            color: CupertinoColors.activeBlue)),
                                    onPressed: () {
                                      PlatformChannelMethod.openReportView(
                                          order);
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('Gọi hỗ trợ khách hàng',
                                        style: TextStyle(
                                            color: CupertinoColors.activeBlue)),
                                    onPressed: () {
                                      _makePhoneCall('1900636636');
                                    },
                                  ),
                                  CupertinoActionSheetAction(
                                    child: const Text('Huỷ đơn hàng',
                                        style: TextStyle(
                                            color: CupertinoColors.activeBlue)),
                                    onPressed: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {
                                          return Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.9,
                                            child: CancelOrderView(
                                              orderId: order?.id ?? '',
                                              isFailOrder: false,
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  ),
                                ],
                                cancelButton: CupertinoActionSheetAction(
                                  child: const Text('Huỷ',
                                      style: TextStyle(
                                          color:
                                              CupertinoColors.destructiveRed)),
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
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: bodyViewWidget(bodySection: body.sectionIds),
              ),
              bottomNavigationBar:
                  order?.status == OrderStatus.completed.value ||
                          order?.status == OrderStatus.fail.value
                      ? SizedBox()
                      : SafeArea(
                          child: BottomButtonWidget(
                              widgetHeight: 80,
                              buttonHeight: 70,
                              buttonPadding: const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 12),
                              buttonTitle: getBottomButtonString(),
                              buttonColor: primary50,
                              buttonTitleStyle: AppStyles.styleButton2
                                  .copyWith(color: Colors.white),
                              onTap: () =>
                                  // PlatformChannelMethod.navigateToRouteDetail(
                                  //     order: state.orderDetail!),
                                  // handleNavigateRouteDetail()
                                  _processOrder()),
                        ),
            );
          } else {
            return const SizedBox(
                child: Center(child: CircularProgressIndicator()));
          }
        },
        buildWhen: (previous, current) {
          return (previous.orderDetail != current.orderDetail);
        },
      ),
    );
  }

  Future _processOrder() async {
    if (order?.isAssigning == true) {
      DialogUtils.showPrimaryDialog(
          context: context,
          title: "Bạn đã sẵn sàng chấp nhận đơn hàng này?",
          content:
              "Bạn nên liên hệ với khách hàng sau khi chấp nhận đơn hàng này ngay lập tức",
          positiveTitle: "Xác nhận",
          onPositiveTap: () {
            _orderDetailController.processOrder();
          },
          negativeTitle: "Hủy",
          onNegativeTap: () {});
    } else {
      handleNavigateRouteDetail();
    }
  }

  SectionsEntity? getHeaderSectionData(
      {required String headerId, required OrderSeverDrivenUIModel data}) {
    final headerSectionData =
        data.sections?.firstWhere((e) => e.id == headerId);
    return headerSectionData;
  }

  SectionsEntity? getFooterSectionData(
      {required String footerId, required OrderSeverDrivenUIModel data}) {
    final footerSectionData =
        data.sections?.firstWhere((e) => e.id == footerId);
    return footerSectionData;
  }

  Widget bodyViewWidget({required List<String> bodySection}) {
    if (bodySection.isNotEmpty) {
      return ListView.builder(
          itemCount: bodySection.length,
          itemBuilder: (context, index) {
            final itemData = bodySection[index];
            if (itemData.contains("rating") == true &&
                _orderDetailController.shouldShowRating()) {
              String imageUrl = "";
              if (order?.userFacebookId != null) {
                imageUrl =
                    "https://graph.facebook.com/${order?.userFacebookId}/picture?type=large";
              }
              // return Container();
              return RatingWidget(
                userName: order?.userName ?? "",
                starRated: 0,
                nameStyle: AppStyles.styleH6,
                avatarUrl: imageUrl,
              );
            }
            if (itemData == "cash_section") {
              return cashSectionWidget();
            }
            if (itemData == "fee_order_section") {
              return totalFeeOrderSection();
            }
            if (itemData == "total_cod_section") {
              return totalCodSection();
            }
            if (itemData == "pricing_details_section") {
              return pricingDetailSection();
            }
            if (itemData.contains("divider_section") == true) {
              return const DividerWidget(
                height: 2,
                color: gray3,
                horizontalPadding: 16,
                verticalPadding: 4,
              );
            }
            if (itemData == "service_section") {
              return serviceSection();
            }
            if (itemData == "route_header_section") {
              return routeHeaderSection();
            }
            if (itemData.contains("path") == true) {
              return routePathSection();
            }
            if (itemData.contains("request") == true) {
              return requestSection();
            }
            return Container();
          });
    } else {
      return Container();
    }
  }

  Widget cashSectionWidget() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: "Nhận tiền mặt",
          style: AppStyles.styleH6,
          padding: const EdgeInsets.symmetric(horizontal: 16),
        ),
        TextWidget(
            text: NumberUtils.formatCurrency(
                order?.supplierSubtotalPrice ?? 0, "VND"),
            style: AppStyles.styleH2,
            padding: const EdgeInsets.symmetric(horizontal: 16)),
      ],
    );
  }

  Widget totalFeeOrderSection() {
    String leftText;
    String? rightText;
    leftText = "Cước phí đơn hàng";
    final totalFee = order?.supplierSubtotalPrice ?? 0;
    rightText = NumberUtils.formatCurrency(totalFee, "VND");
    return LeftRightTextWidget(
      leftText: leftText,
      leftStyle: AppStyles.styleBody3,
      rightText: rightText,
      rightStyle: AppStyles.styleH5,
      widgetHeight: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );
  }

  Widget routeHeaderSection() {
    return HeaderRouteWidget(
      widgetHeight: 30,
      titleRouteText: "Lộ trình \u2981",
      routeText: "${order?.distance.toString() ?? " "}km",
      titleRouteStyle: AppStyles.styleH4,
      routeStyle: AppStyles.subHeadLine,
      rightText: "Xem lộ trình",
      rightStyle: AppStyles.subHeadLine.copyWith(
        color: primary40,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      viewRouteTap: () async =>
          await PlatformChannelMethod.openRouteView(order),
    );
  }

  Widget routePathSection() {
    return ListView.builder(
        itemCount: order?.path.length,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final data = order?.path[index];
          return RoutePathWidget(
            borderColor: Colors.black54,
            leftIcon: index == 0
                ? PathIconCase.from.toIconPath()
                : PathIconCase.of(value: data?.status ?? "").toIconPath(),
            path: data?.address ?? "",
            pathStyle: AppStyles.styleBody3,
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 12,
            ),
            onPathTap: () {
              if (order != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => RouteDetailView(
                            order: order,
                            routeIndex: index,
                          )),
                );
                // PlatformChannelMethod.navigateToRouteDetail(
                // order: order!, routeIndex: index);
              }
            },
          );
        });
  }

  Widget headerSection(
      {List<SectionDataEntity>? data, ActionDataEntity? action}) {
    return HeaderSectionWidget(
      data: data,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      onTap: () {
        if (action != null && action.type == "toast") {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(action.target ?? ""),
            ),
          );
        }
      },
    );
  }

  Widget pricingDetailSection() {
    return LeftRightTextWidget(
      leftText: "Xem chi tiết giá",
      leftStyle: AppStyles.styleH3.copyWith(color: primary40),
      widgetHeight: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      image: "res/images/arrow_orange_icon.png",
      onTap: () => {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return BillingDetailsWidget(order: order!);
          },
        ),
      },
    );
  }

  Widget totalCodSection() {
    String leftText;
    String? rightText;
    leftText = "Tổng COD cần ứng";
    final cod = order?.path.first.cod?.abs() ?? 0;
    rightText = NumberUtils.formatCurrency(cod, "VND");
    return LeftRightTextWidget(
      leftText: leftText,
      leftStyle: AppStyles.styleBody3,
      rightText: rightText,
      rightStyle: AppStyles.styleH5,
      widgetHeight: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: () {
        // if (action != null && action.type == "toast") {
        //   showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return BillingDetailsWidget(order: order);
        //     },
        //   );
        // }
      },
    );
  }

  Widget serviceSection() {
    return LeftRightTextWidget(
      leftText: "Dịch vụ",
      leftStyle: AppStyles.styleH4,
      widgetHeight: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      image: order?.service.iconUrl ?? "",
      rightText: order?.service.nameViVn,
      rightStyle: AppStyles.styleBody2,
    );
  }

  TextStyle handleGetTextStyle(String value) {
    return AppTextStyle.of(value).getTextStyle();
  }

  Widget requestSection() {
    if (order?.requests.isNotEmpty == true) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
            itemCount: order?.requests.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: false,
            itemBuilder: (context, index) {
              final data = order?.requests[index];
              if (data != null) {
                return ImageTextWidget(
                  padding: const EdgeInsets.only(top: 8),
                  widgetHeight: 30,
                  iconUrl: data.imgUrl ?? "",
                  leftText: data.nameViVn ?? "",
                  rightText: NumberUtils.formatCurrency(data.price ?? 0, "VND"),
                  leftTextStyle: AppStyles.styleH5.copyWith(color: gray90),
                  rightTextStyle:
                      AppStyles.styleH3.copyWith(color: neutralBlackColor),
                );
              } else {
                return Container();
              }
            }),
      );
    } else {
      return Container();
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> getOrderIdFromNative() async {
    NativeChannel().getOrderIdFromNative(onReceived: (orderID) {
    _orderSeverDrivenController.getOrderDetail(orderId: orderID);
    });
  }

  void handleNavigateRouteDetail() {
    int? routeIndex = 0;
    if (order?.status == OrderStatus.accepted.value) {
      routeIndex = 0;
    } else {
      routeIndex = order?.path.indexWhere((e) =>
      e.status != OrderStatus.completed.value.toUpperCase() &&
          e.status != OrderStatus.fail.value.toUpperCase());
    }
    final currentLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();
    context.go("$currentLocation/${RoutePath.routeDetailPath}/$routeIndex",
        extra: order);
  }

  String getBottomButtonString() {
    final orderStatus = OrderStatus.of(order?.status ?? "");
    print("orderStatus $orderStatus");
    switch (orderStatus) {
      case OrderStatus.assigning:
        return "Chấp nhận";
      case OrderStatus.accepted:
        return "Tiếp theo";
      case OrderStatus.processing:
        return "Tiếp theo";
      case OrderStatus.completed:
        return "";
      case OrderStatus.cancel:
        return "Đến màn hình xác nhận trả hàng";
      default:
        return "Tiếp theo";
    }
  }
}

enum PathIconCase {
  completed("completed"),
  fail("fail"),
  from("from"),
  dest("dest"),
  ;

  final String value;

  const PathIconCase(this.value);

  static PathIconCase of({required String value}) {
    final iconCase = PathIconCase.values.firstWhere(
        (element) => element.value.toUpperCase() == value,
        orElse: () => PathIconCase.dest);
    return iconCase;
  }

  String toIconPath() {
    switch (this) {
      case PathIconCase.completed:
        return "res/images/order_path_success_icon.png";
      case PathIconCase.fail:
        return "res/images/order_path_fail_icon.png";
      case PathIconCase.from:
        return "res/images/order_from_icon.png";
      case PathIconCase.dest:
        return "res/images/order_dest_icon.png";
      default:
        return "res/images/order_dest_icon.png";
    }
  }
}

class SearchTrackingNumberDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
