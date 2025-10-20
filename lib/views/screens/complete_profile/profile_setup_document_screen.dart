
import 'dart:io';

import 'package:careshiftapp/routes/app_routes.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' show DateFormat;


import '../../../controller/controllers.dart';
import '../../../models/document/document_response_model.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class ProfileSetupDocumentScreen extends StatefulWidget {
   ProfileSetupDocumentScreen({super.key});

  @override
  State<ProfileSetupDocumentScreen> createState() => _ProfileSetupDocumentScreenState();
}

class _ProfileSetupDocumentScreenState extends State<ProfileSetupDocumentScreen> {

   DateTime? _startDate;
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
         passportDateCNTRL.text = DateFormat('yyyy-MM-dd').format(_startDate!);
       });
     }
   }


   void _selectCarDate(BuildContext context,) async {
     DateTime? selectedDate = await showDatePicker(
       context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(1950),
       lastDate: DateTime.now(),
     );

     if (selectedDate != null) {
       setState(() {
         _startDate = selectedDate;
         carController.text = DateFormat('yyyy-MM-dd').format(_startDate!);
       });
     }
   }


   void _selectDriveDate(BuildContext context,) async {
     DateTime? selectedDate = await showDatePicker(
       context: context,
       initialDate: DateTime.now(),
       firstDate: DateTime(1950),
       lastDate: DateTime.now(),
     );

     if (selectedDate != null) {
       setState(() {
         _startDate = selectedDate;
         driveController.text = DateFormat('yyyy-MM-dd').format(_startDate!);
       });
     }
   }
   String? selectedSuburbs;




///----------------policeCheck-----------------------------------
   final List<String> suburbs = ['mancester', 'Australia'];
   // List<DocItem> docs = [];
   // List<DocItem> docs = [DocItem()];

   Future<void> _policeCheckSelectDate(BuildContext context, int index) async {
     DateTime? picked = await showDatePicker(
       context: context,
       initialDate: profileSetupController.policeCheckLocalList[index].selectedDate ?? DateTime.now(),
       firstDate: DateTime(1900),
       lastDate: DateTime.now(),
     );
     if (picked != null) {
       setState(() {
         profileSetupController.policeCheckLocalList[index].selectedDate = picked;
         profileSetupController.policeCheckLocalList[index].policeDateController.text = "${picked.toLocal()}".split(' ')[0];
       });
     }
   }
   ///----------------policeCheck-----------------------------------




   ///--------------Qualification-------------------------
   Future<void> _qualificationDateSelectDate(BuildContext context, int index) async {
     DateTime? picked = await showDatePicker(
       context: context,
       initialDate: profileSetupController.qualificationLocalList[index].selectedDate ?? DateTime.now(),
       firstDate: DateTime(1900),
       lastDate: DateTime.now(),
     );
     if (picked != null) {
       setState(() {
         profileSetupController.qualificationLocalList[index].selectedDate = picked;
         profileSetupController.qualificationLocalList[index].qualificationDateController.text = "${picked.toLocal()}".split(' ')[0];
       });
     }
   }
   ///--------------Qualification-------------------------

   ///--------------firstAidDate-------------------------
   Future<void> firstAidDate(BuildContext context, int index) async {
     DateTime? picked = await showDatePicker(
       context: context,
       initialDate: profileSetupController.aidCprLocalList[index].selectedDate ?? DateTime.now(),
       firstDate: DateTime(1900),
       lastDate: DateTime.now(),
     );
     if (picked != null) {
       setState(() {
         profileSetupController.aidCprLocalList[index].selectedDate = picked;
         profileSetupController.aidCprLocalList[index].aidCPRDateController.text = "${picked.toLocal()}".split(' ')[0];
       });
     }
   }
   ///--------------Qualification-------------------------


   @override
   void initState() {
     super.initState();
     // docs.add(DocItem());
     profileSetupController.policeCheckLocalList.add(DocItem());
     profileSetupController.qualificationLocalList.add(DocItem());
     profileSetupController.aidCprLocalList.add(DocItem());
     profileSetupController.vaccinationLocalList.add(DocItem());

     // Add initial one item
   }



   TextEditingController carController = TextEditingController();
   TextEditingController passportDateCNTRL = TextEditingController();
   TextEditingController driveController = TextEditingController();
   TextEditingController workChildDateController = TextEditingController();
   TextEditingController abnController = TextEditingController();
   TextEditingController businessNameController = TextEditingController();
   TextEditingController BSBController = TextEditingController();
   TextEditingController accountNoController = TextEditingController();
   RxBool isChecked = false.obs;
   ProfileSetupController profileSetupController = Get.find<ProfileSetupController>();


@override
  void dispose() {
    // TODO: implement dispose
  carController.dispose();
  passportDateCNTRL.dispose();
  driveController.dispose();
  workChildDateController.dispose();
  abnController.dispose();
  businessNameController.dispose();
  BSBController.dispose();
  accountNoController.dispose();
  profileSetupController.aidCprLocalList.clear();
  profileSetupController.vaccinationLocalList.clear();
  profileSetupController.policeCheckLocalList.clear();
  profileSetupController.qualificationLocalList.clear();
    super.dispose();
  }





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
        appBar: AppBar(title: CustomText(text: "Document",fontWeight: FontWeight.w600,fontsize: 20.sp,color: AppColors.whiteColor,),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              children: [



                // SizedBox(height: 10.h),
                // Center(child: SizedBox(width: double.infinity, child: CustomSlider())),
                SizedBox(height: 20.h),
                CustomText(text: "Please upload your identification documents,\n certifications and qualifications to complete your profile.",fontsize: 11.sp,maxline: 3,color: AppColors.whiteColor,),
                SizedBox(height: 30.h),



                ///-----Passport---------------------------
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r),color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                        Image.asset("assets/images/passportIcon.png", width: 32.w,height: 48.h),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(text: "Passport*",color: AppColors.buttonPrimaryColor,fontsize: 16.sp,fontWeight: FontWeight.w600
                              ,),
                          )
                      ],),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(width: 50.w),
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              contentPaddingVertical: 8.r,
                              borderRadio: 20.h,
                              filColor: Color(0xffEAF8F9),
                              controller: passportDateCNTRL,
                              readOnly: true,
                              onTap: () => _selectDate(context),
                              hintText: "Enter expiry date",
                              // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter expiry date cannot be empty";
                                }
                                // if (!AppConstants.emailValidate.hasMatch(value)) {
                                //   return "Invalid email address";
                                // }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Expanded(
                            flex: 2,
                            // child: Container(
                            //   height: 54.h,
                            //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color(0xFF0E515F),),
                            // child: Row(
                            //   crossAxisAlignment: CrossAxisAlignment.center,
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //   Icon(
                            //     Icons.upload_rounded,
                            //     size: 12.sp,
                            //     color: Colors.white,
                            //   ),
                            //   SizedBox(width: 10.w,),
                            //   CustomText(text: "upload",color: AppColors.whiteColor,fontsize: 12.sp,)
                            // ],),
                            // )
                            child:UploadButton(
                              buttonText: profileSetupController.pickedPassportFilePath == null
                                  ? "Upload"
                                  : "Uploaded",
                              onPressed: () async {
                                FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['pdf', 'jpeg', 'png'],
                                );

                                if (result != null && result.files.isNotEmpty) {
                                  final path = result.files.single.path!;
                                  final file = File(path);

                                  // Upload file and get the server path
                                  final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                  if (uploadedUrl != null) {
                                    setState(() {
                                      profileSetupController.pickedPassportFilePath = uploadedUrl;
                                    });
                                    print("📄 Uploaded URL: $uploadedUrl");
                                  }
                                }
                              },
                            ),
                          ),
                          SizedBox(width: 10.w),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),



                ///-----Driving License---------------------------
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r),color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                          Image.asset(AppImages.driveIcon, width: 32.w,height: 48.h),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(text: "Driving License (If Applicable)",color: AppColors.buttonPrimaryColor,fontsize: 16.sp,fontWeight: FontWeight.w600
                              ,),
                          )
                        ],),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(width: 50.w),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                SizedBox(height: 60.h),
                                CustomTextField(
                                  contentPaddingVertical: 6.r,
                                  borderRadio: 20.h,
                                  filColor: Color(0xffEAF8F9),
                                  controller: driveController,
                                  readOnly: true,
                                  onTap: () => _selectDriveDate(context),
                                  hintText: "Enter expiry date",
                                  // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "date cannot be empty";
                                    }
                                    // if (!AppConstants.emailValidate.hasMatch(value)) {
                                    //   return "Invalid email address";
                                    // }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                UploadButton(buttonText: profileSetupController.driveFontFilePath == null
                                    ? "Upload"
                                    : "Uploaded",
                                  onPressed: () async {
                                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf', 'jpeg', 'png'],
                                    );

                                    if (result != null && result.files.isNotEmpty) {
                                      final path = result.files.single.path!;
                                      final file = File(path);

                                      // Upload file and get the server path
                                      final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                      if (uploadedUrl != null) {
                                        setState(() {
                                          profileSetupController.driveFontFilePath  = uploadedUrl;
                                        });
                                        print("📄 Uploaded URL: $uploadedUrl");
                                      }
                                    }
                                  },
                                ),
                                SizedBox(height: 6.h,),
                                UploadButton(buttonText: profileSetupController.driveBackFilePath == null
                                    ? "Upload"
                                    : "Uploaded",
                                  onPressed: () async {
                                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf', 'jpeg', 'png'],
                                    );

                                    if (result != null && result.files.isNotEmpty) {
                                      final path = result.files.single.path!;
                                      final file = File(path);

                                      // Upload file and get the server path
                                      final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                      if (uploadedUrl != null) {
                                        setState(() {
                                          profileSetupController.driveBackFilePath  = uploadedUrl;
                                        });
                                        print("📄 Uploaded URL: $uploadedUrl");
                                      }
                                    }
                                  },
                                ),
                              ],

                            ),
                          ),
                          SizedBox(width: 10.w),
                        ],
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),




                ///---------police check------------------------
                SizedBox(height: 20.h),
                Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  color: AppColors.whiteColor,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 10.w),
                        Image.asset(AppImages.policeIcon, width: 32.w, height: 48.h),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CustomText(
                            text: "Police Check or NDIS \nWorker Screening Check*",
                            color: AppColors.buttonPrimaryColor,
                            fontsize: 16.sp,
                            fontWeight: FontWeight.w600,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    ...profileSetupController.policeCheckLocalList.asMap().entries.map((entry) {
                      int index = entry.key;
                      DocItem doc = entry.value;
                      return Column(
                        key: ValueKey(index),
                        children: [
                          SizedBox(height: 10.h),
                          Padding(
                            padding: EdgeInsets.only(right: 8.w, left: 50.w),
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w),
                              decoration: BoxDecoration(
                                border: Border.all(color: AppColors.primaryColor),
                                borderRadius: BorderRadius.circular(16.r),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: doc.selectedDropdownData,
                                  hint: Text(
                                    'Dropdown',
                                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
                                  ),
                                  isExpanded: true,
                                  icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                                  items: profileSetupController.policeCheckDropdown.map((suburb) => DropdownMenuItem<String>(
                                    value: suburb,
                                    child: CustomText(
                                      text: suburb,
                                      fontsize: 12.sp,
                                      color: AppColors.buttonPrimaryColor,
                                    ),
                                  ))
                                      .toList(),
                                  onChanged: (value) {
                                    setState(() {
                                      doc.selectedDropdownData = value;
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(width: 50.w),
                              Expanded(
                                flex: 3,
                                child: CustomTextField(
                                  contentPaddingVertical: 6.r,
                                  borderRadio: 20.h,
                                  filColor: Color(0xffEAF8F9),
                                  controller: doc.policeDateController,
                                  readOnly: true,
                                  onTap: () => _policeCheckSelectDate(context, index),
                                  hintText: "Enter publish date",
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Date cannot be empty";
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              SizedBox(width: 10.w),
                              Expanded(
                                flex: 2,
                                child: UploadButton(
                                  buttonText:

                                  profileSetupController.policeCheckLocalList[index].pickedFilePath == null
                                      ? "Upload"
                                      : "Uploaded",
                                  onPressed: () async {
                                    FilePickerResult? result = await FilePicker.platform.pickFiles(
                                      type: FileType.custom,
                                      allowedExtensions: ['pdf', 'jpeg', 'png'],
                                    );

                                    if (result != null && result.files.isNotEmpty) {
                                      final path = result.files.single.path!;
                                      final file = File(path);

                                      // Upload file and get the server path
                                      final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                      if (uploadedUrl != null) {
                                        setState(() {
                                          profileSetupController.policeCheckLocalList[index].pickedFilePath = uploadedUrl;
                                        });
                                        print("📄 Uploaded URL: $uploadedUrl");
                                      }
                                    }
                                  },
                                ),


                                //   doc.pickedFilePath == null ? "Upload" : "Uploaded",
                                //   onPressed: () async {
                                //     FilePickerResult? result = await FilePicker.platform.pickFiles(
                                //       type: FileType.custom,
                                //       allowedExtensions: ['pdf', 'jpeg', 'png'],
                                //     );
                                //     if (result != null && result.files.isNotEmpty) {
                                //       setState(() {
                                //         doc.pickedFilePath = result.files.single.path;
                                //       });
                                //     }
                                //   },
                                // ),
                              ),
                              SizedBox(width: 10.w),
                              if (index != 0) // First item fixed, no delete button
                                IconButton(
                                  color:Colors.grey,
                                  icon: Icon(Icons.delete_forever, color: Colors.red),
                                  onPressed: () {
                                    setState(() {
                                      profileSetupController.policeCheckLocalList.removeAt(index);
                                    });
                                  },
                                ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                        ],
                      );
                    }).toList(),

                    Padding(
                      padding: EdgeInsets.only(left: 50.w, right: 10),
                      child: CustomButton(
                        title: "+ Add More Doc",
                        titlecolor: AppColors.buttonPrimaryColor,
                        onpress: () {
                          setState(() {
                            profileSetupController.policeCheckLocalList.add(DocItem());
                          });
                        },
                      ),
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),




                SizedBox(height: 20.h),
                ///-----Car Insurance-------------------------
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r),color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                          Image.asset(AppImages.carInsImg, width: 32.w,height: 48.h),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(text: "Car Insurance Certificate \n(If Applicable)",color: AppColors.buttonPrimaryColor,fontsize: 16.sp,fontWeight: FontWeight.w600,textAlign: TextAlign.start
                              ,),
                          )
                        ],),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(width: 50.w),
                          Expanded(
                            flex: 3,
                            child: Column(
                              children: [
                                SizedBox(height: 10.h),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12.w),
                                  decoration: BoxDecoration(
                                    border: Border.all(color: AppColors.primaryColor),
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                  child: DropdownButtonHideUnderline(
                                    child: DropdownButton<String>(
                                      value: profileSetupController.selectedCarInsDropdown,
                                      hint: Text(
                                        'Dropdown',
                                        style: TextStyle(color: Colors.grey.shade600,fontSize: 12.sp),
                                      ),
                                      isExpanded: true,
                                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
                                      items: profileSetupController.carInsDropdown.map((gender) {
                                        return DropdownMenuItem<String>(
                                          value: gender,
                                          child:
                                          CustomText(text: gender,fontsize: 12.sp,color: AppColors.buttonPrimaryColor,),
                                        );
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          profileSetupController.selectedCarInsDropdown = value;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.h),
                                CustomTextField(
                                  contentPaddingVertical: 6.r,
                                  borderRadio: 20.h,
                                  filColor: Color(0xffEAF8F9),
                                  controller: carController,
                                  readOnly: true,
                                  onTap: () => _selectCarDate(context),
                                  hintText: "Enter expiry date",
                                  // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
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
                                SizedBox(height: 12.h),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child:
                            Padding(
                              padding:  EdgeInsets.only(top: 70.h,left: 10.w,),
                              child: UploadButton(buttonText:
                              profileSetupController.pickedCarFilePath == null
                                  ? "Upload"
                                  : "Uploaded",
                                onPressed: () async {
                                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf', 'jpeg', 'png'],
                                  );

                                  if (result != null && result.files.isNotEmpty) {
                                    final path = result.files.single.path!;
                                    final file = File(path);

                                    // Upload file and get the server path
                                    final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                    if (uploadedUrl != null) {
                                      setState(() {
                                        profileSetupController.pickedCarFilePath  = uploadedUrl;
                                      });
                                      print("📄 Uploaded URL: $uploadedUrl");
                                    }
                                  }
                                },
                              ),

                            ),

                          ),
                          SizedBox(width: 10.w),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),





        ///---------Qualification-----------------------
                SizedBox(height: 20.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                          Image.asset(AppImages.qualiImg, width: 32.w, height: 48.h),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: "Qualification",
                              color: AppColors.buttonPrimaryColor,
                              fontsize: 16.sp,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ...profileSetupController.qualificationLocalList.asMap().entries.map((entry) {
                        int index = entry.key;
                        DocItem data = entry.value;

                        return Column(
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.only(right: 8.w,left: 50.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: data.selectedDropdownData,
                                    hint: Text(
                                      'Dropdown',
                                      style: TextStyle(color: Colors.grey.shade600,fontSize: 12.sp),
                                    ),
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: Colors.grey.shade700),
                                    items: profileSetupController.qualificationDropdown.map((suburb) {
                                      return DropdownMenuItem<String>(
                                        value: suburb,
                                        child: CustomText(
                                          text: suburb,
                                          fontsize: 12.sp,
                                          color: AppColors.buttonPrimaryColor,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        data.selectedDropdownData = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                SizedBox(width: 50.w),
                                Expanded(
                                  flex:3,
                                  child: CustomTextField(
                                    contentPaddingVertical: 6.r,
                                    borderRadio: 20.h,
                                    filColor: Color(0xffEAF8F9),
                                    controller: data.qualificationDateController,
                                    readOnly: true,
                                    onTap: () => _qualificationDateSelectDate(context, index),
                                    hintText: "Enter expiry date",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "BirthDate cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  flex:2,
                                  child: UploadButton(
                                    buttonText:
                                    profileSetupController.qualificationLocalList[index].pickedFilePath == null
                                        ? "Upload"
                                        : "Uploaded",
                                    onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['pdf', 'jpeg', 'png'],
                                      );

                                      if (result != null && result.files.isNotEmpty) {
                                        final path = result.files.single.path!;
                                        final file = File(path);

                                        // Upload file and get the server path
                                        final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                        if (uploadedUrl != null) {
                                          setState(() {
                                            profileSetupController.qualificationLocalList[index].pickedFilePath = uploadedUrl;
                                          });
                                          print("📄 Uploaded URL: $uploadedUrl");
                                        }
                                      }
                                    },
                                  ),
                                  //   profileSetupController.qualificationLocalList[index].pickedFilePath == null
                                  //       ? "Upload"
                                  //       : "Uploaded",
                                  //   onPressed: ()async{
                                  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  //       type: FileType.custom,
                                  //       allowedExtensions: ['pdf', 'jpeg'],
                                  //     );
                                  //
                                  //     if (result != null && result.files.isNotEmpty) {
                                  //       setState(() {
                                  //         profileSetupController.qualificationLocalList[index].pickedFilePath = result.files.single.path;
                                  //       });
                                  //       print("file location:::___+++___+++:  ${profileSetupController.qualificationLocalList[index].pickedFilePath}");
                                  //     }
                                  //   },
                                  // ),
                                ),
                                SizedBox(width: 10.w),
                                if (index != 0) // First item fixed, no delete button
                                  IconButton(
                                    color:Colors.grey,
                                    icon: Icon(Icons.delete_forever, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        profileSetupController.qualificationLocalList.removeAt(index);
                                      });
                                    },
                                  ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      }).toList(),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w,right: 10),
                        child: CustomButton(
                          title: "+ Add More Doc",
                          titlecolor: AppColors.buttonPrimaryColor,
                          onpress: () {
                            setState(() {
                              profileSetupController.qualificationLocalList.add(DocItem());
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),




                ///---------First AID/CPR-----------------------
                SizedBox(height: 20.h),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                          Image.asset(AppImages.aidImg, width: 32.w, height: 48.h),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: "First AID/CPR",
                              color: AppColors.buttonPrimaryColor,
                              fontsize: 16.sp,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ...profileSetupController.aidCprLocalList.asMap().entries.map((entry) {
                        int index = entry.key;
                        DocItem data = entry.value;

                        return Column(
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.only(right: 8.w,left: 50.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: data.selectedDropdownData,
                                    hint: Text(
                                      'Dropdown',
                                      style: TextStyle(color: Colors.grey.shade600,fontSize: 12.sp),
                                    ),
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: Colors.grey.shade700),
                                    items: profileSetupController.aidCprDropdown.map((suburb) {
                                      return DropdownMenuItem<String>(
                                        value: suburb,
                                        child: CustomText(
                                          text: suburb,
                                          fontsize: 12.sp,
                                          color: AppColors.buttonPrimaryColor,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        data.selectedDropdownData = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                SizedBox(width: 50.w),
                                Expanded(
                                  flex:3,
                                  child: CustomTextField(
                                    contentPaddingVertical: 6.r,
                                    borderRadio: 20.h,
                                    filColor: Color(0xffEAF8F9),
                                    controller: data.aidCPRDateController,
                                    readOnly: true,
                                    onTap: ()=> firstAidDate(context, index),
                                    // async{
                                    //   DateTime? picked = await showDatePicker(
                                    //     context: context,
                                    //     initialDate: DateTime.now(),
                                    //     firstDate: DateTime(1900),
                                    //     lastDate: DateTime.now(),
                                    //   );
                                    //   if (picked != null) {
                                    //     setState(() {
                                    //       profileSetupController.aidCprLocalList[index].selectedDate = picked;
                                    //       profileSetupController.aidCprLocalList[index].aidCPRDateController.text = "${picked.toLocal()}".split(' ')[0];
                                    //     });
                                    //   }
                                    //
                                    // },
                                    hintText: "Enter expiry date",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Date cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  flex: 2,
                                  child: UploadButton(
                                    buttonText: profileSetupController.aidCprLocalList[index].pickedFilePath == null
                                        ? "Upload"
                                        : "Uploaded",
                                    onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['pdf', 'jpeg', 'png'],
                                      );

                                      if (result != null && result.files.isNotEmpty) {
                                        final path = result.files.single.path!;
                                        final file = File(path);

                                        // Upload file and get the server path
                                        final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                        if (uploadedUrl != null) {
                                          setState(() {
                                            profileSetupController.aidCprLocalList[index].pickedFilePath = uploadedUrl;
                                          });
                                          print("📄 Uploaded URL: $uploadedUrl");
                                        }
                                      }
                                    },
                                  ),
                                  //   profileSetupController.aidCprLocalList[index].pickedFilePath == null
                                  //       ? "Upload"
                                  //       : "Uploaded",
                                  //   onPressed: ()async{
                                  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  //       type: FileType.custom,
                                  //       allowedExtensions: ['pdf', 'jpeg'],
                                  //     );
                                  //
                                  //     if (result != null && result.files.isNotEmpty) {
                                  //       setState(() {
                                  //         profileSetupController.aidCprLocalList[index].pickedFilePath = result.files.single.path;
                                  //       });
                                  //       print("file location:::___+++___+++:  ${profileSetupController.aidCprLocalList[index].pickedFilePath}");
                                  //     }
                                  //   },
                                  // ),
                                ),
                                if (index != 0) // First item fixed, no delete button
                                  IconButton(
                                    color:Colors.grey,
                                    icon: Icon(Icons.delete_forever, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        profileSetupController.aidCprLocalList.removeAt(index);
                                      });
                                    },
                                  ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      }).toList(),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w,right: 10),
                        child: CustomButton(
                          title: "+ Add More Doc",
                          titlecolor: AppColors.buttonPrimaryColor,
                          onpress: () {
                            setState(() {
                              profileSetupController.aidCprLocalList.add(DocItem());
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),





                ///-----Working with Children(If Applicable)---------------------------
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r),color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                          Image.asset(AppImages.workChildImg, width: 32.w,height: 48.h),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(text: "Working with Children\n(If Applicable)",textAlign:TextAlign.start,color: AppColors.buttonPrimaryColor,fontsize: 16.sp,fontWeight: FontWeight.w600
                              ,),
                          )
                        ],),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          SizedBox(width: 50.w),
                          Expanded(
                            flex: 3,
                            child: CustomTextField(
                              contentPaddingVertical: 6.r,
                              borderRadio: 20.h,
                              filColor: Color(0xffEAF8F9),
                              controller: workChildDateController,
                              readOnly: true,
                              onTap: () async{
                                DateTime? selectedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime.now(),
                                );
                                if (selectedDate != null) {
                                  setState(() {
                                    _startDate = selectedDate;
                                    workChildDateController.text = DateFormat('yyyy-MM-dd').format(_startDate!);
                                  });
                                }
                              },
                              hintText: "Enter Expiry date",
                              // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "BirthDate cannot be empty";
                                }
                                // if (!AppConstants.emailValidate.hasMatch(value)) {
                                //   return "Invalid email address";
                                // }
                                return null;
                              },
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: UploadButton(buttonText:
                              profileSetupController.pickedWorkChildFilePath == null
                                  ? "Upload"
                                  : "Uploaded",
                                onPressed: () async {
                                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: ['pdf', 'jpeg', 'png'],
                                  );

                                  if (result != null && result.files.isNotEmpty) {
                                    final path = result.files.single.path!;
                                    final file = File(path);

                                    // Upload file and get the server path
                                    final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                    if (uploadedUrl != null) {
                                      setState(() {
                                        profileSetupController.pickedWorkChildFilePath = uploadedUrl;
                                      });
                                      print("📄 Uploaded URL: $uploadedUrl");
                                    }
                                  }
                                },
                              ),

                            ),
                          ),
                          SizedBox(width: 10.w),
                        ],
                      ),
                      SizedBox(height: 10.h),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),




                ///---------Vaccination-----------------------
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
                  child: Column(
                    children: [
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 10.w),
                          Image.asset(AppImages.vacImg, width: 32.w, height: 48.h),

                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomText(
                              text: "Vaccination",
                              color: AppColors.buttonPrimaryColor,
                              fontsize: 16.sp,
                              fontWeight: FontWeight.w600,
                              textAlign: TextAlign.start,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      ...profileSetupController.vaccinationLocalList.asMap().entries.map((entry) {
                        int index = entry.key;
                        DocItem data = entry.value;

                        return Column(
                          children: [
                            SizedBox(height: 10.h),
                            Padding(
                              padding: EdgeInsets.only(right: 8.w,left: 50.w),
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 10.w),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppColors.primaryColor),
                                  borderRadius: BorderRadius.circular(16.r),
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton<String>(
                                    value: data.selectedDropdownData,
                                    hint: Text(
                                      'Dropdown',
                                      style: TextStyle(color: Colors.grey.shade600,fontSize: 12.sp),
                                    ),
                                    isExpanded: true,
                                    icon: Icon(Icons.keyboard_arrow_down,
                                        color: Colors.grey.shade700),
                                    items: profileSetupController.vaccinationDropdown.map((suburb) {
                                      return DropdownMenuItem<String>(
                                        value: suburb,
                                        child: CustomText(
                                          text: suburb,
                                          fontsize: 12.sp,
                                          color: AppColors.buttonPrimaryColor,
                                        ),
                                      );
                                    }).toList(),
                                    onChanged: (value) {
                                      setState(() {
                                        data.selectedDropdownData = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              children: [
                                SizedBox(width: 50.w),
                                Expanded(
                                  flex:3,
                                  child: CustomTextField(
                                    contentPaddingVertical: 6.r,
                                    borderRadio: 20.h,
                                    filColor: Color(0xffEAF8F9),
                                    controller: data.vaccinDateController,
                                    readOnly: true,
                                    onTap: () async{
                                      DateTime? picked = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime.now(),
                                      );
                                      if (picked != null) {
                                        setState(() {
                                          profileSetupController.vaccinationLocalList[index].selectedDate = picked;
                                          profileSetupController.vaccinationLocalList[index].vaccinDateController.text = "${picked.toLocal()}".split(' ')[0];
                                        });
                                      }

                                    },
                                    hintText: "Enter Publish date",
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Date cannot be empty";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Expanded(
                                  flex:2,
                                  child: UploadButton(
                                    buttonText: profileSetupController.vaccinationLocalList[index].pickedFilePath == null
                                        ? "Upload"
                                        : "Uploaded",
                                    onPressed: () async {
                                      FilePickerResult? result = await FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['pdf', 'jpeg', 'png'],
                                      );

                                      if (result != null && result.files.isNotEmpty) {
                                        final path = result.files.single.path!;
                                        final file = File(path);

                                        // Upload file and get the server path
                                        final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                        if (uploadedUrl != null) {
                                          setState(() {
                                            profileSetupController.vaccinationLocalList[index].pickedFilePath = uploadedUrl;
                                          });
                                          print("📄 Uploaded URL: $uploadedUrl");
                                        }
                                      }
                                    },
                                  ),
                                  //   profileSetupController.vaccinationLocalList[index].pickedFilePath == null
                                  //       ? "Upload"
                                  //       : "Uploaded",
                                  //   onPressed: ()async{
                                  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
                                  //       type: FileType.custom,
                                  //       allowedExtensions: ['pdf', 'jpeg'],
                                  //     );
                                  //
                                  //     if (result != null && result.files.isNotEmpty) {
                                  //       setState(() {
                                  //         profileSetupController.vaccinationLocalList[index].pickedFilePath = result.files.single.path;
                                  //       });
                                  //       print("file location:::___+++___+++:  ${profileSetupController.vaccinationLocalList[index].pickedFilePath}");
                                  //     }
                                  //   },
                                  // ),
                                ),
                                if (index != 0) // First item fixed, no delete button
                                  IconButton(
                                    color:Colors.grey,
                                    icon: Icon(Icons.delete_forever, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        profileSetupController.vaccinationLocalList.removeAt(index);
                                      });
                                    },
                                  ),
                                SizedBox(width: 10.w),
                              ],
                            ),
                            SizedBox(height: 20.h),
                          ],
                        );
                      }).toList(),
                      Padding(
                        padding: EdgeInsets.only(left: 50.w,right: 10.w),
                        child: CustomButton(
                          title: "+ Add More Doc",
                          titlecolor: AppColors.buttonPrimaryColor,
                          onpress: () {
                            setState(() {
                              profileSetupController.vaccinationLocalList.add(DocItem());
                            });
                          },
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
                SizedBox(height: 20.h,),




                ///-----ABN-----------------------
                Container(
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.h),
                      child: Column(
                          children: [
                            SizedBox(height: 10.h),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(AppImages.abnImg, width: 32.w, height: 48.h),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: "ABN*",
                                    color: AppColors.buttonPrimaryColor,
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              contentPaddingVertical: 8.r,
                              borderRadio: 20.h,
                              filColor: Color(0xffEAF8F9),
                                controller: abnController,
                            hintText: "ABN number",
                              keyboardType:TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "ABN cannot be empty";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(   contentPaddingVertical: 8.r,
                              borderRadio: 20.h,
                              filColor: Color(0xffEAF8F9),
                              controller: businessNameController,
                              hintText: "Business name",
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Business cannot be empty";
                                }
                                return null;
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                              Obx(()=>
                              Checkbox(
                                      checkColor: Colors.white,
                                      activeColor: AppColors.primaryColor,
                                      value: profileSetupController.isGSTCheck.value,
                                      onChanged: (value) {
                                        profileSetupController.isGSTCheck.value = value!;
                                      },
                                    ),
                              ),

                                CustomText(text: "GST Registered",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500,fontsize: 14.sp,),

                              ],
                            ),
                            CustomText(text: "You can quickly apply for an ABN online for \nfree at abn.gov.au",maxline: 3,textAlign: TextAlign.start,fontWeight: FontWeight.w500,color: AppColors.buttonPrimaryColor,),
                            SizedBox(height: 20.h),
                          ]
                      ),
                    )),
                SizedBox(height: 20.h,),





                ///-----Bank Details-----------------------
                Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 20.h),
                      child: Column(
                          children: [
                            SizedBox(height: 10.h),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Image.asset(AppImages.bankImg, width: 32.w, height: 48.h),

                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    text: "Bank Details*",
                                    color: AppColors.buttonPrimaryColor,
                                    fontsize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              contentPaddingVertical: 8.r,
                              borderRadio: 20.h,
                              filColor: Color(0xffEAF8F9),
                              controller: BSBController,
                              hintText: "BSB number",
                              keyboardType:TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter BSB number";
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20.h),
                            CustomTextField(
                              contentPaddingVertical: 8.r,
                              borderRadio: 20.h,
                              filColor: Color(0xffEAF8F9),
                              controller: accountNoController,
                              hintText: "Account number",
                              keyboardType:TextInputType.number,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Enter Account number";
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 20.h),
                          ]
                      ),
                    )),
                SizedBox(height: 20.h),



                ///----------Save Button-----------------------

                   CustomButtonCommon(title: "Save",

                       onpress: (){
                    profileSetupController.uploadDocuments(
                      passportExpiry: passportDateCNTRL.text,
                      passportFilePath: profileSetupController.pickedPassportFilePath ?? "",

                      driveExpiry: driveController.text,
                      driveFrontPath: profileSetupController.driveFontFilePath ?? "",
                      driveBackPath: profileSetupController.driveBackFilePath ?? "",

                      policeChecks: profileSetupController.policeCheckLocalList,

                      carInsDropdown: profileSetupController.selectedCarInsDropdown ?? "",
                      carInsExpiry: carController.text,
                      carInsFilePath: profileSetupController.pickedCarFilePath ?? "",

                      qualificationLists: profileSetupController.qualificationLocalList,

                      firstAidCPR: profileSetupController.aidCprLocalList,

                      workingWithChildrenExpiry: workChildDateController.text,
                      workingWithChildrenFilePath: profileSetupController.pickedWorkChildFilePath ?? "",

                      vaccinations: profileSetupController.vaccinationLocalList,

                      abnNumber: abnController.text,
                      businessName: businessNameController.text,

                      bsbNumber: BSBController.text,
                      accountNumber: accountNoController.text

                    );
                    // Get.toNamed(AppRoutes.allBottomBarScreen,preventDuplicates: false);
                  }),

                SizedBox(height: 40.h),


              ],
            ),
          ),
        ),
      ) ,
    );
  }

}

class CustomSlider extends StatefulWidget {
  const CustomSlider({super.key});

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  double _value = 0.3;

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        trackHeight: 6,
        inactiveTrackColor: Colors.white.withOpacity(0.5),
        activeTrackColor: const Color(0xFF0E515F),
         thumbShape: const PillThumbShape(),
        thumbColor: const Color(0xFF0E515F),
        overlayColor: Colors.transparent,
        overlayShape: SliderComponentShape.noOverlay,
      ),
      child: Slider(
        min: 0,
        max: 1,
        value: _value,
        onChanged: (newVal) => setState(() => _value = newVal),
      ),
    );
  }
}

class PillThumbShape extends SliderComponentShape {
  final double thumbWidth;
  final double thumbHeight;

  const PillThumbShape({this.thumbWidth = 56, this.thumbHeight = 28});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size(thumbWidth, thumbHeight);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        required Animation<double> activationAnimation,
        required Animation<double> enableAnimation,
        required bool isDiscrete,
        required TextPainter labelPainter,
        required RenderBox parentBox,
        required SliderThemeData sliderTheme,
        required TextDirection textDirection,
        required double value,
        required double textScaleFactor,
        required Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final paint = Paint()..color = sliderTheme.thumbColor ?? Colors.teal;

    final rect = Rect.fromCenter(
      center: center,
      width: thumbWidth,
      height: thumbHeight,
    );

    final rrect = RRect.fromRectAndRadius(rect, Radius.circular(thumbHeight / 2));

    // Draw pill shape
    canvas.drawRRect(rrect, paint);

    // Draw percentage text inside pill
    final textSpan = TextSpan(
      text: '${(value * 100).round()}%',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );

    final textPainter = TextPainter(
      text: textSpan,
      textDirection: textDirection,
      maxLines: 1,
    );

    textPainter.layout(minWidth: 0, maxWidth: thumbWidth);

    final textOffset = Offset(
      center.dx - textPainter.width / 2,
      center.dy - textPainter.height / 2,
    );

    textPainter.paint(canvas, textOffset);
  }
}

class UploadButton extends StatelessWidget {
  const UploadButton({super.key, required this.buttonText, required this.onPressed,});
final String buttonText;
final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    // return ElevatedButton.icon(
    //   style: ElevatedButton.styleFrom(
    //     backgroundColor: const Color(0xFF0E515F),
    //     shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(12.r),
    //     ),
    //     padding:  EdgeInsets.symmetric(horizontal: 20.w,),
    //   ),
    //   onPressed: onPressed,
    //   icon:  Icon(
    //     Icons.upload_rounded,
    //     size: 12.sp,
    //     color: Colors.white,
    //   ),
    //   label:
    //   CustomText(text: buttonText,color: AppColors.whiteColor,fontsize: 12.sp,)
    //
    // );
   return InkWell(
      onTap: onPressed,
      child: Container(
        height: 54.h,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color(0xFF0E515F),),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon(
            //   Icons.upload_rounded,
            //   size: 12.sp,
            //   color: Colors.white,
            // ),
            SvgPicture.asset(AppIcons.upIcon,width: 12.w,height: 12.h,),
            SizedBox(width: 10.w,),
            CustomText(text: buttonText,color: AppColors.whiteColor,fontsize: 12.sp,)
          ],),
      ),
    );
  }
}

// class DocItem {
//   String? selectedDropdownData;
//   DateTime? selectedDate;
//
//   TextEditingController policeDateController = TextEditingController();
//   TextEditingController qualificationDateController = TextEditingController();
//   TextEditingController aidCPRDateController = TextEditingController();
//   TextEditingController vaccinDateController = TextEditingController();
//
//   String? pickedFilePath;
//
//   DocItem({
//     this.selectedDropdownData,
//     this.selectedDate,
//   });
// }

class DocItem {
  String? selectedDropdownData;
  DateTime? selectedDate;

  TextEditingController policeDateController;
  TextEditingController qualificationDateController;
  TextEditingController aidCPRDateController;
  TextEditingController vaccinDateController;

  String? pickedFilePath;
  String? isFromServer;

  DocItem({
    this.selectedDropdownData,
    this.selectedDate,
    this.pickedFilePath,
    this.isFromServer,
  }) : policeDateController = TextEditingController(
    text: selectedDate != null ? "${selectedDate.toLocal()}".split(' ')[0] : '',
  ),
        qualificationDateController = TextEditingController(
          text: selectedDate != null ? "${selectedDate.toLocal()}".split(' ')[0] : '',
        ),
        aidCPRDateController = TextEditingController(
          text: selectedDate != null ? "${selectedDate.toLocal()}".split(' ')[0] : '',
        ),
        vaccinDateController = TextEditingController(
          text: selectedDate != null ? "${selectedDate.toLocal()}".split(' ')[0] : '',
        );
}
