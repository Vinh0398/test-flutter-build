import 'package:test_flutter_build/src/data/model/response/order_sever_driven_ui/oder_sever_driven_ui_model.dart';
import 'package:test_flutter_build/src/domain/usecase/base_use_case.dart';

import '../../../data/datasource/local/get_sever_ui_data_source.dart';

class OrderSeverDrivenUIUseCase extends BaseUseCase<OrderSeverDrivenUIModel, void> {
  GetSeverUIDataSource getSeverUIDataSource;

  OrderSeverDrivenUIUseCase({required this.getSeverUIDataSource});

  @override
  Future<OrderSeverDrivenUIModel> invoke({required void param}) async {
    return await getSeverUIDataSource.getSeverUI();
  }
}