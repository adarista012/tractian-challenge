import 'package:get/get.dart';
import 'package:tractian_challenge/app/core/routes/routes.dart';

class SplashController extends GetxController {
  String? _routeName;

  SplashController() {
    _init();
  }

  _init() async {
    await Future.delayed(const Duration(milliseconds: 1124));
    _routeName = Routes.HOME;
    Get.offAllNamed(_routeName!);
  }
}
