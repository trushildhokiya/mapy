import 'package:go_router/go_router.dart';
import 'package:mapy/screens/map.dart';
import 'package:mapy/screens/splash.dart';

class RouterUtils {
  final _router = GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/map',
        builder: (context, state) => MapScreen(),
      ),
    ],
  );

  GoRouter getRouter() {
    return _router;
  }
}
