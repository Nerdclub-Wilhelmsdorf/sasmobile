import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:sasmobile/frame.dart';
import 'package:sasmobile/initial/initial_screen.dart';
import 'package:sasmobile/no_internet/login_page.dart';

appRoutes() => [
      GetPage(
        name: '/home',
        page: () => const Frame(),
      ),
      GetPage(
        name: '/login',
        page: () => const InitialScreen(),
      ),
      GetPage(name: "/loading", page: () => const LoginPage())
    ];
