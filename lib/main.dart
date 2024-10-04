import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_flutter_build/src/data/datasource/injector.dart';
import 'package:test_flutter_build/src/data/repository/oder_detail/injector.dart';
import 'package:test_flutter_build/src/data/repository/order_sever_driven_ui/injector.dart';
import 'package:test_flutter_build/src/domain/usecase/order_detail/injector.dart';
import 'package:test_flutter_build/src/domain/usecase/order_sever_driven_ui/injector.dart';
import 'package:test_flutter_build/src/presentation/views/order_detail_view.dart';
import 'package:provider/provider.dart';

import 'src/utils/layout_sections_config.dart';
import 'src/utils/remote_config_utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

  runApp(MultiProvider(providers: [
    dioProvider,
    ...orderSeverDrivenUIRepositoryProvider,
    ...orderDetailRepositoryProvider,
    ...getOrderDetailUseCaseProvider,
    ...orderSeverDrivenUIUseCaseProvider,
  ],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OrderDetailView(),
    );
  }
}