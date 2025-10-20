import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../widgets/widgets.dart';

class NoInterNetScreen extends StatefulWidget {
  final Widget child;
  const NoInterNetScreen({super.key, required this.child});

  @override
  _NoInterNetScreenState createState() => _NoInterNetScreenState();
}

class _NoInterNetScreenState extends State<NoInterNetScreen> {
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    checkInternet();
    Connectivity().onConnectivityChanged.listen((result) {
      setState(() {
        isOffline = result == ConnectivityResult.none;
      });
    });
  }

  Future<void> checkInternet() async {
    var result = await Connectivity().checkConnectivity();
    setState(() {
      isOffline = result == ConnectivityResult.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isOffline
        ? Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("assets/icons/noInternetIcon.svg"),
             SizedBox(height: 20.h),
            CustomText(text: "Oops!", fontsize: 30.sp, ),
            SizedBox(height: 30.h),
             CustomText(text: "There was some problem, Check your connection and try again",fontsize: 18.sp, maxline: 3,),
             SizedBox(height: 20.h),
            CustomButtonCommon(title: "Reload", onpress: checkInternet,),
            SizedBox(height: 20.h),

          ],
        ),
      ),
    )
        : widget.child;
  }
}
