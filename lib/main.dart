import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khata_store/Routes/app_routes.dart';
import 'package:khata_store/Routes/routes_name.dart';
import 'package:khata_store/models/customerModel.dart';
import 'package:khata_store/view/screens/translation.dart';
import 'package:khata_store/viewModel/controllers/themeControler.dart';
import 'package:khata_store/viewModel/services/notification_service.dart';
import 'package:path_provider/path_provider.dart';
import 'models/amountModel.dart';
import 'models/notification_model.dart';
import 'models/user_model.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path);

  Hive.registerAdapter(CustomerModelAdapter());
  Hive.registerAdapter(AmountModelAdapter());
  Hive.registerAdapter(UserModelAdapter());
  Hive.registerAdapter(NotificationModelAdapter());

  await Hive.initFlutter();
  await NotificationService.initialize();
  await Hive.openBox<NotificationModel>('notifications');
  if (!Hive.isBoxOpen('users')) {
    await Hive.openBox<UserModel>('users');
  }
  if (!Hive.isBoxOpen('amountBox')) {
    await Hive.openBox<AmountModel>('amountBox');
  }
  if (!Hive.isBoxOpen('customer')) {
    await Hive.openBox<CustomerModel>('customer');
  }

  runApp(const MyApp());
}
final ThemeController themeController = Get.put(ThemeController());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override

  Widget build(BuildContext context) {

    return Obx(()=>

       GetMaterialApp(
         theme: ThemeData.light(),
        darkTheme:ThemeData.dark() ,
        themeMode:themeController.isDarkMode.value?ThemeMode.dark:ThemeMode.light ,
        translations: Language(),
        locale: Get.deviceLocale,
        fallbackLocale: Locale('en'),
        debugShowCheckedModeBanner: false,
        initialRoute: RoutesName.splashscreen,
        getPages: AppRoutes.myRoutes, // Registering routes here
      ),
    );
  }
}
