import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/cancel_order_param.dart';
import 'package:test_flutter_build/src/data/datasource/remote/params/proof_of_work_param.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/data/model/response/proof_of_work/proof_of_work.dart';
import 'package:test_flutter_build/src/data/repository/oder_detail/order_detail_repository.dart';
import 'package:test_flutter_build/src/utils/platform_channel.dart';

class GetOrderDetailDataSource extends OrderDetailDataSource {
  final ApiService apiService;

  GetOrderDetailDataSource({required this.apiService});

  @override
  Future<OrderDetailModel> getOrderDetail(String orderID) async {
    final config = await PlatFormChannel.getConfig();
    final token = config['token'];
    var header = "Bearer $token";
    final result = await apiService.getOrderDetail(orderID, header);
    return result;
  }

  @override
  Future<List<ProofOfWorkModel>> getProofOfWork(ProofOfWorkParams param) async {
    final config = await PlatFormChannel.getConfig();
    final token = config['token'];
    var header = "Bearer $token";
    final result = await apiService.getProofOfWork("poc", param.userType, param.appType, param.serviceId, param.groupStar, header);
    return result;
  }

  @override
  Future<void> cancelOrder(CancelOrderParams param) async {
    final config = await PlatFormChannel.getConfig();
    final token = config['token'];
    final result = await apiService.cancelOrder(
      param.orderId,
      param.comment,
      param.imageUrl,
      param.pocType,
      param.pocInfo,
      token,
    );
    return result;
  }

  Future<String> getToken() async {
    final config = await PlatFormChannel.getConfig();
    final token = config['token'];
    return token ?? "";
  }
}
