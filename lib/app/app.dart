import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tractian_challenge/app/core/routes/app_routes.dart';
import 'package:tractian_challenge/app/core/routes/routes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tractian Challenge',
      debugShowCheckedModeBanner: false,
      navigatorKey: Get.key,
      navigatorObservers: [GetObserver()],
      getPages: appRoutes,
      initialRoute: Routes.SPLASH,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
