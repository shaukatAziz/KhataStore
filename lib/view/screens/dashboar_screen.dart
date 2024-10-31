import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata_store/models/amountModel.dart';
import 'package:khata_store/models/customerModel.dart';
import 'package:khata_store/view/screens/notification_screen.dart';
import '../../viewModel/Boxes/box.dart';
import '../../viewModel/controllers/dashbaord_controller.dart';
import 'detai_page.dart';

class DashBoardScreen extends StatefulWidget {
  final String userId;

  const DashBoardScreen({super.key, required this.userId});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  final searchController = TextEditingController(); // Search controller
  final nameController = TextEditingController();
  final numberController = TextEditingController();
  bool isSearching = false; // Track if search mode is active
  final DashBoardController controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: ValueListenableBuilder<Box<CustomerModel>>(
        valueListenable: Boxes.getData().listenable(),
        builder: (context, box, _) {
          final data = box.values
              .where((customer) =>
          customer.userId == widget.userId &&
              (customer.name
                  ?.toLowerCase()
                  .contains(searchController.text.toLowerCase()) ??
                  true))
              .toList()
              .cast<CustomerModel>();

          return Column(
            children: [
              const SizedBox(height: 20),
              _buildTopContainer(),
              const SizedBox(height: 20),
              _buildBottomContainers(),
              const SizedBox(height: 20),
              _buildCustomerSection(),
              const SizedBox(height: 20),
              _buildCustomerList(data),
            ],
          );
        },
      ),
      floatingActionButton: _buildFloatingButton(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,

      leading: IconButton(
        icon: isSearching
            ? const Icon(Icons.close, color: Colors.red)
            : const Icon(Icons.search, color: Colors.blue),
        onPressed: () {
          if (isSearching) {
            setState(() {
              isSearching = false;
              searchController.clear();
            });
          } else {
            setState(() {
              isSearching = true;
            });
          }
        },
      ),
      title: isSearching
          ? SizedBox(
        width: Get.width,
        height: Get.height * .05,
        child: TextField(
          controller: searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search customers...',

          ),
          onChanged: (value) {
            setState(() {});
          },
        ),
      )
          : Text(
        'DashBoard'.tr,
        style: const TextStyle(color: Colors.blue, fontSize: 20),
      ),
      centerTitle: true,
      actions: [
        ValueListenableBuilder(
          valueListenable: Boxes.getNotificationData().listenable(),
          builder: (context, Box box, _) {
            final notificationCount = box.length;
            return Stack(
              children: [
                IconButton(
                  icon: const Icon(Icons.notifications, color: Colors.blue),
                  onPressed: () {
                    Get.to(() => NotificationScreen());
                  },
                ),
                if (notificationCount > 0)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '$notificationCount',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildTopContainer() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            height: 120,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              color: Colors.blue.shade200,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Center(
              child: ValueListenableBuilder<Box<AmountModel>>(
                valueListenable: Boxes.getAmountData().listenable(),
                builder: (context, box, _) {
                  final totalAmount = box.values
                      .where((amount) => amount.userId == widget.userId)
                      .fold(0.0, (sum, amount) => sum + amount.amount);

                  return Text(
                    'Total PKR: ${totalAmount.toStringAsFixed(2)}',
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomContainers() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildAmountContainer('Debt', Colors.redAccent.shade400),
        _buildAmountContainer('Credit', Colors.greenAccent.shade400),
      ],
    );
  }

  Widget _buildAmountContainer(String title, Color color) {
    return Container(
      height: 70,
      width: Get.width * 0.4,
      decoration: BoxDecoration(
        color: color.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: ValueListenableBuilder<Box<AmountModel>>(
          valueListenable: Boxes.getAmountData().listenable(),
          builder: (context, box, _) {
            double totalAmount = box.values
                .where((amount) =>
            amount.userId == widget.userId &&
                ((title == 'Debt' && amount.type.toLowerCase() == 'give') ||
                    (title == 'Credit' &&
                        amount.type.toLowerCase() == 'take')))
                .fold(0.0, (sum, amount) => sum + amount.amount);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  'PKR ${totalAmount.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 17, color: Colors.white),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildCustomerSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'customers'.tr,
          style: TextStyle(
            color: Colors.blue.shade300,
            fontSize: 19,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomerList(List<CustomerModel> data) {
    return Expanded(
      child: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final customer = data[index];
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: ListTile(
              title: Text(customer.name ?? 'Unknown'),
              subtitle: Text(customer.phoneNumber ?? 'No number'),
              onTap: () {
                Get.to(
                      () => CustomerDetailPage(customer: customer),
                  transition: Transition.leftToRight,
                  duration: const Duration(seconds: 1),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildFloatingButton() {
    return FloatingActionButton.extended(
      backgroundColor: Colors.blue.shade300,
      onPressed: () {
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: 'add customer'.tr,
          content: Column(
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'customer name'.tr),
              ),
              TextField(
                controller: numberController,
                decoration: InputDecoration(labelText: 'mobile no'.tr),
                keyboardType: TextInputType.phone,
              ),
            ],
          ),
          confirm: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade300),
            onPressed: _addCustomer,
            child: Text('save'.tr, style: const TextStyle(color: Colors.white)),
          ),
          cancel: ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red.shade300),
            onPressed: () {
              Get.back();
              nameController.clear();
              numberController.clear();
            },
            child: Text(
                'cancel'.tr, style: const TextStyle(color: Colors.white)),
          ),
        );
      },
      label: Text(
          'add customer'.tr, style: const TextStyle(color: Colors.white)),
      icon: Icon(
        Icons.add,
        color: Colors.blue,
      ),
    );
  }
  void _addCustomer() {
    if (nameController.text.isNotEmpty && numberController.text.isNotEmpty) {
      final customer = CustomerModel(
        userId: widget.userId,
        name: nameController.text,
        phoneNumber: numberController.text,
        openingBalance: 0,
        closingBalance: 0,
      );
      Boxes.getData().add(customer);
      Get.back();
      nameController.clear();
      numberController.clear();
    }
  }
}