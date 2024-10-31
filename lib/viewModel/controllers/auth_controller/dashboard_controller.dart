import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata_store/models/amountModel.dart';
import 'package:khata_store/models/customerModel.dart';
import 'package:khata_store/viewModel/Boxes/box.dart';

class DashboardController extends GetxController {
  final String userId;
  DashboardController(this.userId);

  final searchController = TextEditingController();
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  var isSearching = false.obs;

  List<CustomerModel> getFilteredCustomers() {
    final box = Boxes.getData();
    return box.values.where((customer) {
      return customer.userId == userId &&
          (customer.name?.toLowerCase().contains(searchController.text.toLowerCase()) ?? true);
    }).toList().cast<CustomerModel>();
  }

  double getTotalAmount() {
    final box = Boxes.getAmountData();
    return box.values.where((amount) => amount.userId == userId)
        .fold(0.0, (sum, amount) => sum + amount.amount);
  }

  void addCustomer() {
    if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
      final customer = CustomerModel(
        userId: userId,
        name: nameController.text,
        phoneNumber: numberController.text,
        openingBalance: 0,
        closingBalance: 0,

      );
      Boxes.getData().add(customer);
      nameController.clear();
      numberController.clear();
    }
  }

  void toggleSearch() {
    isSearching.value = !isSearching.value;
    if (!isSearching.value) {
      searchController.clear();
    }
  }
}
