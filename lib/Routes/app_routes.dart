import 'package:get/get.dart';
import 'package:khata_store/Routes/routes_name.dart';
import 'package:khata_store/models/amountModel.dart';
import 'package:khata_store/view/screens/amount_detail.dart';
import 'package:khata_store/view/screens/dashboar_screen.dart';
import 'package:khata_store/view/screens/mic_screen.dart';
import 'package:khata_store/view/screens/settingPage.dart';
import 'package:khata_store/view/screens/tab_bar.dart';

import '../view/screens/formpage/SignUpscree_three.dart';
import '../view/screens/formpage/login_screen.dart';
import '../view/screens/formpage/signUp_screen.dart';
import '../view/screens/formpage/signup_two_screen.dart';
import '../view/screens/splash_screen.dart';

class AppRoutes {
  static List<GetPage> myRoutes = [
    GetPage(name: RoutesName.splashscreen, page: () => const SplashScreen()),
    GetPage(name: RoutesName.loginscreen, page: () => LoginScreen()),
    GetPage(name: RoutesName.homescreen, page: () =>  DashBoardScreen(userId: 'userId',)),
    GetPage(
      name: RoutesName.settingscreen,
      page: () => SettingScreen(),
    ),
    GetPage(name: RoutesName.Signupscreen, page: () => SignUpScreen()),
    GetPage(name: RoutesName.signupscreentwo, page: () => const SignUpTwoScreen()),
    GetPage(name: RoutesName.signupscreenthree, page: () => const SignUpScreenThree()),
    GetPage(name: RoutesName.micscreen, page: () => const MicScreen(userId: '',)),
    GetPage(
      name: RoutesName.amountdetail,
      page: () {
        final AmountModel amount = Get.arguments;
        return AmountDetail(amount: amount);
      },
    ),
    GetPage(
      name: RoutesName.tabbarscreen,
      page: () => TabBarScreen(),
    ),
  ];
}
