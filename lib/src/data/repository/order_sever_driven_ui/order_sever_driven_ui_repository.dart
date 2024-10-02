
import 'package:test_flutter_build/src/data/datasource/remote/get_sever_ui_remote_data_source.dart';
import 'package:test_flutter_build/src/data/model/response/order_sever_driven_ui/oder_sever_driven_ui_model.dart';

abstract class OrderSeverDrivenUIDataSource {
  Future<OrderSeverDrivenUIModel> getSeverUI();
}

class OrderSeverDrivenUIRepository extends OrderSeverDrivenUIDataSource {
  GetSeverUIRemoteDataSource getSeverUIRemoteDataSource;

  OrderSeverDrivenUIRepository({
    required this.getSeverUIRemoteDataSource,
  });

  @override
  Future<OrderSeverDrivenUIModel> getSeverUI() {
    final result = getSeverUIRemoteDataSource.getSeverUI();
    return result;
  }
}
