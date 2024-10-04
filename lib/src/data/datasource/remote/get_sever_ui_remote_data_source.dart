import 'package:test_flutter_build/src/data/datasource/api_service.dart';
import 'package:test_flutter_build/src/data/model/response/order_sever_driven_ui/oder_sever_driven_ui_model.dart';
import 'package:test_flutter_build/src/data/repository/order_sever_driven_ui/order_sever_driven_ui_repository.dart';

class GetSeverUIRemoteDataSource extends OrderSeverDrivenUIDataSource {
  final ApiService apiService;

  GetSeverUIRemoteDataSource({required this.apiService});

  @override
  Future<OrderSeverDrivenUIModel> getSeverUI() async {
    var header =
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0eXAiOiJzdXBwbGllciIsImNpZCI6Ijg0Mzg0NTMwOTEzIiwic3RhdHVzIjoiQlVTWSIsImVvYyI6ImN1b25nbm1AYWhhbW92ZS5jb20iLCJub2MiOiJDdW9uZyBUZXN0IiwiY3R5IjoiU0dOIiwiYXBwIjoiQWhhTW92ZSIsImltZWkiOiJEMTVBODBGRC0yNjM1LTQyODEtQUM0Ny02NENBOTRDNTYyNDkiLCJ0eXBlIjoiaW9zIiwicm9sZSI6ImFkbWluIiwiZXhwIjoxNzI0NTU2MDQyLCJpYXQiOjE3MjQyOTY4NDIsImlzcyI6IkFoYU1vdmUifQ.V5cA3l9HcA998YOVMhs6NhZvMp3Lo6tGrMiDjU7srec";
    var orderID = "24SPB3CE";

    final result = await apiService.getSeverDrivenUI(orderID, header);
    return result;
  }
}
