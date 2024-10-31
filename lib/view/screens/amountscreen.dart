import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khata_store/models/amountModel.dart';
import 'package:khata_store/utils/toast_messages.dart';
import 'package:khata_store/viewModel/Boxes/box.dart';
import '../../models/customerModel.dart';

class AmountScreen extends StatefulWidget {
  final CustomerModel customer;
  final String type;

  const AmountScreen({super.key, required this.customer, required this.type});

  @override
  State<AmountScreen> createState() => _AmountScreenState();
}

class _AmountScreenState extends State<AmountScreen> {
  final descriptionController = TextEditingController();
  final amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: const Text('Add Amount',style: TextStyle(color: Colors.blue),)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: amountController,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue
              ),
              onPressed: _saveAmount,
              child: const Text('Save Amount',style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _saveAmount() async {
    final amountValue = double.tryParse(amountController.text) ?? 0.0;
    if (amountValue <= 0) {
      ToastMessage.messagesRed('invalid', 'Enter valid amount');
      return;
    }

    final amount = AmountModel(
      userId: widget.customer.userId,
      description: descriptionController.text,
      amount: amountValue,
      type: widget.type,
      customerId: widget.customer.key,
      date: DateTime.now(),
    );

    final box = Boxes.getAmountData();
    await box.add(amount);

    descriptionController.clear();
    amountController.clear();

    Get.back(result: amount);
  }
}
