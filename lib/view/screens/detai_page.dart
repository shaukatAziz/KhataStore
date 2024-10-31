import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/intl.dart';
import 'package:khata_store/models/customerModel.dart';
import 'package:khata_store/models/amountModel.dart';
import 'package:khata_store/utils/toast_messages.dart';
import 'package:khata_store/view/screens/amount_detail.dart';
import 'package:khata_store/viewModel/Boxes/box.dart';
import 'package:khata_store/viewModel/services/notification_service.dart';
import '../../models/notification_model.dart';
import 'amountscreen.dart';

class CustomerDetailPage extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDetailPage({super.key, required this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(
          child: Text(
            customer.name ?? 'Customer Detail',
            style: const TextStyle(color: Colors.blue),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildBalanceInfoSection(),
            const SizedBox(height: 16),
            _buildTableHeader(),
            const SizedBox(height: 16),
            Expanded(child: _buildAmountList()),
            const SizedBox(height: 40),
            Expanded(child: _buildActionButtons()),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceInfoSection() {
    return ValueListenableBuilder<Box<AmountModel>>(
      valueListenable: Boxes.getAmountData().listenable(),
      builder: (context, box, _) {
        final transactions = box.values
            .where((amount) => amount.customerId == customer.key)
            .toList();

        final totalGive = transactions
            .where((amount) => amount.type == 'give')
            .fold(0.0, (sum, amount) => sum + amount.amount);

        final totalTake = transactions
            .where((amount) => amount.type == 'take')
            .fold(0.0, (sum, amount) => sum + amount.amount);

        final openingBalance = customer.openingBalance ?? 0;
        final closingBalance = openingBalance + (totalTake - totalGive);

        return Container(
          height: Get.height * 0.2,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: closingBalance >= 0 ? Colors.green[300] : Colors.red[300],
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildBalanceInfo('Opening Balance', openingBalance, Colors.blue),
              const SizedBox(height: 16),
              _buildBalanceInfo('Closing Balance', closingBalance, Colors.white),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTableHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Credit', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Debt', style: TextStyle(fontWeight: FontWeight.bold)),
          Text('Close Balance', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildBalanceInfo(String label, double balance, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$label: ',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'PKR ${balance.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildActionButton('Give', Colors.red.shade300, 'give'),
        _buildActionButton('Take', Colors.green.shade300, 'take'),
      ],
    );
  }

  Widget _buildActionButton(String label, Color color, String type) {
    return SizedBox(
      width: 120,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: () async {
          final result = await Get.to(() => AmountScreen(customer: customer, type: type));
          if (result != null) {
            _showSavedAmount(result);
            _addNotification('Transsaction ', 'PKR ${result.amount} was $type with ${customer.name}.');
          }
        },
        child: Text(label, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  void _addNotification(String title, String body) {
    final notification = NotificationModel(
      title: title,
      body: body,
      timestamp: DateTime.now(),
    );

    final box = Boxes.getNotificationData();
    box.add(notification);

    NotificationService.showNotification(
      id: customer.key,
      title: title,
      body: body,
    );
  }


  Widget _buildAmountList() {
    return ValueListenableBuilder<Box<AmountModel>>(
      valueListenable: Boxes.getAmountData().listenable(),
      builder: (context, box, _) {
        final amounts = box.values
            .where((amount) => amount.customerId == customer.key)
            .toList()
          ..sort((a, b) => a.date!.compareTo(b.date!)); // Ensure sorting by date

        if (amounts.isEmpty) {
          return const Center(child: Text('No amounts added for this customer.'));
        }

        double currentBalance = customer.openingBalance ?? 0;

        return ListView.separated(
          itemCount: amounts.length,
          separatorBuilder: (context, index) => const Divider(color: Colors.grey, thickness: 1.5),
          itemBuilder: (context, index) {
            final amount = amounts[index];
            final formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(amount.date!);

            currentBalance += amount.type == 'take' ? amount.amount : -amount.amount;

            return _buildAmountRow(amount, formattedDate, currentBalance);
          },
        );
      },
    );
  }

  Widget _buildAmountRow(AmountModel amount, String formattedDate, double balance) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(amount.description, style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(formattedDate, style: const TextStyle(color: Colors.black, fontSize: 12)),
              InkWell(
                onTap: () => Get.to(AmountDetail(amount: amount), transition: Transition.leftToRight),
                child: const Text('See Details', style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
          Text(amount.type == 'take' ? '${amount.amount}' : '0', style: const TextStyle(color: Colors.green)),
          Text(amount.type == 'give' ? '${amount.amount}' : '0', style: const TextStyle(color: Colors.red)),
          Text('PKR ${balance.toStringAsFixed(2)}', style: const TextStyle(color: Colors.blue)),
        ],
      ),
    );
  }

  void _showSavedAmount(AmountModel amount) {
    ToastMessage.messagesGreen('amount', 'Amount saved successfully');
  }
}
