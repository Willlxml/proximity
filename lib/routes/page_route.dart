import 'package:get/get.dart';
import 'package:proximity/pages/signup_as.dart';
import 'package:proximity/pages/signup_worker.dart';
import 'package:proximity/pages/signup_worker2.dart';
import 'package:proximity/routes/route_name.dart';
import '../pages/welcome_page.dart';

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
  ];
}
