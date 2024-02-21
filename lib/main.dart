import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mapy/router/router.dart';

void main() => runApp(const Mapy());


RouterUtils myRouter = RouterUtils();

class Mapy extends StatelessWidget {
  const Mapy({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: myRouter.getRouter(),
      debugShowCheckedModeBanner: false,
    );
  }
}
