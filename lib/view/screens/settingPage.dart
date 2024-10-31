import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../../viewModel/controllers/auth_controller/user_controller.dart';
import '../../viewModel/controllers/themeControler.dart';

class SettingScreen extends StatelessWidget {
  String? userId;
  SettingScreen({super.key, this.userId});
  void _changeLanguage(String languageCode) {
    Get.updateLocale(Locale(languageCode));
  }

  final UserController controller = Get.put(UserController());
  final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            'settings'.tr,
            style: const TextStyle(color: Colors.blue),
          ),
          centerTitle: true,
          actions: [
            PopupMenuButton<String>(
              color: Colors.white,
              onSelected: _changeLanguage,
              itemBuilder: (context) => [
                const PopupMenuItem<String>(
                  value: 'en',
                  child: Text(
                    'English',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                const PopupMenuItem<String>(
                  value: 'ur',
                  child: Text(
                    'اردو',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
              ],
              icon: const Icon(
                Icons.language,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 15),
                child: Text(
                  "General Setting",
                  style: TextStyle(
                    color: Colors.blue.shade300,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(
                thickness: 1,
                color: Colors.blue,
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                children: [
                  SizedBox(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween,
                            children: [
                              const Text(
                                "Change Theme",
                                style: TextStyle(fontSize: 16),
                              ),
                              Obx(
                                () => Transform.scale(
                                  scale: 0.7,
                                  child: Switch(
                                    activeColor: Colors.blue,
                                    inactiveThumbColor: Colors.blue,
                                    activeTrackColor: Colors.lightBlueAccent,
                                    inactiveTrackColor: Colors.white,
                                    value: themeController.isDarkMode.value,
                                    onChanged: (value) {
                                      themeController.toggleTheme(value);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Card(
                        color: Colors.white,
                        child: ListTile(
                          title: Text("About us"),
                          trailing: Icon(Icons.account_box_outlined),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                              backgroundColor: Colors.white,
                              title: "LogOut",
                              titleStyle: const TextStyle(color: Colors.blue),
                              content: Column(
                                children: [
                                  const Text("Are you sure To LogOut"),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                          style: TextButton.styleFrom(
                                              backgroundColor:
                                                  Colors.green.shade300),
                                          onPressed: () {
                                            controller.logout();
                                          },
                                          child: const Text(
                                            "yes",
                                            style:
                                                TextStyle(color: Colors.white),
                                          )),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      TextButton(
                                          style: TextButton.styleFrom(
                                            backgroundColor: Colors.redAccent,
                                          ),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          child: const Text(
                                            "No",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ))
                                    ],
                                  )
                                ],
                              ));
                        },
                        child: const Card(
                          color: Colors.white,
                          child: ListTile(
                            title: Text("LogOut"),
                            trailing: Icon(Icons.logout),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 13,
                  )
                ],
              )
            ]));
  }
}
