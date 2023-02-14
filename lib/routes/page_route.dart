import 'package:get/get.dart';
import 'package:proximity/pages/landingpage_company.dart';
import 'package:proximity/pages/landingpage_worker.dart';
import 'package:proximity/pages/login.dart';
import 'package:proximity/pages/navigation_page_company/category_page/categoryDetail.dart';
import 'package:proximity/pages/navigation_page_company/category_page/categoryPage.dart';
import 'package:proximity/pages/navigation_page_worker/category_page/categoryPage.dart';
import 'package:proximity/pages/register_mitra.dart';
import 'package:proximity/pages/whatsapp_verif.dart';
import 'package:proximity/routes/route_name.dart';
import '../pages/register_mitra_v2.dart';
import '../pages/signup_as.dart';
import '../pages/signup_worker.dart';
import '../pages/signup_worker2.dart';
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
    GetPage(
      name: RouteName.whatsapp_verif,
      page: () => WhatsAppVerif(),
    ),
    GetPage(
      name: RouteName.landingpageworker,
      page: () => LandingPageWorker(),
    ),
    GetPage(
      name: RouteName.landingpagecompany,
      page: () => LandingPageCompany(),
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
    GetPage(name: '/kategori/:id?', page:() => CategoryPage()),
    GetPage(name: '/kategoriMitra/:id?', page:() => CategoryPageMitra()),
    GetPage(name: '/kategoriDetail/:id?', page: () => CategoryDetail()),
  ];
}
