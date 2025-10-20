



import 'package:careshiftapp/views/screens/find_job_screen/find_job_screen.dart';
import 'package:careshiftapp/views/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/utils.dart';
import 'booking/compnent/booking_test_screen.dart';



class AllBottomBer extends StatefulWidget {
  const AllBottomBer({super.key});

  @override
  State<AllBottomBer> createState() => _AllBottomBerState();
}

class _AllBottomBerState extends State<AllBottomBer> {

  int _selectedIndex = 0;

  static final List _screen = [
    HomeScreen(),
    // BookingScreen(),
    BookingTestScreen(),
    FindJobScreen(),

  ];

  void _itemIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _screen.elementAt(_selectedIndex),
          ),
          SafeArea(
            child: Container(
              height: 80.h,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24.r),
                      topRight: Radius.circular(24.r)
                  )
              ),
              child: BottomNavigationBar(

                type: BottomNavigationBarType.fixed,
                items: <BottomNavigationBarItem>[
                  ///---------------home---------------->
                  //
                  // BottomNavigationBarItem(
                  //   icon: SvgPicture.asset(
                  //     _selectedIndex == 0 ? AppIcons.homeSelectIcons : AppIcons.homeUnSelectIcons ,
                  //   ),
                  //   label: ''
                  // ),

                  ///--------------search---------------->
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      _selectedIndex == 0?  AppIcons.homeSelectIcon: AppIcons.homeIcon,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 0 ? AppColors.whiteColor : AppColors.greyColorA6A6A6,
                        BlendMode.srcIn, // This blend mode ensures the color is applied correctly
                      ),
                    ),
                    label: _selectedIndex == 0 ? 'Home': "",
                  ),
                  // /---------------Service---------------->
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      _selectedIndex ==1 ?  AppIcons.selectBook: AppIcons.bookingIcon,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 1 ? AppColors.whiteColor : AppColors.greyColorA6A6A6,
                        BlendMode.srcIn, // This blend mode ensures the color is applied correctly
                      ),
                    ),
                    label:  _selectedIndex == 1 ? 'Booking': "",

                  ),

                  ///---------------profile---------------->
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      _selectedIndex == 2 ? AppIcons.findSelected:AppIcons.jobIcon,
                      colorFilter: ColorFilter.mode(
                        _selectedIndex == 2 ? AppColors.whiteColor : AppColors.greyColorA6A6A6,
                        BlendMode.srcIn, // This blend mode ensures the color is applied correctly
                      ),
                    ),
                    label: _selectedIndex == 2 ? 'Find a Job' : "",
                  ),

                ],
                currentIndex: _selectedIndex,
                onTap: _itemIndex,
                iconSize: 20.h,
                selectedFontSize: 14.h,
                selectedLabelStyle: TextStyle(fontFamily: "Montserrat-Light"),
                unselectedLabelStyle: TextStyle(fontFamily: "Montserrat-Light"),
                selectedItemColor:AppColors.whiteColor,
                unselectedItemColor: Color(0xff6B6B6B),
                backgroundColor:Color(0xff066471),
              ),
            ),
          )
        ],
      )

    );
  }

}
