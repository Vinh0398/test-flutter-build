import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/data/datasource/injector.dart';
import 'package:test_flutter_build/src/data/repository/complete_order/injector.dart';
import 'package:test_flutter_build/src/data/repository/fail_order/injector.dart';
import 'package:test_flutter_build/src/data/repository/oder_detail/injector.dart';
import 'package:test_flutter_build/src/data/repository/order_sever_driven_ui/injector.dart';
import 'package:test_flutter_build/src/data/repository/payment/injetor.dart';
import 'package:test_flutter_build/src/data/repository/return_package/injector.dart';
import 'package:test_flutter_build/src/domain/usecase/complete_order/injector.dart';
import 'package:test_flutter_build/src/domain/usecase/fail_order/injector.dart';
import 'package:test_flutter_build/src/domain/usecase/order_detail/injector.dart';
import 'package:test_flutter_build/src/domain/usecase/order_sever_driven_ui/injector.dart';
import 'package:test_flutter_build/src/domain/usecase/payment/injector.dart';
import 'package:test_flutter_build/src/domain/usecase/return_package/injector.dart';
import 'package:test_flutter_build/src/presentation/views/order_detail_view.dart';
import 'package:test_flutter_build/src/routes/route.dart';
import 'package:test_flutter_build/src/utils/get_it_utils.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'package:provider/provider.dart';

import 'src/data/repository/accept_order/injector.dart';
import 'src/data/repository/pickup_order/injector.dart';
import 'src/domain/usecase/accept_order/injector.dart';
import 'src/domain/usecase/pickup_order/injector.dart';
import 'src/utils/layout_sections_config.dart';
import 'src/utils/remote_config_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetItUtil().setupLocators();
  try {
    await Firebase.initializeApp(
        // name: "aha-move",
        options: FirebaseOptions(
            projectId: "aha-move",
            appId: "1:188147882581:ios:e730770390a54643c7d2dc",
            apiKey: "AIzaSyBf6FLjuQt6_UQ-G9ibxgg5ZNqqDHP1mVE",
            messagingSenderId: "188147882581"));
  } catch (error) {
    print("initializeApp error: $error");
  }

  await RemoteConfigUtils.initConfig();

  _configGoogleMap();

  runApp(MultiProvider(providers: [
    dioProvider,
    ...orderSeverDrivenUIRepositoryProvider,
    ...orderDetailRepositoryProvider,
    ...completeOrderRepositoryProvider,
    ...paymentRepositoryProvider,
    ...failOrderRepositoryProvider,
    ...returnPackageRepositoryProvider,
    ...getOrderDetailUseCaseProvider,
    ...orderSeverDrivenUIUseCaseProvider,
    ...requestCompleteOrderUseCaseProvider,
    ...requestFailOrderUseCaseProvider,
    ...getPaymentListUseCaseProvider,
    ...pickupOrderRepositoryProvider,
    ...requestPickupOrderUseCaseProvider,
    ...acceptOrderRepositoryProvider,
    ...acceptOrderUseCaseProvider,
    ...returnPackageUseCaseProvider,
  ],
      child: const MyApp()));
}

void _configGoogleMap() {
    final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = false;
    mapsImplementation.initializeWithRenderer(AndroidMapRenderer.latest);
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
     routerConfig: router,
    );
  }
}