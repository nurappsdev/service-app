

import 'package:careshiftapp/routes/app_routes.dart';
import 'package:careshiftapp/views/screens/home/home_screen.dart';
import 'package:careshiftapp/views/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  int currentPage = 0;
  final PageController _pageController = PageController();
  final List<Map<String, String>> onboardingData = [
    {
      "title": "Your Care Journey Starts Here",
      "description":
      "Whether you're a Nurse, Carer, or Cleaner — we connect you with real opportunities to support people in their homes.",
      "onboardImage": "assets/images/firstOnbordIcon.png",
    },
    {
      "title": "Care When You Can",
      "description":
      "Choose the jobs that fit your availability — morning, evening, or weekends. You're in control.",
      "onboardImage": "assets/images/secondOnbordIcons.png",
    },
    {
      "title": "Track Hours. See Your Earnings.",
      "description":
      "Clock in/out with one tap and keep track of your pay with ease. We make it simple to stay on top of your time.",
      "onboardImage": "assets/images/thirdOnbordIcon.png",
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final newPage = _pageController.page?.round() ?? 0;
      if (newPage != currentPage) {
        setState(() {
          currentPage = newPage;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Static background image - does NOT change


          SizedBox.expand(
            child: Image.asset(
              "assets/images/onboardingimg.png",
              fit: BoxFit.cover,
            ),
          ),
          // PageView for swiping between pages
          PageView.builder(
            controller: _pageController,
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              final data = onboardingData[index];
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [

                    SizedBox(height: 200.h),
                    CustomText(
                      text: data["title"]!,
                      fontsize: 20.sp,
                      fontWeight: FontWeight.w600,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.h),
                    CustomText(
                      text: data["description"]!,
                      maxline: 7,
                      fontsize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(height: 30.h),
                    Image.asset(
                      data["onboardImage"]!,
                      width: 405.w,
                      height: 354.h,
                      fit: BoxFit.cover,
                    ),

                  ],
                ),
              );
            },
          ),

        ],
      ),
      bottomSheet: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      height: 140,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left: Skip or empty space
              currentPage == onboardingData.length - 1
                  ? SizedBox(width: 70.w)
                  : GestureDetector(
                onTap: () {
                  setState(() {
                    currentPage = onboardingData.length - 1;
                    _pageController.jumpToPage(currentPage);
                  });
                },
                child: CustomText(
                  text: "Skip",
                  fontWeight: FontWeight.w700,
                  fontsize: 16.sp,
                  color: Color(0xff0C4479),
                ),
              ),

              // Middle: SmoothPageIndicator with reversed dots
              SmoothPageIndicator(
                controller: _pageController,
                count: onboardingData.length,
                effect: WormEffect(
                  dotHeight: 12.h,
                  dotWidth: 12.w,
                  activeDotColor: Color(0xff31BAC4),
                  dotColor: Color(0xffBFEAED),
                ),
                onDotClicked: (index) {
                  setState(() {
                    currentPage = index;
                    _pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  });
                },
                // reversed dots
              ),

              // Right: Next or Let’s start
              GestureDetector(
                onTap: () {
                  if (currentPage < onboardingData.length - 1) {
                    currentPage++;
                    _pageController.animateToPage(
                      currentPage,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                    setState(() {});
                  } else {
                    // Get.toNamed(AppRoutes.signUpScreen,preventDuplicates: false);
                     Get.toNamed(AppRoutes.roleScreen,preventDuplicates: false);
                   // Get.to(()=> HomeScreen(),preventDuplicates: false);
                   // context.pushNamed(AppRoutes.signUpScreen);
                    // TODO: Navigate to next screen here
                  }
                },
                child: Row(
                  children: [
                    CustomText(
                      text: currentPage == onboardingData.length - 1
                          ? "Let’s start "
                          : "Next ",
                      fontWeight: FontWeight.w700,
                      fontsize: currentPage == onboardingData.length - 1 ? 14.sp : 18.sp,
                      color: Color(0xff0C4479),
                    ),
                    Icon(Icons.arrow_forward_outlined,size: 18.sp,color: Color(0xff0C4479),)
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

