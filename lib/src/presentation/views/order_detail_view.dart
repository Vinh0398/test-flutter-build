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
import 'package:test_flutter_build/src/presentation/controller/order_sever_driven_controller.dart';
import 'package:test_flutter_build/src/presentation/views/cancel_order_view.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/bottom_button_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/divider_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/left_right_text_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/commons/text_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/header_route_widget.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/route_path_widget.dart';
import 'package:test_flutter_build/src/utils/extension/number_format.dart';
import 'package:test_flutter_build/src/utils/layout_sections_config.dart';
import 'package:test_flutter_build/src/utils/native_channel.dart';
import 'package:test_flutter_build/src/utils/platform_channel.dart';
import 'package:test_flutter_build/src/utils/remote_config_utils.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/model/entity/order_sever_driven_ui_entity/section_entity/action_data_entity.dart';
import 'widgets/billing_details_widget.dart';
import 'widgets/commons/header_section_widget.dart';
import 'widgets/commons/order_row_widget.dart';

class OrderDetailView extends StatefulWidget {
  const OrderDetailView({super.key});

  @override
  State<OrderDetailView> createState() => _OrderDetailViewState();
}

class _OrderDetailViewState extends State<OrderDetailView> {
  late OrderSeverDrivenController _orderSeverDrivenController;
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
    getOrderIdFromNative();
    _orderSeverDrivenController = OrderSeverDrivenController(
      orderSeverDrivenUIUseCase: context.read(),
      getOrderDetailUseCase: context.read(),
    );
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
                        onPressed: () => PlatFormChannel.dismissView(orderId: state.orderDetail!.id),
                      ),
                      backgroundColor: const Color(0xFF142246),
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
                          icon: const Icon(Icons.more_vert, color: white),
                          onPressed: () {
                            showCupertinoModalPopup<void>(
                              context: context,
                              builder: (BuildContext context) =>
                                  CupertinoActionSheet(
                                    actions: <CupertinoActionSheetAction>[
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
                                                height: MediaQuery.of(context).size.height * 0.9,
                                                child: CancelOrderView(orderId: order?.id ?? '',),
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
                child: bodyViewWidget(
                    bodySection: body.sectionIds, data: state.drivenUI!),
              ),
              bottomNavigationBar: bottomData == null
                  ? Container()
                  : SafeArea(
                      child: BottomButtonWidget(
                          widgetHeight: 80,
                          buttonHeight: 70,
                          buttonPadding: const EdgeInsets.symmetric(
                              vertical: 12, horizontal: 12),
                          buttonTitle: bottomData.data?.first.value ?? "",
                          buttonColor: primary50,
                          buttonTitleStyle: handleGetTextStyle(bottomData
                                      .data?.first.styles
                                      ?.firstWhere(
                                          (element) => element.Key == "style")
                                      .Value ??
                                  "")
                              .copyWith(color: Colors.white), onTap: () => PlatFormChannel.navigateToRouteDetail(order: state.orderDetail!),),
                    ),
            );
          } else {
            return const SizedBox(child: Center(child: CircularProgressIndicator()));
          }
        },buildWhen: (previous, current) {
          return (previous.orderDetail != current.orderDetail);
      },
      ),
    );
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

  Widget bodyViewWidget(
      {required List<String> bodySection,
      required OrderSeverDrivenUIModel data}) {
    List<SectionsEntity> filterBodySections = [];
    for (String section in bodySection) {
      final item = data.sections?.firstWhere(
          (e) => e.id?.contains(section) == true,
          orElse: () => SectionsEntity());
      if (item?.id != null) {
        filterBodySections.add(item!);
      }
    }
    if (filterBodySections.isNotEmpty) {
      return ListView.builder(
          itemCount: filterBodySections.length,
          itemBuilder: (context, index) {
            final itemData = filterBodySections[index];
            if (itemData.id == "cash_section") {
              return cashSectionWidget(data: itemData.data);
            }
            if (itemData.id == "fee_order_section") {
              return leftRightSection(data: itemData.data);
            }
            if (itemData.id == "total_cod_section") {
              return leftRightSection(data: itemData.data);
            }
            if (itemData.id == "pricing_details_section") {
              return pricingDetailSection(action: itemData.action);
            }
            if (itemData.id?.contains("divider_section") == true) {
              return const DividerWidget(
                height: 2,
                color: gray3,
                horizontalPadding: 16,
                verticalPadding: 4,
              );
            }
            if (itemData.id == "service_section") {
              return serviceSection();
            }
            if (itemData.id == "route_header_section") {
              return routeHeaderSection();
            }
            if (itemData.id?.contains("path") == true) {
              return routePathSection();
            }
            return Container();
          });
    } else {
      return Container();
    }
  }

  Widget cashSectionWidget({List<SectionDataEntity>? data}) {
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

  Widget leftRightSection(
      {List<SectionDataEntity>? data, ActionDataEntity? action}) {
    final image = data
        ?.firstWhere((e) => e.type == "image" || e.type == "icon",
            orElse: () => SectionDataEntity())
        .value;
    String leftText;
    String? rightText;
    final listTextParam =
        data?.where((e) => e.type?.contains("text") == true).toList();
    if (listTextParam != null) {
      if (listTextParam.length > 1) {
        leftText = getOrderData(from: listTextParam.first.value ?? "");
        rightText = getOrderData(from: listTextParam.last.value ?? "");
      } else {
        leftText = getOrderData(from: listTextParam.first.value ?? "");
      }
      return LeftRightTextWidget(
        leftText: leftText,
        leftStyle: handleGetTextStyle(data?.first.styles
                ?.firstWhere((element) => element.Key == "style")
                .Value ??
            ""),
        rightText: rightText,
        rightStyle: handleGetTextStyle(data?.last.styles
                ?.firstWhere((element) => element.Key == "style")
                .Value ??
            ""),
        widgetHeight: 30,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        image: image,
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
    } else {
      return Container();
    }
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
      viewRouteTap: () async => await PlatFormChannel.openRouteView(order),
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
                PlatFormChannel.navigateToRouteDetail(order: order!, routeIndex: index);
              }
            },
          );
        });
  }

  Widget orderRowSection(
      {List<SectionDataEntity>? data, ActionDataEntity? action}) {
    final iconValue = data
        ?.firstWhere((e) => e.type == "icon", orElse: () => SectionDataEntity())
        .value;
    final headerValue = data?.firstWhere((e) => e.type == "header");
    final headerStyle = handleGetTextStyle(headerValue?.styles
            ?.firstWhere((element) => element.Key == "style")
            .Value ??
        "");
    final titleValue = data?.firstWhere((e) => e.type == "title");
    final titleStyle = handleGetTextStyle(titleValue?.styles
            ?.firstWhere((element) => element.Key == "style")
            .Value ??
        "");
    final descriptionValue = data?.firstWhere((e) => e.type == "description");
    final descriptionStyle = handleGetTextStyle(descriptionValue?.styles
            ?.firstWhere((element) => element.Key == "style")
            .Value ??
        "");
    final headerData = getOrderData(from: headerValue?.value ?? "");

    final iconPathType = PathIconCase.of(value: iconValue ?? "");
    final iconPath = iconPathType.toIconPath();
    return OrderRowWidget(
      borderColor: Colors.black54,
      leftIcon: iconPath,
      headerText: headerData ?? "",
      headerTextStyle: headerStyle,
      titleText: titleValue?.value ?? "",
      titleTextStyle: titleStyle,
      subtitleText: descriptionValue?.value ?? "",
      subtitleTextStyle: descriptionStyle,
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
      ),
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

  Widget pricingDetailSection({ActionDataEntity? action}) {
    return LeftRightTextWidget(
      leftText: "Xem chi tiết giá",
      leftStyle: AppStyles.styleH3.copyWith(color: primary40),
      widgetHeight: 30,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      image: "res/images/arrow_orange_icon.png",
      onTap: () => {
        if (order != null && action != null && action.type == "toast")
          {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return BillingDetailsWidget(order: order!);
              },
            ),
          },
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

  String getOrderData({required String from}) {
    final splitText = from.split("\$");
    final valueText = "\$${splitText.last}";
    final value = parseOrderData(from: valueText) ?? "";
    return splitText.first + value;
  }

  parseOrderData({required String from}) {
    if (order != null) {
      Map<String, dynamic> mapOrder = {
        '\${order.id}': "#${order!.id}",
        "\${order.path[0].address}": order!.path[0].address,
        "\${order.path[1].address}": order!.path[1].address,
        "\${order.service.id}": order!.service.id,
        "\${order.path[0].status}": order!.path[0].status,
        "\${order.path[1].status}": order!.path[1].status,
        "\${order.service.icon_url}": order!.service.iconUrl,
        "\${order.service.service_name}": order!.service.nameDefault,
        '\${order.distance}': order!.distance.toString(),
      };
      return mapOrder[from];
    }
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  Future<void> getOrderIdFromNative() async{
    orderId = await NativeChannel().getOrderIdFromNative(onReceived: (orderId) {
      _orderSeverDrivenController.getOrderDetail(orderId: orderId);
    });
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
