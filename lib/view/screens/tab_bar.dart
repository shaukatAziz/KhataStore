import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:khata_store/view/screens/mic_screen.dart';
import 'package:khata_store/view/screens/profilePage.dart';
import 'package:khata_store/view/screens/settingPage.dart';

import 'dashboar_screen.dart';

class TabBarScreen extends StatefulWidget {
  const TabBarScreen({Key? key}) : super(key: key);

  @override
  State<TabBarScreen> createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {
  late final String? userId;

  @override
  void initState() {
    super.initState();
    userId = Get.arguments != null && Get.arguments is Map<String, dynamic>
        ? Get.arguments['userId']
        : null;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: TabBarView(
          children: [
            DashBoardScreen(userId: userId??""),
            ProfileScreen(userId: userId??"",),
            SettingScreen(userId: userId??""),
            MicScreen(userId:userId??""),
          ],
        ),
        bottomNavigationBar:  BottomAppBar(
          color: Colors.white,
          child: TabBar(
            tabs: [
              Tab(text: "home".tr, icon: Icon(Icons.home, color: Colors.blue)),
              Tab(text: "profile".tr, icon: Icon(Icons.person, color: Colors.blue)),
              Tab(text: "settings".tr, icon: Icon(Icons.settings, color: Colors.blue)),
              Tab(text: "settings".tr, icon: Icon(Icons.mic, color: Colors.blue)),

            ],
          ),
        ),
      ),
    );
  }
}
