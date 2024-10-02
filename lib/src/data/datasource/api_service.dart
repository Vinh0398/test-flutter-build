import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';
import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/data/model/response/order_sever_driven_ui/oder_sever_driven_ui_model.dart';
import 'package:test_flutter_build/src/data/model/response/payment/payment_model.dart';
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
      @Header('Authorization') String header);

  @GET("/v1/order/cancel")
  Future<void> cancelOrder(
      @Query("order_id") String orderId,
      @Query("comment") String? comment,
      @Query("image_url") String? imageUrl,
      @Query("poc_type") String? pocType,
      @Query("poc_info") String? pocInfo,
      @Header('Authorization') String header);

  @GET("/v1/order/complete")
  Future<HttpResponse> completeOrder(
    @Query("token") String token,
    @Query("order_id") String orderId,
    @Query("comment") String? comment,
    @Query("lat") double lat,
    @Query("lng") double lng,
    @Query("image_url") String? imageUrl,
    @Query("pod_info") String? podInfo,
  );

  @GET("/v1/order/fail")
  Future<HttpResponse> failOrder(
    @Query("token") String token,
    @Query("order_id") String orderId,
    @Query("comment") String? comment,
    @Query("lat") double lat,
    @Query("lng") double lng,
    @Query("image_url") String? imageUrl,
    @Query("pof_info") String? pofInfo,
    @Query("redelivery_note") String? redeliveryNote,
  );

  @GET("/v1/order/pickup")
  Future<HttpResponse> pickupOrder(
    @Query("token") String token,
    @Query("order_id") String orderId,
    @Query("lat") double lat,
    @Query("lng") double lng,
    @Query("pop_info") String? popInfo,
  );

  @GET("/v1/order/accept")
  Future<HttpResponse> acceptOrder(
    @Query("token") String token,
    @Query("order_id") String orderId,
    @Query("lat") double lat,
    @Query("lng") double lng,
    @Query("pop_info") String? popInfo,
  );

  @GET("/api/v3/private/payment/methods/{provider}")
  Future<PaymentModel> getPaymentList(@Path("provider") String provider,
      @Header('Authorization') String header);

  @GET("/v1/order/notify_package_return")
  Future<HttpResponse> returnPackage(
      @Query("token")  String token,
      @Query("order_id") String orderId,
      @Query("lat") double lat,
      @Query("lng") double lng,
      @Query("por_info") String porInfo,
      );
}
