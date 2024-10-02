import 'package:aha_flutter_core/utils/logger.dart';

import '../../core/resources/data_state.dart';

mixin RepositoryMixin {
  Future<DataState<T>> handleException<T>(Future<T> Function() process) async {
    try {
      final data = await process();
      return DataSuccess(data);
    } on Exception catch (e) {
      logger.e("Error", e);
      return DataFailed(e);
    } catch (e) {
      logger.e("Error", e);
      return DataFailed(Exception(e));
    }
  }
}