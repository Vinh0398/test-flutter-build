import 'package:bloc/bloc.dart';

class UploadImageState {
  List<String>? listUploadImage;

  UploadImageState({this.listUploadImage});
}

class UploadImageController extends Cubit<UploadImageState> {
  UploadImageController(super.initialState);
}