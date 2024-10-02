import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../data/datasource/remote/params/accept_order_param.dart';
import '../../domain/usecase/accept_order/accept_order_use_case.dart';

class AcceptOrderState {
  bool? isSuccess;

  AcceptOrderState({this.isSuccess});
}

class OrderDetailController extends Cubit<AcceptOrderState> {
  final AcceptOrderUseCase acceptOrderUseCase;
  OrderDetailModel? _order;

  OrderDetailController({
    required this.acceptOrderUseCase,
  }) : super(AcceptOrderState(isSuccess: false));

  Future<void> acceptOrder({required AcceptOrderParam param}) async {
    final result = await acceptOrderUseCase.invoke(param: param);
    emit(AcceptOrderState(isSuccess: result["success"]));
  }

  processOrder(){
    if (_order == null) {
      return;
    }

    if (_order!.isAssigning) {
      acceptOrderId();
    }
  }

  acceptOrderId() {
    print("_acceptOrder");
    // final location = await PlatformChannelMethod.getCurrentLocation();
    final _defaultPosition =
        const LatLng(10.769556570699754, 106.66369722678648);

    final param = AcceptOrderParam(
        lat: _defaultPosition.latitude,
        lng: _defaultPosition.longitude,
        orderId: _order!.id);
    print("param: $param");
    acceptOrder(param: param);
  }

  updateOrderDetail(OrderDetailModel? order) {
    _order = order;
  }

  bool shouldShowRating() {
    if (_order == null) {
      return false;
    }

    if (_order!.isCompleted || (_order!.ratingBySupplier ?? 0) > 0) {
      return true;
    }

    return false;
  }

  // Future<DataState<DriverLocation>> fetchDriverLocation({
  //   required String orderId,
  // }) async {
  //   final result = await _driverLocationUseCase.call(params: orderId);
  //   if (result is DataSuccess) {
  //     _driverLocation = result.data;
  //     return result;
  //   }
  //   return DataFailed(result.error);
  // }
}
