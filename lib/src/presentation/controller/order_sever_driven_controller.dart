import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/data/model/response/order_sever_driven_ui/oder_sever_driven_ui_model.dart';
import 'package:test_flutter_build/src/domain/usecase/order_detail/get_order_detail_use_case.dart';
import 'package:test_flutter_build/src/domain/usecase/order_sever_driven_ui/order_sever_driven_ui_use_case.dart';


class OrderSeverDrivenState {
  OrderSeverDrivenUIModel? drivenUI;
  OrderDetailModel? orderDetail;

  OrderSeverDrivenState({
    this.drivenUI,
    this.orderDetail,
  });
}

class OrderSeverDrivenController extends Cubit<OrderSeverDrivenState> {
  final OrderSeverDrivenUIUseCase orderSeverDrivenUIUseCase;
  final GetOrderDetailUseCase getOrderDetailUseCase;
  OrderDetailModel? orderDetail;

  OrderSeverDrivenController({
    required this.orderSeverDrivenUIUseCase,
    required this.getOrderDetailUseCase,
    this.orderDetail,
  }) : super(OrderSeverDrivenState(drivenUI: null));

  Future<void> getOrderDrivenUI() async {
    final result = await orderSeverDrivenUIUseCase.invoke(param: null);
    emit(OrderSeverDrivenState(drivenUI: result));
  }

  Future<void> getOrderDetail({required String orderId}) async {
    final result = await getOrderDetailUseCase.invoke(param: orderId);
    emit(OrderSeverDrivenState(
      drivenUI: state.drivenUI,
      orderDetail: result,
    ));
    orderDetail = result;
  }
}
