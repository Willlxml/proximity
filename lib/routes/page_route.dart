import 'package:get/get.dart';
import 'package:proximity_design/pages/login.dart';
import 'package:proximity_design/pages/register_mitra.dart';
import 'package:proximity_design/routes/route_name.dart';
import '../pages/pages/register_mitra_v2.dart';
import '../pages/pages/signup_as.dart';
import '../pages/pages/signup_worker.dart';
import '../pages/pages/signup_worker2.dart';
import '../pages/pages/welcome_page.dart';

class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.welc_page,
      page: () => WelcomePage(),
    ),
    GetPage(
      name: RouteName.signup_as,
      page: () => SignupAs(),
    ),
    GetPage(
      name: RouteName.signup_worker,
      page: () => SignupWorker(),
    ),
    GetPage(
      name: RouteName.signup_worker_2,
      page: () => SignupWorker2(),
    ),
    GetPage(
      name: '/RegisterMitra',
      page: () => RegisterMitra(),
    ),
    GetPage(
      name: '/RegisterMitraV2',
      page: () => RegisterMitraV2(),
    ),
    GetPage(
      name: '/LoginPage',
      page: () => LoginPage(),
    ),

  ];
}
