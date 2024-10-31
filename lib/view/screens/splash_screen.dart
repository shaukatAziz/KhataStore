
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Routes/routes_name.dart';
import '../../res/Images/asset_image.dart';
import '../widgets/custom_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // @override
  // void initState() {
  //   super.initState();
  //   // You can navigate to the home screen or login screen after a delay if needed
  //   // Future.delayed(Duration(seconds: 3), () {
  //   //   Get.toNamed(RoutesName.loginscreen);
  //   // });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(AssetsImages.splashScreen),
          ),
          Positioned(
            bottom: 30,
            left: 80,
            child: RoundButton(
              onpress: () {
                Get.toNamed(RoutesName.Signupscreen,);
              },
              title: 'Create Account',
            ),
          ),
          Positioned(
            bottom: 100,
            left: 80,
            child: RoundButton(
              onpress: () {
                Get.toNamed(RoutesName.loginscreen,);
              },
              title: 'Login',
            ),
          ),
        ],
      ),
    );
  }
}
