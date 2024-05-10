import 'package:get/get.dart';
import 'package:tractian_challenge/app/ui/assets/assets_controller.dart';

class AssetsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AssetsController());
  }
}
