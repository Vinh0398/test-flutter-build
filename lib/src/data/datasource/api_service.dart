import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/data/model/response/order_sever_driven_ui/oder_sever_driven_ui_model.dart';
import 'package:test_flutter_build/src/data/model/response/proof_of_work/proof_of_work.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "https://apistg.ahamove.com")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @GET("/api/v3/private/server-driven/order/{id}")
  Future<OrderSeverDrivenUIModel> getSeverDrivenUI(
      @Path("id") String orderID, @Header('Authorization') String header);

  @GET("/api/v3/saas/order/detail/{id}")
  Future<OrderDetailModel> getOrderDetail(
      @Path("id") String orderID, @Header('Authorization') String header);

  @GET("/api/v3/public/master-data/proof-of-work")
  Future<List<ProofOfWorkModel>> getProofOfWork(
      @Query("reason_type") String reasonType,
      @Query("user_type") String userType,
      @Query("app_type") String appType,
      @Query("service_id") String? serviceId,
      @Query("group_star") int? groupStar,
      @Header('Authorization') String header
      );

  @GET("/v1/order/cancel")
  Future<void> cancelOrder(
      @Query("order_id") String orderId,
      @Query("comment") String? comment,
      @Query("image_url") String? imageUrl,
      @Query("poc_type") String? pocType,
      @Query("poc_info") String? pocInfo,
      @Query('token') String token
      );
}
