
import 'dart:async';

import 'package:careshiftapp/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../helpers/helpers.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';
import 'package:get/get.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 3), () async{
      String token = await PrefsHelper.getString(AppConstants.bearerToken);

      if(token.isNotEmpty){
        Get.offAllNamed(AppRoutes.allBottomBarScreen);
      }else{
        Get.toNamed(AppRoutes.onBoardScreen,preventDuplicates: false);
      }
     // Get.toNamed(AppRoutes.onBoardScreen,preventDuplicates: false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
             width: 393.w,
              height: 852.h,
              child: Image.asset("assets/images/splashscreens.png",fit: BoxFit.cover,),
          ),

          Positioned(
              bottom: 100.h,
              left: 170.w,
              child: CustomLoader())
        ],
      )
    );
  }
}


