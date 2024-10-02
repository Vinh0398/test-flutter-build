import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/model/response/order_sever_driven_ui/oder_sever_driven_ui_model.dart';
import 'package:test_flutter_build/src/data/repository/order_sever_driven_ui/order_sever_driven_ui_repository.dart';

class GetSeverUIRemoteDataSource extends OrderSeverDrivenUIDataSource {
  final ApiService apiService;

  GetSeverUIRemoteDataSource({required this.apiService});

  @override
  Future<OrderSeverDrivenUIModel> getSeverUI() async {
    var header =
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXAiOiJzdXBwbGllciIsImNpZCI6Ijg0OTQxODYwNjQ5Iiwic3RhdHVzIjoiQlVTWSIsImVvYyI6InZpbmhuZDFAYWhhbW92ZS5jb20iLCJub2MiOiJOZ3V5ZW4gVmluaCIsImN0eSI6IlNHTiIsImFwcCI6Ik9uV2hlZWwiLCJpbWVpIjoiRUREODE0MEQtQUJFMy00Rjc1LUFGMTEtODBBN0RDRUZCNjVCIiwidHlwZSI6ImlvcyIsInBhcnRuZXIiOiJvbndoZWVsIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzI3NDI5MzM0LCJpYXQiOjE3MjcxNzAxMzQsImlzcyI6IkFoYU1vdmUifQ.TxImiPWUuV2jikD_p3mE85BtqcEMHAOFZ_WJK5JJ8WM";
    var orderID = "";

    final result = await apiService.getSeverDrivenUI(orderID, header);
    return result;
  }
}
