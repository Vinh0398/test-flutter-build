import 'package:test_flutter_build/src/data/model/response/order_detail/order_detail_model.dart';
import 'package:test_flutter_build/src/presentation/views/order_detail_view.dart';
import 'package:test_flutter_build/src/presentation/views/route_detail_view.dart';
import 'package:go_router/go_router.dart';

class RoutePath {
  RoutePath._();

  static const orderDetailPath = "/orderDetail";
  static const routeDetailPath = "routeDetail";
}

final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: RoutePath.orderDetailPath,
    routes: [
      _orderDetailRoute,
    ]);

final _orderDetailRoute = GoRoute(
    path: RoutePath.orderDetailPath,
    builder: (context, state) => const OrderDetailView(),
    routes: [
      GoRoute(
        path: "${RoutePath.routeDetailPath}/:routeIndex",
        builder: (context, state) {
          OrderDetailModel order = state.extra as OrderDetailModel;
          final routeIndex = int.parse(state.pathParameters["routeIndex"] ?? "0");
          return RouteDetailView(order: order, routeIndex: routeIndex,);
        },
      )
    ]);
