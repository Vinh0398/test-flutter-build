import 'package:test_flutter_build/src/data/datasource/remote/get_order_detail_data_source.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/cancel_order_param.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/proof_of_work_param.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/data/model/response/proof_of_work/proof_of_work.dart';

abstract class OrderDetailDataSource {
  Future<OrderDetailModel> getOrderDetail(String orderID);
  Future<List<ProofOfWorkModel>> getProofOfWork(ProofOfWorkParams param);
}

class OrderDetailRepository extends OrderDetailDataSource {
  final GetOrderDetailDataSource orderDetailDataSource;
  OrderDetailRepository({required this.orderDetailDataSource});

  @override
  Future<OrderDetailModel> getOrderDetail(String orderID) {
    final result = orderDetailDataSource.getOrderDetail(orderID);
    return result;
  }

  @override
  Future<List<ProofOfWorkModel>> getProofOfWork(ProofOfWorkParams param) {
    final result = orderDetailDataSource.getProofOfWork(param);
    return result;
  }

  @override
  Future<void> cancelOrder(CancelOrderParams param) {
    final result = orderDetailDataSource.cancelOrder(param);
    return result;
  }
}