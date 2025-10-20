
import 'package:careshiftapp/views/screens/splash_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'helpers/dependancy_injaction.dart';
import 'routes/app_routes.dart';
import 'services/firebase_service.dart';
import 'services/socket_service.dart';
import 'themes/light_theme.dart';
import 'views/screens/onboard_screen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Socket initialization properly
  SocketServices.init(); 
  SocketServices();
  // FirebaseService firebaseService = FirebaseService();
  // firebaseService.getFCMToken();

  DependencyInjection di = DependencyInjection();
  di.dependencies();


  runApp(
      DevicePreview(
      enabled: false,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
   //   const MyApp());
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (context, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Service App',
          home: SplashScreen(),
          getPages: AppRoutes.routes,
          theme: light(),
          themeMode: ThemeMode.light,
        );
      },
      designSize: const Size(393, 852),
    );
  }
}
