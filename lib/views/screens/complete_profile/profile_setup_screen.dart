
import 'dart:io';
import 'dart:typed_data';

import 'package:careshiftapp/routes/app_routes.dart';
import 'package:careshiftapp/utils/app_colors.dart';
import 'package:careshiftapp/views/widgets/custom_button_common.dart';
import 'package:careshiftapp/views/widgets/custom_text.dart';
import 'package:careshiftapp/views/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../controller/controllers.dart';
import '../../../services/services.dart';
import '../../../utils/utils.dart';
import '../../widgets/cachanetwork_image.dart';

class ProfileSetupScreen extends StatefulWidget {
   ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  Uint8List? _image;
  File? selectedIMage;

  String? selectedGender;
  final List<String> genders = ['Male', 'Female'];

  String? selectedSuburbs;
  final List<String> suburbs = ['mancester', 'Australia'];

  String? selectedState;
  final List<String> states = ['New South Wales','Queensland'];


  String? relationdState;
  final List<String> relations = [  "Parent",
    "Spouse / Partner",
    "Sibling",
    "Child",
    "Relative",
    "Housemate",
    "Neighbor",
    "Co-worker",
    "Manager / Supervisor",
    "Other"];

  String? aboutApp;
  final List<String> aboutApps = [
    "Google Search",
    "Facebook",
    "Instagram",
    "TikTok",
    "Referral from a Friend",
    "LinkedIn",
    "WhatsApp Group",
    "Another Cares/Nurse",
    "NDIS Provider",
    "Job Board (e.g. Seek, Indeed)",
    "Flyer or Poster",
    "Community Group or Event",
    "Other"
  ];


  DateTime? _startDate;

//language


  List<String> languages = [
    "English", "Spanish", "Punjabi", "Hindi", "Greek", "Italian", "Cantonese", "Vietnamese", "Mandarin", "Arabic"
  ];
  List<String> selectedLanguages = [];
  TextEditingController controller = TextEditingController();
  void _showMultiSelectDialog() async {
    final List<String>? results = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        List<String> tempSelected = List.from(selectedLanguages);
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
                  onPressed: () => Navigator.pop(context, tempSelected),  // Return the list directly
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
        selectedLanguages = List.from(results);  // Ensure it's a flat list
        controller.text = selectedLanguages.join(', ');  // Update text with comma-separated values
        print("Selected languages: $results"); // Debugging the final result
      });
    }
  }

  TextEditingController firstNameCNTRL = TextEditingController();
TextEditingController lastNameCNTRL = TextEditingController();
TextEditingController dateOfBirthCNTRL = TextEditingController();
TextEditingController phoneCNTRL = TextEditingController();
TextEditingController addressCNTRL = TextEditingController();
TextEditingController suburbCNTRL = TextEditingController();
TextEditingController emrFirstNameCNTRL = TextEditingController();
TextEditingController emrLastNameCNTRL = TextEditingController();
TextEditingController emrphoneCNTRL = TextEditingController();

  @override
  void dispose() {
    // Dispose all controllers when the widget is removed

    controller.dispose();
    firstNameCNTRL.dispose();
    lastNameCNTRL.dispose();
    dateOfBirthCNTRL.dispose();
    phoneCNTRL.dispose();
    addressCNTRL.dispose();
    emrFirstNameCNTRL.dispose();
    emrLastNameCNTRL.dispose();
    emrphoneCNTRL.dispose();
    selectedLanguages.clear();
    aboutApps.clear();
    super.dispose(); // Don't forget to call super.dispose() at the end
  }

  ProfileSetupController profileSetupController = Get.put(ProfileSetupController());
  @override
  Widget build(BuildContext context) {
    profileSetupController.getUserData();
    return Scaffold(

      appBar: AppBar(title: CustomText(text: "Profile Setup",fontWeight: FontWeight.w600,fontsize: 20.sp,color: AppColors.whiteColor,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Container(
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
                      padding:  EdgeInsets.all(12.r),
                      child: Container(
        
                        width: double.infinity,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r),color: AppColors.whiteColor),
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 16.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 64.h),
                            Center(child: CustomText(text: "Upload Photo*",color: AppColors.buttonPrimaryColor, fontWeight: FontWeight.w500,)),
                            SizedBox(height: 30.h),
                            CustomText(text: "Personal Details",fontWeight: FontWeight.w600, fontsize: 18.sp,color: AppColors.buttonPrimaryColor,),
                            SizedBox(height: 20.h),
        
                            ///First and last Name--------------------------------------------------
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
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
                            /// -----------------------Gender--------------------------------
                            CustomText(
                                text: "Gender*",
                                color: AppColors.buttonPrimaryColor,
                                fontWeight: FontWeight.w500
                            ),
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedGender,
                                  hint: Text(
                                    'Select Gender',
                                    style: TextStyle(color: AppColors.buttonPrimaryColor, fontSize: 11.sp),
                                  ),
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                                  items: genders.map((gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child: CustomText(
                                        text: gender,// Show capitalized text in the dropdown
                                        fontsize: 16.sp,
                                        color: AppColors.buttonPrimaryColor,
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedGender = value;  // Store the selected gender in lowercase
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h,),
                            SizedBox(height: 20.h,),
        
                            /// -----------------------Date of Birth--------------------------------
                            CustomText(text: "Date of Birth*",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500),
                            SizedBox(height: 6.h),
                            CustomTextField(
                              borderRadio: 20.h,
                              controller: dateOfBirthCNTRL,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              hintText: "23 April 2001",
                              suffixIcon: Icon(Icons.calendar_month,color: AppColors.buttonPrimaryColor,),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Date cannot be empty";
                                }
                                // if (!AppConstants.emailValidate.hasMatch(value)) {
                                //   return "Invalid email address";
                                // }
                                return null;
                              },
                            ),
        
        
                            /// ----------------------phone Number--------------------------------
                            SizedBox(height: 20.h),
                            CustomText(
                              text: "Phone Number*",
                              color: AppColors.buttonPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 6.h),
                            CustomTextField(
                              controller: phoneCNTRL,
                              hintText: "Enter Phone Number",
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Phone Number*";
                                }
                                return null;
                              },
                            ),
        
                            /// ----------------------Residential Address*-------------------------------
                            SizedBox(height: 20.h),
                            CustomText(
                              text: "Enter Residential Address*",
                              color: AppColors.buttonPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 6.h),
                            CustomTextField(
                              controller: addressCNTRL,
                              hintText: "Enter Residential Address",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Residential Address*";
                                }
                                return null;
                              },
                            ),
        
                            /// -----------------------Select Suburb--------------------------------
                            SizedBox(height: 20.h),
                            CustomText(text: "Suburb*",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500),
                            SizedBox(height: 6.h),
                            CustomTextField(
                              controller: suburbCNTRL,
                              hintText: "Suburb",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Your Suburb";
                                }
                                return null;
                              },
                            ),
        
                            // Container(
                            //   padding: EdgeInsets.symmetric(horizontal: 16.w),
                            //   decoration: BoxDecoration(
                            //     border: Border.all(color: AppColors.primaryColor),
                            //     borderRadius: BorderRadius.circular(16.r),
                            //   ),
                            //   child: DropdownButtonHideUnderline(
                            //     child: DropdownButton<String>(
                            //       value: selectedSuburbs,
                            //       hint: Text(
                            //         'Select Suburb',
                            //         style: TextStyle(color: AppColors.buttonPrimaryColor,fontSize: 11.sp),
                            //       ),
                            //       isExpanded: true,
                            //       icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                            //       items: suburbs.map((gender) {
                            //         return DropdownMenuItem<String>(
                            //           value: gender,
                            //           child:
                            //           CustomText(text: gender,fontsize: 12.sp,color: AppColors.buttonPrimaryColor,),
                            //         );
                            //       }).toList(),
                            //       onChanged: (value) {
                            //         setState(() {
                            //           selectedSuburbs = value;
                            //         });
                            //       },
                            //     ),
                            //   ),
                            // ),
        
        
                            /// -----------------------Select State--------------------------------
                            SizedBox(height: 20.h),
                            CustomText(text: "State*",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500),
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: selectedState,
                                  hint: Text(
                                    'Select State',
                                    style: TextStyle(color: AppColors.buttonPrimaryColor,fontSize: 11.sp),
                                  ),
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                                  items: states.map((gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child:
                                      CustomText(text: gender,fontsize: 12.sp,color: AppColors.buttonPrimaryColor,),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      selectedState = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h,),
        
        
                            /// -----------------------Select Language--------------------------------
                            CustomText(text: "Language(s) You Speak*", color: AppColors.buttonPrimaryColor, fontWeight: FontWeight.w500),
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
        
                            if (selectedLanguages.isNotEmpty) SizedBox(height: 10.h,),
                            if (selectedLanguages.isNotEmpty)
                              SizedBox(
                                height: 40,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: selectedLanguages.length,
                                  separatorBuilder: (_, __) => SizedBox(width: 8),
                                  itemBuilder: (context, index) {
                                    final lang = selectedLanguages[index];
                                    return Chip(
                                      label: Text(lang),
                                      onDeleted: () {
                                        setState(() {
                                          selectedLanguages.removeAt(index);
                                          controller.text = selectedLanguages.join(',');
                                        });
                                      },
                                    );
                                  },
                                ),
                              ),
        
        
        
                            SizedBox(height: 30.h),
                            CustomText(text: "Emergency Contact",fontWeight: FontWeight.w600, fontsize: 18.sp,color: AppColors.buttonPrimaryColor,),
                            SizedBox(height: 20.h),
        
                            ///First and last Name--------------------------------------------------
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "First Name*",
                                        color: AppColors.buttonPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 6.h),
                                      CustomTextField(
                                        controller: emrFirstNameCNTRL,
                                        hintText: "First Name",
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
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      CustomText(
                                        text: "Last Name*",
                                        color: AppColors.buttonPrimaryColor,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      SizedBox(height: 6.h),
                                      CustomTextField(
                                        controller: emrLastNameCNTRL,
                                        hintText: "Last Name",
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
                            /// ----------------------phone Number--------------------------------
        
                            CustomText(
                              text: "Phone Number*",
                              color: AppColors.buttonPrimaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(height: 6.h),
                            CustomTextField(
                              controller: emrphoneCNTRL,
                              hintText: "Phone Number",
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Phone Number*";
                                }
                                return null;
                              },
                            ),
        
        
                            SizedBox(height: 20.h),
                            CustomText(text: "Relationship*",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500),
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: relationdState,
                                  hint: Text(
                                    'Relation State',
                                    style: TextStyle(color: AppColors.buttonPrimaryColor,fontSize: 11.sp),
                                  ),
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                                  items: relations.map((gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child:
                                      CustomText(text: gender,fontsize: 12.sp,color: AppColors.buttonPrimaryColor,),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      relationdState = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h,),
        
                            CustomText(text: "How did you hear about our app?*",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500),
                            SizedBox(height: 6.h),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 16.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: aboutApp,
                                  hint: Text(
                                    'How did you hear about our app?',
                                    style: TextStyle(color: AppColors.buttonPrimaryColor,fontSize: 11.sp),
                                  ),
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                                  items: aboutApps.map((gender) {
                                    return DropdownMenuItem<String>(
                                      value: gender,
                                      child:
                                      CustomText(text: gender,fontsize: 12.sp,color: AppColors.buttonPrimaryColor,),
                                    );
                                  }).toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      aboutApp = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h,),
        
        
        
                            Obx(()=> CustomButtonCommon(title: "SAVE & CONTINUE",
                                loading: profileSetupController.isUpdateLoading.value == true,
                                onpress: (){
                              profileSetupController.upDateProfile(
                                  image: selectedIMage,
                                  firstName: firstNameCNTRL.text,
                                  lastName: lastNameCNTRL.text,
                                  languagesSpoken: selectedLanguages,
                                  residentialAddress: addressCNTRL.text,
                                  phoneNumber: phoneCNTRL.text,
                                  gender: selectedGender.toString(),
                                  dateOfBirth: dateOfBirthCNTRL.text,
                                  suburb: suburbCNTRL.text,
                                  state: selectedState,
                                  emergencyContactPhoneNumber: emrphoneCNTRL.text,
                                  emergencyContactFirstName: emrFirstNameCNTRL.text,
                                  emergencyContactLastName: emrLastNameCNTRL.text,
                                  emergencyContactRelationship: relationdState,
                                referralSourceEnum: aboutApp
                              );
        
                              // Get.toNamed(AppRoutes.profileSetupDocScreen,preventDuplicates: false);
        
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
                      child: Obx(()=>
                       SizedBox(
                          height: 130.h,
                          child: Stack(
                            children: [
                              _image != null
                                  ? CircleAvatar(
                                  radius: 60.r,
                                  backgroundImage:MemoryImage(_image!))
                              : profileSetupController.getUserResponseModel.value != ""
                                  ?Obx(()=>
                                  CustomNetworkImage(
                                    boxShape: BoxShape.circle,
                                    imageUrl: "${ApiConstants.imageBaseUrl}${profileSetupController.getUserResponseModel.value.image}" ,
                                    height: 120.h,
                                    width: 120.w,
                                  ),
                                  )
                                  : CircleAvatar(
                                  radius: 60.r,
                                  backgroundImage:AssetImage(AppImages.signUpImg)),
                              Positioned(
                                top: 84.h,
                                right: 0,
                                left: 84.w,
                                child: GestureDetector(
                                    onTap: (){
        
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
        dateOfBirthCNTRL.text = DateFormat('MM/dd/yyyy').format(_startDate!);
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
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 6.2,
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
      print(selectedIMage);
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
