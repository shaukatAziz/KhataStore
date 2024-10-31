import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:get/get_navigation/src/bottomsheet/bottomsheet.dart';
import 'package:hive/hive.dart';
import '../../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  final String userId;

  const ProfileScreen({Key? key, required this.userId}) : super(key: key);

  Future<UserModel?> fetchUserData() async {
    var box = await Hive.openBox<UserModel>('users');
    return box.values.firstWhere(
          (user) => user.id == userId,
      orElse: () => UserModel(), // Return an empty UserModel instead of null
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Text('profile'.tr, style: TextStyle(color: Colors.blue))),
      ),
      body: FutureBuilder<UserModel?>(
        future: fetchUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data == null || (snapshot.data?.fullName?.isEmpty ?? true)) {
            return const Center(child: Text('User not found'));
          }

          final user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Name: ${user.fullName}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 15),
                const Divider(),
                Text('Address: ${user.address}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 15),
                const Divider(),
                Text('Phone Number: ${user.phoneNumber}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 15),
                const Divider(),
                Text('Shop Name: ${user.shopName}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 15),
                const Divider(),
                Text('Shop Category: ${user.shopCatogory}', style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 15),
                const Divider(),
                Text('Email: ${user.email}', style: const TextStyle(fontSize: 18)),
              ],
            ),
          );
        },
      ),
    );
  }
}
