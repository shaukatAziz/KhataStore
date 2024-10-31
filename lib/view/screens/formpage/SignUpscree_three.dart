import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/get_navigation.dart';

import '../../../viewModel/controllers/auth_controller/user_controller.dart';
import '../../widgets/custom_button.dart';


class SignUpScreenThree extends StatefulWidget {
  const SignUpScreenThree({super.key});

  @override
  State<SignUpScreenThree> createState() => _SignUpScreenThreeState();
}

class _SignUpScreenThreeState extends State<SignUpScreenThree> {
  final controller = Get.find<UserController>();
  final _formkey = GlobalKey<FormState>();

  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
            top: 90,
            right: 20,
            child: Row(
              children: [
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  width: 100,
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 180,
            left: 20,
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Enter information to protect your account',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                  SizedBox(height: 40),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      onChanged: (value) => controller.email.value = value,
                      decoration: InputDecoration(labelText: 'Email'),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: TextField(
                      onChanged: (value) => controller.password.value = value,
                      decoration: InputDecoration(labelText: 'Password'),
                      obscureText: true,

                    ),
                  ),
                  SizedBox(height: 60),
                  RoundButton(
                    onpress: ()async {
                      await controller.submitForm();

                    },

                     title: 'SignUp',
                  )


                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
