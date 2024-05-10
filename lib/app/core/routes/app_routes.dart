import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:tractian_challenge/app/core/routes/routes.dart';
import 'package:tractian_challenge/app/ui/assets/assets_page.dart';
import 'package:tractian_challenge/app/ui/home/home_page.dart';
import 'package:tractian_challenge/app/ui/splash/splash_binding.dart';
import 'package:tractian_challenge/app/ui/splash/splash_page.dart';

final appRoutes = [
  GetPage(
    name: Routes.SPLASH,
    page: () => const SplashPage(),
    preventDuplicates: true,
    binding: SplashBinding(),
  ),
  GetPage(
    name: Routes.HOME,
    page: () => const HomePage(),
    transition: Transition.circularReveal,
    transitionDuration: const Duration(milliseconds: 1240),
  ),
  GetPage(
    name: Routes.ASSETS,
    page: () => const AssetsPage(),
    preventDuplicates: true,
    // binding: SplashBinding(),
  ),
];
