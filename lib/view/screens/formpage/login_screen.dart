
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Routes/routes_name.dart';
import '../../../viewModel/controllers/loginController.dart';
import '../../widgets/custom_button.dart';


class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ListView( // Change to ListView for scrolling
              children: [
                Container(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight * 0.4,
                  color: Colors.blue[200],
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: constraints.maxHeight * 0.05,
                      left: constraints.maxWidth * 0.05,
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: ' Welcome Back \n',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: constraints.maxWidth * 0.07,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: 'Login Into Your Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: constraints.maxWidth * 0.04,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: constraints.maxWidth * 0.9,
                  margin: EdgeInsets.symmetric(
                    horizontal: constraints.maxWidth * 0.05,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(60),
                    boxShadow: [
                      BoxShadow(color: Colors.white, spreadRadius: 10),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(constraints.maxWidth * 0.04),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          onChanged: (value) => controller.email.value = value,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.03),
                        TextFormField(
                          onChanged: (value) => controller.password.value = value,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          obscureText: true,
                        ),
                        SizedBox(height: constraints.maxHeight * 0.05),
                        SizedBox(

                          child: RoundButton(
                            onpress: () {
                              controller.loginUser();
                            },
                            title: 'Login',
                          ),
                        ),
                        SizedBox(height: 60),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?  '),
                            GestureDetector(
                              onTap: () {
                             Get.toNamed(RoutesName.Signupscreen);
                              },
                              child: Text(
                                'SignUp',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
