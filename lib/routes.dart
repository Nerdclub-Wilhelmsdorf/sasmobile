import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:sasmobile/frame.dart';
import 'package:sasmobile/initial/initial_screen.dart';

appRoutes() => [
      GetPage(
        name: '/home',
        page: () => Frame(),
      ),
      GetPage(
        name: '/login',
        page: () => InitialScreen(),
      ),
    ];
