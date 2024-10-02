import 'package:test_flutter_build/src/domain/usecase/return_package/return_package_use_case.dart';
import 'package:provider/provider.dart';

final returnPackageUseCaseProvider = [
  Provider<ReturnPackageUseCase>(
    create: (context) => ReturnPackageUseCase(
      context.read(),
    ),
  ),
];
