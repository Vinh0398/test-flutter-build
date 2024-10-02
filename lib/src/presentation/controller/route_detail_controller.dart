import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/fail_order_param.dart';
import 'package:test_flutter_build/src/data/model/entity/payment_entity/payment_entity.dart';
import 'package:test_flutter_build/src/data/model/response/payment/payment_model.dart';
import 'package:test_flutter_build/src/domain/usecase/complete_order/request_complete_order_use_case.dart';
import 'package:test_flutter_build/src/domain/usecase/fail_order/request_fail_order_use_case.dart';
import 'package:test_flutter_build/src/domain/usecase/order_detail/get_order_detail_use_case.dart';
import 'package:test_flutter_build/src/domain/usecase/payment/get_payment_list_use_case.dart';
import 'package:test_flutter_build/src/domain/usecase/pickup_order/pickup_order_use_case.dart';
import 'package:test_flutter_build/src/presentation/controller/order_sever_driven_controller.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/datasource/remote/params/complete_order_param.dart';
import '../../data/datasource/remote/params/pickup_order_param.dart';
import '../../data/model/response/order_detail/order_detail_model.dart';

class RouteDetailState {
  List<PaymentEntity>? paymentList;
  bool? isCancelled;
  bool? isCompleted;
  bool? isFailed;
  OrderDetailModel? orderDetailModel;

  RouteDetailState(
      {this.paymentList,
      this.isCancelled,
      this.isCompleted,
      this.orderDetailModel,
      this.isFailed});
}

class RouteDetailController extends Cubit<RouteDetailState> {
  RequestCompleteOrderUserCase requestCompleteOrderUserCase;
  RequestFailOrderUseCase requestFailOrderUseCase;
  GetPaymentListUseCase getPaymentListUseCase;
  PickupOrderUseCase pickupOrderUseCase;
  GetOrderDetailUseCase getOrderDetailUseCase;

  RouteDetailController(
      {required this.requestCompleteOrderUserCase,
      required this.requestFailOrderUseCase,
      required this.getPaymentListUseCase,
      required this.pickupOrderUseCase,
      required this.getOrderDetailUseCase})
      : super(RouteDetailState());

  Future<void> getPaymentList(String provider) async {
    final paymentList = await getPaymentListUseCase.invoke(param: provider);
    emit(RouteDetailState(paymentList: paymentList.data));
  }

  Future<void> pickupOrder(PickupOrderParam param) async {
    final result = await pickupOrderUseCase.invoke(param: param);
    emit(RouteDetailState(isCancelled: result["success"]));
  }

  Future<void> completeOrder(CompleteOrderParam param) async {
    final result = await requestCompleteOrderUserCase.invoke(param: param);
    emit(RouteDetailState(isCompleted: result["success"]));
  }

  Future<void> getOrderDetail({required String orderId}) async {
    final result = await getOrderDetailUseCase.invoke(param: orderId);
    emit(RouteDetailState(orderDetailModel: result));
  }

  Future processOrder(int index, OrderDetailModel order) async {
    print("status $order.status");
    if (order.status != OrderStatus.assigning.value) {
      if (index == 0) {
        await _pickupOrder(order.id);
      } else {
        var fullId = order.id;
        if (order.isCompletedAllPath == false) {
          fullId = "$fullId-$index";
        }
        await _completeOrder(fullId);
        await getOrderDetail(orderId: order.id);
      }
    }
  }

  Future _pickupOrder(String orderId) async {
    // final location = await PlatformChannelMethod.getCurrentLocation();
    final _defaultPosition =
        const LatLng(10.769556570699754, 106.66369722678648);

    final param = PickupOrderParam(
        lat: _defaultPosition.latitude,
        lng: _defaultPosition.longitude,
        orderId: orderId);
    print("param: $param");
    await pickupOrder(param);
  }

  Future _completeOrder(String orderId) async {
    print("_completeOrder");
    final _defaultPosition =
        const LatLng(10.769556570699754, 106.66369722678648);

    final param = CompleteOrderParam(
        lat: _defaultPosition.latitude,
        lng: _defaultPosition.longitude,
        orderId: orderId);
    print("param: $param");
    await completeOrder(param);
  }

  void processFailStopPoint() {}

  Future<Map<String, dynamic>> requestFailStopPoint(FailOrderParam param) async {
    final result = requestFailOrderUseCase.invoke(param: param);
    return result;
  }
}
