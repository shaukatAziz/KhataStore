import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:khata_store/models/amountModel.dart';

class AmountDetail extends StatelessWidget {
  final AmountModel amount;

  const AmountDetail({super.key, required this.amount});

  @override
  Widget build(BuildContext context) {
    final formattedDate = amount.date != null
        ? DateFormat('yyyy-MM-dd – kk:mm').format(amount.date!)
        : 'No Date';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Amount Details',style: TextStyle(color: Colors.blue),)),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description: ${amount.description}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black),
            ),
            Divider(thickness: 1.5,color: Colors.grey,),
            const SizedBox(height: 20),
            Text(
              'Type: ${amount.type}',
              style: const TextStyle(fontSize: 20,color: Colors.blueAccent),
            ),
            Divider(thickness: 2,color: Colors.grey,),

            const SizedBox(height: 20),
            Text(
              'Amount: PKR ${amount.amount.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18,color: Colors.lightBlue),
            ),
            Divider(thickness: 2,color: Colors.grey,),

            const SizedBox(height: 8),
            Text(
              'Date: $formattedDate',
              style: const TextStyle(fontSize: 20,color: Colors.black),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}