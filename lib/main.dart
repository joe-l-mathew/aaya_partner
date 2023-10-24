import 'package:aaya_partner/controller/worker_controller.dart';
import 'package:aaya_partner/screens/splash/splash_screen.dart';
import 'package:aaya_partner/services/dio_service.dart';
import 'package:aaya_partner/theme/theme_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

Dio? dioInstance;
void main() async {
  dioInstance = createDioWithLoggerInterceptor();
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('tokenBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WorkerController());
    final ThemeController themeController = Get.put(ThemeController());
    return Obx(() => GetMaterialApp(
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          title: 'Aaya Partner',
          theme: themeController.theme,
          themeMode: ThemeMode.system,
          initialBinding: BindingsBuilder(() {
            Get.lazyPut(() => themeController);
          }),
        ));
  }
}
