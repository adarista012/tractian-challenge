import 'package:get/get.dart';
import 'package:tractian_challenge/app/ui/home/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(
      () => HomeController(),
      fenix: true,
    );
  }
}
