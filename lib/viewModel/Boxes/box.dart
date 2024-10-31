import 'package:hive/hive.dart';
import 'package:khata_store/models/customerModel.dart';
import 'package:khata_store/models/amountModel.dart';

import '../../models/notification_model.dart';

class Boxes {
  static Box<CustomerModel> getData() => Hive.box<CustomerModel>('customer');
  static Box<AmountModel> getAmountData() => Hive.box<AmountModel>('amountBox');
  static Box<NotificationModel> getNotificationData() => Hive.box<NotificationModel>('notifications');

}
