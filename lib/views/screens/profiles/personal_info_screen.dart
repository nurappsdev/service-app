

import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../controller/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';
import '../../../routes/app_routes.dart';
import '../../../services/services.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  DateTime? _startDate;




//language

  List<String> languages = ["English", "Arabic", "Mandarin (Chinese)", "Cantonese", "Hindi", "Tamil", "Spanish"];
  List<String> selectedLanguages = [];
  TextEditingController controller = TextEditingController();

  // void _showMultiSelectDialog() async {
  //   final List<String>? results = await showDialog<List<String>>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       List<String> tempSelected = List.from(selectedLanguages);
  //       return StatefulBuilder(
  //         builder: (context, setStateDialog) {
  //           return AlertDialog(
  //             title: Text('Select Languages'),
  //             content: SingleChildScrollView(
  //               child: ListBody(
  //                 children: languages.map((lang) {
  //                   return CheckboxListTile(
  //                     value: tempSelected.contains(lang),
  //                     title: Text(lang),
  //                     controlAffinity: ListTileControlAffinity.leading,
  //                     onChanged: (bool? checked) {
  //                       setStateDialog(() {
  //                         if (checked == true) {
  //                           tempSelected.add(lang);
  //                         } else {
  //                           tempSelected.remove(lang);
  //                         }
  //                       });
  //                     },
  //                   );
  //                 }).toList(),
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () => Navigator.pop(context, tempSelected),  // Return the list directly
  //                 child: Text('Apply'),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  //
  //   if (results != null) {
  //     setState(() {
  //       selectedLanguages = List.from(results);  // Ensure it's a flat list
  //       controller.text = selectedLanguages.join(', ');  // Update text with comma-separated values
  //       print("Selected languages: $results"); // Debugging the final result
  //     });
  //   }
  // }


  void _showMultiSelectDialog() async {
    // Preselect the already selected languages
    final List<String> preselectedLanguages = List.from(userResponseModel.languagesSpoken ?? []);

    final List<String>? results = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        List<String> tempSelected = List.from(preselectedLanguages);  // Initial list is from existing data
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Select Languages'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: languages.map((lang) {
                    return CheckboxListTile(
                      value: tempSelected.contains(lang),
                      title: Text(lang),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (bool? checked) {
                        setStateDialog(() {
                          if (checked == true) {
                            tempSelected.add(lang);
                          } else {
                            tempSelected.remove(lang);
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, tempSelected),  // Return the updated list
                  child: Text('Apply'),
                ),
              ],
            );
          },
        );
      },
    );

    if (results != null) {
      setState(() {
        // Update the selected languages
        selectedLanguages = List.from(results);
        // Create a new instance of GetUserData with updated languages
        userResponseModel = userResponseModel.copyWith(languagesSpoken: selectedLanguages);
        // Update the model
        controller.text = selectedLanguages.join(', ');  // Update the text field with the selected languages
      });
    }
  }

  TextEditingController firstNameCNTRL = TextEditingController();
  TextEditingController lastNameCNTRL = TextEditingController();
  TextEditingController dateOfBirthCNTRL = TextEditingController();
  TextEditingController phoneCNTRL = TextEditingController();
  TextEditingController addressCNTRL = TextEditingController();
  TextEditingController emrFirstNameCNTRL = TextEditingController();
  TextEditingController emrLastNameCNTRL = TextEditingController();
  TextEditingController emrphoneCNTRL = TextEditingController();
  TextEditingController egenderCNTRL = TextEditingController();
  Uint8List? _image;
  File? selectedIMage;
  GetUserData userResponseModel = Get.arguments as GetUserData;
  ProfileSetupController profileSetupController = Get.put(ProfileSetupController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(userResponseModel != null){
      firstNameCNTRL.text = userResponseModel.firstName ?? "";
      lastNameCNTRL.text = userResponseModel.lastName ?? "";
      egenderCNTRL.text = userResponseModel.gender ?? "";
      if (userResponseModel.dateOfBirth != null) {
        dateOfBirthCNTRL.text = TimeFormatHelper.formatDate(
            DateTime.parse(userResponseModel.dateOfBirth!.toIso8601String())
        );
      } else {
        // Handle the case when dateOfBirth is null (e.g., set default text or leave empty)
        dateOfBirthCNTRL.text = "Date of Birth not available"; // You can customize this text as needed
      }
      addressCNTRL.text = userResponseModel.residentialAddress ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          title: CustomText(text: "Personal Info ",
            fontWeight: FontWeight.w600,
            fontsize: 20.sp,
            color: AppColors.whiteColor,),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        backgroundColor: AppColors.primaryColor,
        body: Container(
          height: Get.height,
          width: double.infinity,
          child: SingleChildScrollView(
            child: Stack(
              fit: StackFit.loose,
              children: [
                Column(
                  children: [
                    SizedBox(height: 60.h),
                    Padding(
                      padding: EdgeInsets.all(12.r),
                      child: Container(
      
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.r),
                            color: AppColors.whiteColor),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 64.h),
                              Center(child: CustomText(text: "Upload Photo*",
                                color: AppColors.buttonPrimaryColor,
                                fontWeight: FontWeight.w500,)),
                              SizedBox(height: 30.h),
                              CustomText(text: "Personal Details",
                                fontWeight: FontWeight.w600,
                                fontsize: 18.sp,
                                color: AppColors.buttonPrimaryColor,),
                              SizedBox(height: 20.h),
      
                              ///First and last Name--------------------------------------------------
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        CustomText(
                                          text: "First Name*",
                                          color: AppColors.buttonPrimaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 6.h),
                                        CustomTextField(
                                          controller: firstNameCNTRL,
                                          hintText: "Enter first Name",
                                          hinTextColor: AppColors.buttonPrimaryColor,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "First Name";
                                            }
                                            return null;
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(width: 16.w),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        CustomText(
                                          text: "Last Name*",
                                          color: AppColors.buttonPrimaryColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        SizedBox(height: 6.h),
                                        CustomTextField(
                                          controller: lastNameCNTRL,
                                          hintText: "Enter last Name",
                                          hinTextColor: AppColors.buttonPrimaryColor,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return "Last Name";
                                            }
                                            return null;
                                          },
      
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h,),
      
                              /// -----------------------Gender--------------------------------
                              CustomText(text: "Gender*",
                                  color: AppColors.buttonPrimaryColor,
                                  fontWeight: FontWeight.w500),
                              SizedBox(height: 6.h),
                              CustomTextField(
                                controller: egenderCNTRL,
                                readOnly: true,
                                keyboardType: TextInputType.none,
                                hintText: "Male",
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "First Name";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.h,),
      
                              /// -----------------------Date of Birth--------------------------------
                              CustomText(text: "Date of Birth*",
                                  color: AppColors.buttonPrimaryColor,
                                  fontWeight: FontWeight.w500),
                              SizedBox(height: 6.h),
                              CustomTextField(
                                borderRadio: 20.h,
                                controller: dateOfBirthCNTRL,
                                readOnly: true,
                                onTap: () => _selectDate(context),
                                hintText: "23 April 2001",
                                suffixIcon: Icon(Icons.calendar_month,
                                  color: AppColors.buttonPrimaryColor,),
                                validator: (value) {
                                  // if (value == null || value.isEmpty) {
                                  //   return "BirthDate cannot be empty";
                                  // }
                                  // // if (!AppConstants.emailValidate.hasMatch(value)) {
                                  // //   return "Invalid email address";
                                  // // }
                                  // return null;
                                },
                              ),
      
      
                              /// ----------------------phone Number--------------------------------
                              //SizedBox(height: 20.h),
                              // CustomText(
                              //   text: "Phone Number*",
                              //   color: AppColors.buttonPrimaryColor,
                              //   fontWeight: FontWeight.w500,
                              // ),
                              // SizedBox(height: 6.h),
                              // CustomTextField(
                              //   controller: phoneCNTRL,
                              //   hintText: "Phone Number",
                              //   hinTextColor: AppColors.buttonPrimaryColor,
                              //   keyboardType: TextInputType.number,
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return "Phone Number*";
                              //     }
                              //     return null;
                              //   },
                              // ),
      
                              /// ----------------------Residential Address*-------------------------------
                              SizedBox(height: 20.h),
                              CustomText(
                                text: "Residential Address*",
                                color: AppColors.buttonPrimaryColor,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 6.h),
                              CustomTextField(
                                controller: addressCNTRL,
                                hintText: "Residential Address",
                                hinTextColor: AppColors.buttonPrimaryColor,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Residential Address*";
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.h,),
      
      
                              /// -----------------------Select Language--------------------------------
      
                              CustomText(text: "Language(s) You Speak*",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500),
                              SizedBox(height: 6.h),
                              GestureDetector(
                                onTap: _showMultiSelectDialog,
                                child: AbsorbPointer(
                                  child: CustomTextField(
                                    controller: controller,
                                    suffixIcon: Icon(Icons.keyboard_arrow_down),
                                    hintText: "Select Language",
                                  ),
                                ),
                              ),
      
                              if (userResponseModel.languagesSpoken!.isNotEmpty)   SizedBox(height: 10.h,),
                              // if (userResponseModel.languagesSpoken!.isNotEmpty)
                              //   SizedBox(
                              //     height: 40,
                              //     child: ListView.separated(
                              //       scrollDirection: Axis.horizontal,
                              //       itemCount: userResponseModel.languagesSpoken!.length,
                              //       separatorBuilder: (_, __) => SizedBox(width: 8),
                              //       itemBuilder: (context, index) {
                              //         final lang = userResponseModel.languagesSpoken![index];
                              //         return Chip(
                              //           label: Text(lang),
                              //           onDeleted: () {
                              //             setState(() {
                              //               userResponseModel.languagesSpoken!.removeAt(index);
                              //               controller.text = userResponseModel.languagesSpoken!.join(', ');
                              //             });
                              //           },
                              //         );
                              //       },
                              //     ),
                              //   ),
                              //
      
                              // CustomText(text: "Language(s) You Speak*",
                              //     color: AppColors.buttonPrimaryColor,
                              //     fontWeight: FontWeight.w500),
                              // SizedBox(height: 6.h),
                              // GestureDetector(
                              //   onTap: _showMultiSelectDialog,
                              //   child: AbsorbPointer(
                              //     child: CustomTextField(
                              //       controller: controller,
                              //       suffixIcon: Icon(Icons.keyboard_arrow_down),
                              //       hintText: "Select Language",
                              //       hinTextColor: AppColors.buttonPrimaryColor,
                              //     ),
                              //   ),
                              // ),
      
                              if (userResponseModel.languagesSpoken != null && userResponseModel.languagesSpoken!.isNotEmpty)
                                SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: userResponseModel.languagesSpoken!.length,
                                    separatorBuilder: (_, __) => SizedBox(width: 8),
                                    itemBuilder: (context, index) {
                                      final lang = userResponseModel.languagesSpoken![index];
                                      return Chip(
                                        label: Text(lang),
                                        onDeleted: () {
                                          setState(() {
                                            userResponseModel.languagesSpoken!.removeAt(index);
                                            controller.text = userResponseModel.languagesSpoken!.join(', ');
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ),
                              SizedBox(height: 20.h,),
      
                              Obx(()=>
                                  CustomButtonCommon(
                                      loading: profileSetupController.againIsUpdateLoading.value == true,
                                      title: "Update", onpress: () {
                                    profileSetupController.againUpDateProfile(
                                        firstName: firstNameCNTRL.text,
                                        lastName: lastNameCNTRL.text,
                                        gender: egenderCNTRL.text,
                                        image: selectedIMage,
                                        dateOfBirth: dateOfBirthCNTRL.text,
                                        residentialAddress: addressCNTRL.text,
                                        languagesSpoken: selectedLanguages );
                                    // Get.toNamed(AppRoutes.profileScreen,preventDuplicates: false);
                                    // Get.toNamed(AppRoutes.profileSetupDocScreen,
                                    //     preventDuplicates: false);
                                  }),
                              ),
      
                              SizedBox(height: 20.h,),
                            ],
                          ),
                        ),
                      ),
                    ),
      
                  ],
                ),
                Positioned(
                  top: 10.h,
                  right: 130,
                  child:
                  Center(
                    child: SizedBox(
                      height: 130.h,
                      child: Stack(
                        children: [
                          _image != null
                              ? CircleAvatar(
                              radius: 60.r,
                              backgroundImage: MemoryImage(_image!))
                              :
                          userResponseModel.image != ""
                              ?  CustomNetworkImage(
                            boxShape: BoxShape.circle,
                            imageUrl: "${ApiConstants.imageBaseUrl}${userResponseModel.image}" ,
                            height: 120.h,
                            width: 120.w,
                          )
                              : CircleAvatar(
                              radius: 60.r,
                              backgroundImage: AssetImage(AppImages.signUpImg)),
                          Positioned(
                            top: 80.h,
                            right: 0,
                            left: 86.w,
                            child: GestureDetector(
                                onTap: () {
                                  showImagePickerOption(context);
                                },
                                child: CircleAvatar(
                                    backgroundColor: AppColors.buttonPrimaryColor,
                                    child: Icon(Icons.camera_alt_sharp,size: 16,color: AppColors.whiteColor,))),
                          )
                        ],
                      ),),
                  ),
      
                ),
      
      
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _selectDate(BuildContext context,) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        _startDate = selectedDate;
        dateOfBirthCNTRL.text = DateFormat('dd MMM, yyyy').format(_startDate!);
      });
    }
  }

  //==================================> ShowImagePickerOption Function <===============================
  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
        backgroundColor: Colors.white,
        context: context,
        builder: (builder) {
          return Padding(
            padding: const EdgeInsets.all(18.0),
            child: SizedBox(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 6.2,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromGallery();

                        // _pickImageFromGallery();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.image,
                              size: 50.w,
                            ),
                            CustomText(text: 'Gallery')
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        _pickImageFromCamera();

                        // _pickImageFromCamera();
                      },
                      child: SizedBox(
                        child: Column(
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 50.w,
                            ),
                            CustomText(text: 'Camera')
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //==================================> Gallery <===============================
  Future _pickImageFromGallery() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }

//==================================> Camera <===============================
  Future _pickImageFromCamera() async {
    final returnImage =
    await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedIMage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    Get.back();
  }

}