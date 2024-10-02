import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/presentation/views/widgets/order_detail_widget/route_path_widget.dart';

import '../../../../core/styles.dart';
import '../../../../data/model/response/order_detail/order_detail_model.dart';
import '../../../../data/model/response/route_path_model.dart';
import '../../../../utils/platform_channel.dart';
import '../../order_detail_view.dart';

class SearchTrackingNumberWidget extends StatefulWidget {
  final OrderDetailModel? order;

  const SearchTrackingNumberWidget({super.key, this.order});

  @override
  _SearchTrackingNumberWidgetState createState() =>
      _SearchTrackingNumberWidgetState();
}

class _SearchTrackingNumberWidgetState
    extends State<SearchTrackingNumberWidget> {
  late String query = '';
  List<RoutePathModel> filterPoints = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0),
      child: Column(
        children: [
          Container(
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 60, 10, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CupertinoTextField(
                      placeholder: "Tìm kiếm theo mã vận đơn",
                      prefix: const Icon(CupertinoIcons.search),
                      suffix: const Icon(CupertinoIcons.clear_circled_solid),
                      placeholderStyle: TextStyle(color: Colors.white),
                      style: TextStyle(color: Colors.black),
                      onChanged: (value) {
                        setState(() {
                          filterPoints = widget.order!.path
                              .where((stopPoint) =>
                                  stopPoint.isTrackNumberFound(value))
                              .toList();
                          print("Filtered Points: $filterPoints");
                          print("Query: $value");
                          query = value;
                        });
                      },
                    ),
                  ),
                  TextButton(
                    child: Text("Huỷ", style: TextStyle(color: Colors.orange)),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: double.infinity,
              color: const Color(0x00FFFFFF),
              // decoration: BoxDecoration(color: Colors.green.withOpacity(0.1)),
              child: Column(
                children: [
                  if (filterPoints.isNotEmpty) showFoundStpsList(),
                  if (filterPoints.isEmpty)
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      color: Colors.white,
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.search, color: Colors.black, size: 60),
                          Padding(
                            padding: EdgeInsets.only(left: 60, right: 60),
                            child: Text(
                                "Không tìm thấy điểm giao hàng trùng với mã vận đơn của bạn.",
                                style: TextStyle(color: Colors.black),
                                textAlign: TextAlign.center),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget showFoundStpsList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            "Điểm giao hàng trùng với mã kiện hàng của bạn:",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        ListView.builder(
            itemCount: filterPoints.length,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final data = filterPoints[index];
              return RoutePathWidget(
                borderColor: Colors.black54,
                leftIcon: index == 0
                    ? PathIconCase.from.toIconPath()
                    : PathIconCase.of(value: data.status).toIconPath(),
                path: data.address,
                pathStyle: AppStyles.styleBody3,
                padding: const EdgeInsets.only(
                  left: 16,
                  right: 16,
                  top: 12,
                ),
                onPathTap: () {
                  if (widget.order != null) {
                    PlatformChannelMethod.navigateToRouteDetail(
                        order: widget.order!, routeIndex: index);
                  }
                },
              );
            }),
      ],
    );
  }
}
