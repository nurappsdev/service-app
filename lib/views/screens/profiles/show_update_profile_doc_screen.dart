//
//
// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:careshiftapp/services/api_constants.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_pdfview/flutter_pdfview.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
//
// import '../../../controller/controllers.dart';
// import '../../../helpers/helpers.dart';
// import '../../../models/models.dart';
// import '../../../utils/utils.dart';
// import '../../widgets/widgets.dart';
// import '../complete_profile/profile_setup_document_screen.dart';
// import 'settings/pdf_view_screen.dart';
//
// class ShowUpdateProfileDocScreen extends StatefulWidget {
//   const ShowUpdateProfileDocScreen({super.key});
//
//   @override
//   State<ShowUpdateProfileDocScreen> createState() => _ShowUpdateProfileDocScreenState();
// }
//
// class _ShowUpdateProfileDocScreenState extends State<ShowUpdateProfileDocScreen> {
//
//   DateTime? _startDate;
//   void _selectDate(BuildContext context,) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//     );
//
//     if (selectedDate != null) {
//       setState(() {
//         _startDate = selectedDate;
//         passportDateCNTRL.text = DateFormat('yyyy-MM-dd').format(_startDate!);
//       });
//     }
//   }
//   void _selectDriveDate(BuildContext context,) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//     );
//
//     if (selectedDate != null) {
//       setState(() {
//         _startDate = selectedDate;
//         driveController.text = DateFormat('yyyy-MM-dd').format(_startDate!);
//       });
//     }
//   }
//
//
//   ///--------------Qualification-------------------------
//   Future<void> _qualificationDateSelectDate(BuildContext context, int index) async {
//     DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: profileSetupController.qualificationLocalList[index].selectedDate ?? DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         profileSetupController.qualificationLocalList[index].selectedDate = picked;
//         profileSetupController.qualificationLocalList[index].qualificationDateController.text = "${picked.toLocal()}".split(' ')[0];
//       });
//     }
//   }
//
//
//   void _selectCarDate(BuildContext context,) async {
//     DateTime? selectedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1950),
//       lastDate: DateTime.now(),
//     );
//
//     if (selectedDate != null) {
//       setState(() {
//         _startDate = selectedDate;
//         carController.text = DateFormat('yyyy-MM-dd').format(_startDate!);
//       });
//     }
//   }
//   ProfileSetupController profileSetupController = Get.put(ProfileSetupController());
//
//   TextEditingController carController = TextEditingController();
//   TextEditingController passportDateCNTRL = TextEditingController();
//   TextEditingController driveController = TextEditingController();
//   TextEditingController workChildDateController = TextEditingController();
//   TextEditingController abnController = TextEditingController();
//   TextEditingController businessNameController = TextEditingController();
//   TextEditingController BSBController = TextEditingController();
//   TextEditingController accountNoController = TextEditingController();
//   RxBool isChecked = false.obs;
//   DocumentResponseModel documentResponseModel = Get.arguments as DocumentResponseModel;
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     carController.dispose();
//     passportDateCNTRL.dispose();
//     driveController.dispose();
//     workChildDateController.dispose();
//     abnController.dispose();
//     businessNameController.dispose();
//     BSBController.dispose();
//     accountNoController.dispose();
//     profileSetupController.aidCprLocalList.clear();
//     profileSetupController.vaccinationLocalList.clear();
//     profileSetupController.policeCheckLocalList.clear();
//     profileSetupController.qualificationLocalList.clear();
//     super.dispose();
//   }
//
//   List<DocItem> get mergedPoliceCheckList {
//     final existingDocs = documentResponseModel.policeCheck?.map((doc) {
//       final parsedDate = DateTime.tryParse(doc.publishDate?.toIso8601String() ?? '');
//       return DocItem(
//         selectedDropdownData: doc.type,
//         pickedFilePath: doc.document,
//         selectedDate: parsedDate,
//         isFromServer: true,
//       );
//     }).toList() ?? [];
//
//     return [...existingDocs, ...profileSetupController.policeCheckLocalList];
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     profileSetupController.fetchDocumentResponse();
//     if (documentResponseModel.passport != null && documentResponseModel.passport!.expiryDate != null) {
//       passportDateCNTRL.text = "${TimeFormatHelper.formatDate(DateTime.parse(documentResponseModel.passport!.expiryDate!.toIso8601String()))}";
//     } else {
//       // Handle the case where passport or expiryDate is null, e.g., set a default value
//       passportDateCNTRL.text = "No expiry date available";
//     }
//
//
//
//     if (documentResponseModel.drivingLicense != null && documentResponseModel.drivingLicense!.expiryDate != null) {
//       driveController.text = "${TimeFormatHelper.formatDate(DateTime.parse(documentResponseModel.drivingLicense!.expiryDate!.toIso8601String()))}";
//     } else {
//       // Handle the case where passport or expiryDate is null, e.g., set a default value
//       driveController.text = "No expiry date";
//     }
//
//
//
//
//     if (documentResponseModel.workingWithChildren != null && documentResponseModel.workingWithChildren!.expiryDate != null) {
//       workChildDateController.text = "${TimeFormatHelper.formatDate(DateTime.parse(documentResponseModel.workingWithChildren!.expiryDate!.toIso8601String()))}";
//     } else {
//       // Handle the case where passport or expiryDate is null, e.g., set a default value
//       workChildDateController.text = "No expiry date";
//     }
//
//
//
//     if (documentResponseModel.carInsuranceCertificate != null && documentResponseModel.carInsuranceCertificate!.expiryDate != null) {
//       carController.text = "${TimeFormatHelper.formatDate(DateTime.parse(documentResponseModel.carInsuranceCertificate!.expiryDate!.toIso8601String()))}";
//     } else {
//       // Handle the case where passport or expiryDate is null, e.g., set a default value
//       carController.text = "No expiry date";
//     }
//
//
//
//
//     documentResponseModel.abn != null && documentResponseModel.abn!.abnNumber != null ? abnController.text = documentResponseModel.abn!.abnNumber! : "N/A";
//     documentResponseModel.abn != null && documentResponseModel.abn!.businessName != null ? businessNameController.text = documentResponseModel.abn!.businessName! : "N/A";
//     documentResponseModel.bankDetails != null && documentResponseModel.bankDetails!.bsbNumber != null ? BSBController.text = documentResponseModel.bankDetails!.bsbNumber! : "N/A";
//     documentResponseModel.bankDetails != null && documentResponseModel.bankDetails!.accountNumber != null ? accountNoController.text = documentResponseModel.bankDetails!.accountNumber! : "N/A";
//
//   }
//   @override
//   Widget build(BuildContext context) {
//
//     // print("documentResponseModel.abn?.businessName${documentResponseModel.abn?.businessName}");
//     return  Scaffold(
//         backgroundColor: AppColors.primaryColor,
//         appBar: AppBar(title: CustomText(text: "Document",fontWeight: FontWeight.w600,fontsize: 20.sp,color: AppColors.whiteColor,),
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
//             onPressed: () {
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: Container(
//           width: double.infinity,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 24.w),
//             child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(height: 20.h),
//
//                     ///-----Passport---------------------------
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(24.r),
//                           color: AppColors.whiteColor),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 10.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(width: 10.w),
//                               Image.asset(
//                                   "assets/images/passportIcon.png", width: 32.w,
//                                   height: 48.h),
//
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CustomText(text: "Passport*",
//                                   color: AppColors.buttonPrimaryColor,
//                                   fontsize: 16.sp,
//                                   fontWeight: FontWeight.w600
//                                   ,),
//                               )
//                             ],),
//                           SizedBox(height: 10.h),
//                           Row(
//                             children: [
//                               SizedBox(width: 50.w),
//                               Expanded(
//                                 flex: 3,
//                                 child: CustomTextField(
//                                   contentPaddingVertical: 8.r,
//                                   borderRadio: 20.h,
//                                   filColor: Color(0xffEAF8F9),
//                                   controller: passportDateCNTRL,
//                                   readOnly: true,
//                                   onTap: () => documentResponseModel.passport?.isVerifyed != "approved" ?SizedBox.shrink(): _selectDate(context),
//                                   hintText: "Enter expiry date",
//                                   // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "Enter expiry date cannot be empty";
//                                     }
//                                     // if (!AppConstants.emailValidate.hasMatch(value)) {
//                                     //   return "Invalid email address";
//                                     // }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                               SizedBox(width: 6.w),
//                               Expanded(
//                                 flex: 2,
//                                 child: documentResponseModel.passport?.isVerifyed == "approved" ?  ViewButton(
//                                   buttonText: "View",
//                                   onPressed: () async {
//
//                                     String? documentPath = documentResponseModel.passport?.document;
//
//                                     if (documentPath != null) {
//                                       String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
//
//                                       if (fileExtension == 'pdf') {
//                                         print("This is a PDF document.");
//                                         Navigator.push(
//                                           context,
//                                           MaterialPageRoute(
//                                             builder: (context) => PdfViewScreen(
//                                               pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
//                                             ),
//                                           ),
//                                         );
//
//                                       } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
//                                         print("This is an image file.");
//                                         showDialog(
//                                           context: context,
//                                           builder: (context) {
//                                             return Dialog(
//                                               child: CustomNetworkImage(
//                                                   boxShape: BoxShape.rectangle,
//                                                   imageUrl:'${ApiConstants.imageBaseUrl}${documentPath}',
//                                                   height: 200.h,
//                                                   width: double.infinity
//                                               ),// Display the image from the URL
//                                             );
//                                           },
//                                         );
//                                         // Add your image viewer logic here (e.g., use Image widget)
//                                       } else {
//                                         // Handle other file types or unsupported types
//                                         print("Unsupported file type.");
//                                       }
//                                     } else {
//                                       print("Document path is null");
//                                     }
//
//
//                                   },
//                                 ): UploadButton(
//                                   buttonText: profileSetupController.pickedPassportFilePath == null
//                                       ? "Upload"
//                                       : "Uploaded",
//                                   onPressed: () async {
//                                     FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                       type: FileType.custom,
//                                       allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                     );
//
//                                     if (result != null && result.files.isNotEmpty) {
//                                       final path = result.files.single.path!;
//                                       final file = File(path);
//
//                                       // Upload file and get the server path
//                                       final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                       if (uploadedUrl != null) {
//                                         setState(() {
//                                           profileSetupController.pickedPassportFilePath = uploadedUrl;
//                                         });
//                                         print("📄 Uploaded URL: $uploadedUrl");
//                                       }
//                                     }
//                                   },
//                                 ),
//
//                               ),
//                               SizedBox(width: 10.w),
//
//                             ],
//                           ),
//                           SizedBox(height: 20.h),
//                           Padding(
//                             padding:  EdgeInsets.only(left: 50.w),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset(documentResponseModel.passport?.isVerifyed == "approved" ? AppIcons.verifyIcon: documentResponseModel.passport?.isVerifyed == "pending"? AppIcons.pendingIcon: AppIcons.warningIcon,width: 20.w,height: 20.h,),
//                                 SizedBox(width: 8.w),
//                                 CustomText(text: documentResponseModel.passport?.isVerifyed == "approved" ?  "Verified" : documentResponseModel.passport?.isVerifyed == "pending"?  "Waiting for Verification": "Not Approved", color: documentResponseModel.passport?.isVerifyed == "approved"? Color(0xff009A3F):documentResponseModel.passport?.isVerifyed == "pending"? Color(0xffE9B000):Color(0xffF70004),fontsize: 12.sp, fontWeight: FontWeight.bold,)
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20.h),
//
//
//
//                     ///-----Driving License---------------------------
//                     Container(
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r),color: AppColors.whiteColor),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 10.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(width: 10.w),
//                               Image.asset(AppImages.driveIcon, width: 32.w,height: 48.h),
//
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CustomText(text: "Driving License (If Applicable)",color: AppColors.buttonPrimaryColor,fontsize: 16.sp,fontWeight: FontWeight.w600
//                                   ,),
//                               )
//                             ],),
//                           SizedBox(height: 10.h),
//                           Row(
//                             children: [
//                               SizedBox(width: 50.w),
//                               Expanded(
//                                 flex: 3,
//                                 child: Column(
//                                   children: [
//                                     SizedBox(height: 60.h),
//                                     CustomTextField(
//                                       contentPaddingVertical: 6.r,
//                                       borderRadio: 20.h,
//                                       filColor: Color(0xffEAF8F9),
//                                       controller: driveController,
//                                       readOnly: true,
//                                       onTap: () => documentResponseModel.drivingLicense?.isVerifyed != "approved"  ? _selectDriveDate(context):SizedBox.shrink(),
//                                       hintText: "Enter expiry date",
//                                       // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return "date cannot be empty";
//                                         }
//                                         // if (!AppConstants.emailValidate.hasMatch(value)) {
//                                         //   return "Invalid email address";
//                                         // }
//                                         return null;
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 10.w,),
//                               Expanded(
//                                 flex: 2,
//                                 child: Column(
//                                   children: [
//                                     documentResponseModel.drivingLicense?.isVerifyed != "approved"  ? UploadButton(buttonText: profileSetupController.driveFontFilePath == null
//                                         ? "Upload"
//                                         : "Uploaded",
//                                       onPressed: () async {
//                                         FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                           type: FileType.custom,
//                                           allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                         );
//
//                                         if (result != null && result.files.isNotEmpty) {
//                                           final path = result.files.single.path!;
//                                           final file = File(path);
//
//                                           // Upload file and get the server path
//                                           final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                           if (uploadedUrl != null) {
//                                             setState(() {
//                                               profileSetupController.driveFontFilePath  = uploadedUrl;
//                                             });
//                                             print("📄 Uploaded URL: $uploadedUrl");
//                                           }
//                                         }
//                                       },
//                                     ):ViewButton(
//                                       buttonText: "View",
//                                       onPressed: () async {
//
//                                         String? documentPath = documentResponseModel.passport?.document;
//
//                                         if (documentPath != null) {
//                                           String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
//
//                                           if (fileExtension == 'pdf') {
//                                             print("This is a PDF document.");
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => PdfViewScreen(
//                                                   pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
//                                                 ),
//                                               ),
//                                             );
//
//                                           } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
//                                             print("This is an image file.");
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return Dialog(
//                                                   child: CustomNetworkImage(
//                                                       boxShape: BoxShape.rectangle,
//                                                       imageUrl:'${ApiConstants.imageBaseUrl}${documentPath}',
//                                                       height: 200.h,
//                                                       width: double.infinity
//                                                   ),// Display the image from the URL
//                                                 );
//                                               },
//                                             );
//                                             // Add your image viewer logic here (e.g., use Image widget)
//                                           } else {
//                                             // Handle other file types or unsupported types
//                                             print("Unsupported file type.");
//                                           }
//                                         } else {
//                                           print("Document path is null");
//                                         }
//
//
//                                       },
//                                     ),
//                                     SizedBox(height: 6.h,),
//                                     documentResponseModel.drivingLicense?.isVerifyed != "approved"   ?  UploadButton(buttonText: profileSetupController.driveBackFilePath == null
//                                         ? "Upload"
//                                         : "Uploaded",
//                                       onPressed: () async {
//                                         FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                           type: FileType.custom,
//                                           allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                         );
//
//                                         if (result != null && result.files.isNotEmpty) {
//                                           final path = result.files.single.path!;
//                                           final file = File(path);
//
//                                           // Upload file and get the server path
//                                           final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                           if (uploadedUrl != null) {
//                                             setState(() {
//                                               profileSetupController.driveBackFilePath  = uploadedUrl;
//                                             });
//                                             print("📄 Uploaded URL: $uploadedUrl");
//                                           }
//                                         }
//                                       },
//                                     ) :ViewButton(
//                                       buttonText: "View",
//                                       onPressed: () async {
//
//                                         String? documentPath = documentResponseModel.passport?.document;
//
//                                         if (documentPath != null) {
//                                           String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
//
//                                           if (fileExtension == 'pdf') {
//                                             print("This is a PDF document.");
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => PdfViewScreen(
//                                                   pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
//                                                 ),
//                                               ),
//                                             );
//
//                                           } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
//                                             print("This is an image file.");
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return Dialog(
//                                                   child: CustomNetworkImage(
//                                                       boxShape: BoxShape.rectangle,
//                                                       imageUrl:'${ApiConstants.imageBaseUrl}${documentPath}',
//                                                       height: 200.h,
//                                                       width: double.infinity
//                                                   ),// Display the image from the URL
//                                                 );
//                                               },
//                                             );
//                                             // Add your image viewer logic here (e.g., use Image widget)
//                                           } else {
//                                             // Handle other file types or unsupported types
//                                             print("Unsupported file type.");
//                                           }
//                                         } else {
//                                           print("Document path is null");
//                                         }
//
//
//                                       },
//                                     ),
//                                   ],
//
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                             ],
//                           ),
//                           SizedBox(height: 20.h),
//                           Padding(
//                             padding:  EdgeInsets.only(left: 50.w),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset(documentResponseModel.drivingLicense?.isVerifyed == "approved" ? AppIcons.verifyIcon: documentResponseModel.drivingLicense?.isVerifyed == "pending"? AppIcons.pendingIcon: AppIcons.warningIcon,width: 20.w,height: 20.h,),
//                                 SizedBox(width: 8.w),
//                                 CustomText(text: documentResponseModel.drivingLicense?.isVerifyed == "approved" ?  "Verified" : documentResponseModel.drivingLicense?.isVerifyed == "pending"?  "Waiting for Verification": "Not Approved", color: documentResponseModel.drivingLicense?.isVerifyed == "approved"? Color(0xff009A3F):documentResponseModel.passport?.isVerifyed == "pending"? Color(0xffE9B000):Color(0xffF70004),fontsize: 12.sp, fontWeight: FontWeight.bold,)
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 20.h),
//                     ///-----Car Insurance-------------------------
//                     Container(
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r),color: AppColors.whiteColor),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 10.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(width: 10.w),
//                               Image.asset(AppImages.carInsImg, width: 32.w,height: 48.h),
//
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CustomText(text: "Car Insurance Certificate \n(If Applicable)",color: AppColors.buttonPrimaryColor,fontsize: 16.sp,fontWeight: FontWeight.w600,textAlign: TextAlign.start
//                                   ,),
//                               )
//                             ],),
//                           SizedBox(height: 10.h),
//                           documentResponseModel.carInsuranceCertificate?.isVerifyed == "approved" ? Row(
//                             children: [
//                               SizedBox(width: 50.w),
//                               Expanded(
//                                 flex: 3,
//                                 child: Column(
//                                   children: [
//                                     SizedBox(height: 10.h),
//                                     Container(
//                                         height: 60.h,
//                                         padding: EdgeInsets.symmetric(horizontal: 12.w),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: AppColors.primaryColor),
//                                           borderRadius: BorderRadius.circular(20.r),
//                                         ),
//                                         child: Center(child: CustomText(text: documentResponseModel.carInsuranceCertificate!.type.toString(),))
//                                     ),
//                                     SizedBox(height: 10.h),
//                                     CustomTextField(
//                                       contentPaddingVertical: 6.r,
//                                       borderRadio: 20.h,
//                                       filColor: Color(0xffEAF8F9),
//                                       controller: carController,
//                                       readOnly: true,
//                                       onTap: () => documentResponseModel.carInsuranceCertificate!.isVerifyed != "approved" ?_selectCarDate(context):SizedBox.shrink(),
//                                       hintText: "Enter expiry date",
//                                       // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return "Date cannot be empty";
//                                         }
//                                         // if (!AppConstants.emailValidate.hasMatch(value)) {
//                                         //   return "Invalid email address";
//                                         // }
//                                         return null;
//                                       },
//                                     ),
//                                     SizedBox(height: 12.h),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child:
//                                 Padding(
//                                     padding:  EdgeInsets.only(top: 70.h,left: 10.w,),
//                                     child: ViewButton(
//                                       buttonText: "View",
//                                       onPressed: () async {
//
//                                         String? documentPath = documentResponseModel.carInsuranceCertificate?.certificate;
//
//                                         if (documentPath != null) {
//                                           String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
//
//                                           if (fileExtension == 'pdf') {
//                                             print("This is a PDF document.");
//                                             Navigator.push(
//                                               context,
//                                               MaterialPageRoute(
//                                                 builder: (context) => PdfViewScreen(
//                                                   pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
//                                                 ),
//                                               ),
//                                             );
//
//                                           } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
//                                             print("This is an image file.");
//                                             showDialog(
//                                               context: context,
//                                               builder: (context) {
//                                                 return Dialog(
//                                                   child: CustomNetworkImage(
//                                                       boxShape: BoxShape.rectangle,
//                                                       imageUrl:'${ApiConstants.imageBaseUrl}${documentPath}',
//                                                       height: 200.h,
//                                                       width: double.infinity
//                                                   ),// Display the image from the URL
//                                                 );
//                                               },
//                                             );
//                                             // Add your image viewer logic here (e.g., use Image widget)
//                                           } else {
//                                             // Handle other file types or unsupported types
//                                             print("Unsupported file type.");
//                                           }
//                                         } else {
//                                           print("Document path is null");
//                                         }
//
//
//                                       },
//                                     )
//
//                                 ),
//
//                               ),
//                               SizedBox(width: 10.w),
//                             ],
//                           ) : Row(
//                             children: [
//                               SizedBox(width: 50.w),
//                               Expanded(
//                                 flex: 3,
//                                 child: Column(
//                                   children: [
//                                     SizedBox(height: 10.h),
//                                     Container(
//                                       padding: EdgeInsets.symmetric(horizontal: 12.w),
//                                       decoration: BoxDecoration(
//                                         border: Border.all(color: AppColors.primaryColor),
//                                         borderRadius: BorderRadius.circular(20.r),
//                                       ),
//                                       child: DropdownButtonHideUnderline(
//                                         child: DropdownButton<String>(
//                                           value: profileSetupController.selectedCarInsDropdown,
//                                           hint: Text(
//                                             'Dropdown',
//                                             style: TextStyle(color: Colors.grey.shade600,fontSize: 12.sp),
//                                           ),
//                                           isExpanded: true,
//                                           icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
//                                           items: profileSetupController.carInsDropdown.map((gender) {
//                                             return DropdownMenuItem<String>(
//                                               value: gender,
//                                               child:
//                                               CustomText(text: gender,fontsize: 12.sp,color: AppColors.buttonPrimaryColor,),
//                                             );
//                                           }).toList(),
//                                           onChanged: (value) {
//                                             setState(() {
//                                               profileSetupController.selectedCarInsDropdown = value;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 10.h),
//                                     CustomTextField(
//                                       contentPaddingVertical: 6.r,
//                                       borderRadio: 20.h,
//                                       filColor: Color(0xffEAF8F9),
//                                       controller: carController,
//                                       readOnly: true,
//                                       onTap: () => _selectCarDate(context),
//                                       hintText: "Enter expiry date",
//                                       // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
//                                       validator: (value) {
//                                         if (value == null || value.isEmpty) {
//                                           return "Date cannot be empty";
//                                         }
//                                         // if (!AppConstants.emailValidate.hasMatch(value)) {
//                                         //   return "Invalid email address";
//                                         // }
//                                         return null;
//                                       },
//                                     ),
//                                     SizedBox(height: 12.h),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child:
//                                 Padding(
//                                   padding:  EdgeInsets.only(top: 70.h,left: 10.w,),
//                                   child: UploadButton(buttonText:
//                                   profileSetupController.pickedCarFilePath == null
//                                       ? "Upload"
//                                       : "Uploaded",
//                                     onPressed: () async {
//                                       FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                         type: FileType.custom,
//                                         allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                       );
//
//                                       if (result != null && result.files.isNotEmpty) {
//                                         final path = result.files.single.path!;
//                                         final file = File(path);
//
//                                         // Upload file and get the server path
//                                         final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                         if (uploadedUrl != null) {
//                                           setState(() {
//                                             profileSetupController.pickedCarFilePath  = uploadedUrl;
//                                           });
//                                           print("📄 Uploaded URL: $uploadedUrl");
//                                         }
//                                       }
//                                     },
//                                   ),
//
//                                 ),
//
//                               ),
//                               SizedBox(width: 10.w),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           Padding(
//                             padding:  EdgeInsets.only(left: 50.w),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset(documentResponseModel.carInsuranceCertificate?.isVerifyed == "approved" ? AppIcons.verifyIcon: documentResponseModel.carInsuranceCertificate?.isVerifyed == "pending"? AppIcons.pendingIcon: AppIcons.warningIcon,width: 20.w,height: 20.h,),
//                                 SizedBox(width: 8.w),
//                                 CustomText(text: documentResponseModel.carInsuranceCertificate?.isVerifyed == "approved" ?  "Verified" : documentResponseModel.carInsuranceCertificate?.isVerifyed == "pending"?  "Waiting for Verification": "Not Approved", color: documentResponseModel.carInsuranceCertificate?.isVerifyed == "approved"? Color(0xff009A3F):documentResponseModel.carInsuranceCertificate?.isVerifyed == "pending"? Color(0xffE9B000):Color(0xffF70004),fontsize: 12.sp, fontWeight: FontWeight.bold,)
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                         ],
//                       ),
//                     ),
//
//
//                     ///---------police check------------------------
//                     SizedBox(height: 20.h),
// //TEST
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24.r),
//                         color: AppColors.whiteColor,
//                       ),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 10.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(width: 10.w),
//                               Image.asset(AppImages.policeIcon, width: 32.w, height: 48.h),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CustomText(
//                                   text: "Police Check or NDIS \nWorker Screening Check*",
//                                   color: AppColors.buttonPrimaryColor,
//                                   fontsize: 16.sp,
//                                   fontWeight: FontWeight.w600,
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           ...mergedPoliceCheckList.asMap().entries.map((entry) {
//                             final index = entry.key;
//                             final doc = entry.value;
//                             final isNew = !doc.isFromServer;
//
//                             return Column(
//                               key: ValueKey(index),
//                               children: [
//                                 SizedBox(height: 10.h),
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 8.w, left: 50.w),
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 10.w),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: AppColors.primaryColor),
//                                       borderRadius: BorderRadius.circular(16.r),
//                                     ),
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton<String>(
//                                         value: doc.selectedDropdownData,
//                                         hint: Text(
//                                           'Dropdown',
//                                           style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
//                                         ),
//                                         isExpanded: true,
//                                         icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
//                                         items: profileSetupController.policeCheckDropdown.map((suburb) => DropdownMenuItem<String>(
//                                           value: suburb,
//                                           child: CustomText(
//                                             text: suburb,
//                                             fontsize: 12.sp,
//                                             color: AppColors.buttonPrimaryColor,
//                                           ),
//                                         )).toList(),
//                                         onChanged: isNew
//                                             ? (value) {
//                                           setState(() {
//                                             doc.selectedDropdownData = value;
//                                           });
//                                         }
//                                             : null,
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 20.h),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                   children: [
//                                     SizedBox(width: 50.w),
//                                     Expanded(
//                                       flex: 3,
//                                       child: CustomTextField(
//                                         contentPaddingVertical: 6.r,
//                                         borderRadio: 20.h,
//                                         filColor: Color(0xffEAF8F9),
//                                         controller: doc.policeDateController,
//                                         readOnly: true,
//                                         onTap: isNew
//                                             ? () async {
//                                           DateTime? picked = await showDatePicker(
//                                             context: context,
//                                             initialDate: doc.selectedDate ?? DateTime.now(),
//                                             firstDate: DateTime(1900),
//                                             lastDate: DateTime.now(),
//                                           );
//                                           if (picked != null) {
//                                             setState(() {
//                                               doc.selectedDate = picked;
//                                               doc.policeDateController.text = "${picked.toLocal()}".split(' ')[0];
//                                             });
//                                           }
//                                         }
//                                             : null,
//                                         hintText: "Enter publish date",
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return "Date cannot be empty";
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(width: 10.w),
//                                     Expanded(
//                                       flex: 2,
//                                       child: UploadButton(
//                                           buttonText: doc.pickedFilePath == null ? "Upload" : "Uploaded",
//                                           onPressed: () async {
//                                             FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                               type: FileType.custom,
//                                               allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                             );
//
//                                             if (result != null && result.files.isNotEmpty) {
//                                               final path = result.files.single.path!;
//                                               final file = File(path);
//                                               final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                               if (uploadedUrl != null) {
//                                                 setState(() {
//                                                   doc.pickedFilePath = uploadedUrl;
//                                                 });
//                                                 print("📄 Uploaded URL: $uploadedUrl");
//                                               }
//                                             }
//                                           }
//
//                                       ),
//                                     ),
//                                     SizedBox(width: 10.w),
//                                     if (isNew)
//                                       IconButton(
//                                         color: Colors.grey,
//                                         icon: Icon(Icons.delete_forever, color: Colors.red),
//                                         onPressed: () {
//                                           setState(() {
//                                             profileSetupController.policeCheckLocalList.removeAt(index - (documentResponseModel.policeCheck?.length ?? 0));
//                                           });
//                                         },
//                                       ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 20.h),
//                               ],
//                             );
//                           }).toList(),
//                           Padding(
//                             padding: EdgeInsets.only(left: 50.w, right: 10),
//                             child: CustomButton(
//                               title: "+ Add More Doc",
//                               titlecolor: AppColors.buttonPrimaryColor,
//                               onpress: () {
//                                 setState(() {
//                                   profileSetupController.policeCheckLocalList.add(DocItem());
//                                 });
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                         ],
//                       ),
//                     ),
//
//                     SizedBox(height: 20.h),
//                     ///
//                     Container(
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(24.r),
//                         color: AppColors.whiteColor,
//                       ),
//                       child: Column(
//                         children: [
//                           Container(
//                             height: 160.h, // Adjust the height as per your design needs
//                             child: ListView.builder(
//                               itemCount: documentResponseModel.policeCheck?.length ?? 0, // Set the count of items based on the list length
//                               itemBuilder: (context, index) {
//                                 final data = documentResponseModel.policeCheck?[index];
//                                 return Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Card(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         Row(
//                                           mainAxisAlignment: MainAxisAlignment.center,
//                                           children: [
//                                             Expanded(
//                                               flex: 3,
//                                               child: Container(
//                                                   height: 60.h,
//                                                   padding: EdgeInsets.symmetric(horizontal: 12.w),
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(color: AppColors.primaryColor),
//                                                     borderRadius: BorderRadius.circular(20.r),
//                                                   ),
//                                                   child: Center(child:   CustomText(text: data?.type ?? "No type available",fontWeight: FontWeight.bold,),)
//                                               ),
//                                             ),
//                                             // Handle null safely
//                                             SizedBox(width: 10.w),
//                                             Expanded(
//                                               flex: 2,
//                                               child: Container(
//                                                   height: 60.h,
//                                                   padding: EdgeInsets.symmetric(horizontal: 12.w),
//                                                   decoration: BoxDecoration(
//                                                     border: Border.all(color: AppColors.primaryColor),
//                                                     borderRadius: BorderRadius.circular(20.r),
//                                                   ),
//                                                   child: Center(child:     CustomText(
//                                                     text: TimeFormatHelper.formatDate(DateTime.parse(data!.publishDate!.toIso8601String())),fontWeight: FontWeight.bold,
//                                                   ),)
//                                               ),
//                                             ),
//
//                                           ],
//                                         ),
//                                         SizedBox(height: 10.h), // Add some space between the row and button
//                                         // ViewButton section
//                                         ViewButton(
//                                           buttonText: "View",
//                                           onPressed: () async {
//                                             String? documentPath = data.document; // Get the document path for the current item
//
//                                             if (documentPath != null) {
//                                               String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
//
//                                               if (fileExtension == 'pdf') {
//                                                 // Handle PDF documents
//                                                 print("This is a PDF document.");
//                                                 Navigator.push(
//                                                   context,
//                                                   MaterialPageRoute(
//                                                     builder: (context) => PdfViewScreen(
//                                                       pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
//                                                     ),
//                                                   ),
//                                                 );
//                                               } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
//                                                 // Handle image files
//                                                 print("This is an image file.");
//                                                 showDialog(
//                                                   context: context,
//                                                   builder: (context) {
//                                                     return Dialog(
//                                                       child: CustomNetworkImage(
//                                                         boxShape: BoxShape.rectangle,
//                                                         imageUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
//                                                         height: 200.h,
//                                                         width: double.infinity,
//                                                       ), // Display the image from the URL
//                                                     );
//                                                   },
//                                                 );
//                                               } else {
//                                                 // Handle unsupported file types
//                                                 print("Unsupported file type.");
//                                               }
//                                             } else {
//                                               print("Document path is null");
//                                             }
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(height: 10.h),
//                               Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   SizedBox(width: 10.w),
//                                   Image.asset(AppImages.policeIcon, width: 32.w, height: 48.h),
//                                   Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: CustomText(
//                                       text: "Police Check or NDIS \nWorker Screening Check*",
//                                       color: AppColors.buttonPrimaryColor,
//                                       fontsize: 16.sp,
//                                       fontWeight: FontWeight.w600,
//                                       textAlign: TextAlign.start,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(height: 10.h),
//                               ...profileSetupController.policeCheckLocalList.asMap().entries.map((entry) {
//                                 int index = entry.key;
//                                 DocItem doc = entry.value;
//                                 return Column(
//                                   key: ValueKey(index),
//                                   children: [
//                                     SizedBox(height: 10.h),
//                                     Padding(
//                                       padding: EdgeInsets.only(right: 8.w, left: 50.w),
//                                       child: Container(
//                                         padding: EdgeInsets.symmetric(horizontal: 10.w),
//                                         decoration: BoxDecoration(
//                                           border: Border.all(color: AppColors.primaryColor),
//                                           borderRadius: BorderRadius.circular(16.r),
//                                         ),
//                                         child: DropdownButtonHideUnderline(
//                                           child: DropdownButton<String>(
//                                             value: doc.selectedDropdownData,
//                                             hint: Text(
//                                               'Dropdown',
//                                               style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
//                                             ),
//                                             isExpanded: true,
//                                             icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey.shade700),
//                                             items: profileSetupController.policeCheckDropdown.map((suburb) => DropdownMenuItem<String>(
//                                               value: suburb,
//                                               child: CustomText(
//                                                 text: suburb,
//                                                 fontsize: 12.sp,
//                                                 color: AppColors.buttonPrimaryColor,
//                                               ),
//                                             ))
//                                                 .toList(),
//                                             onChanged: (value) {
//                                               setState(() {
//                                                 doc.selectedDropdownData = value;
//                                               });
//                                             },
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                     SizedBox(height: 20.h),
//                                     Row(
//                                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                       children: [
//                                         SizedBox(width: 50.w),
//                                         Expanded(
//                                           flex: 3,
//                                           child: CustomTextField(
//                                             contentPaddingVertical: 6.r,
//                                             borderRadio: 20.h,
//                                             filColor: Color(0xffEAF8F9),
//                                             controller: doc.policeDateController,
//                                             readOnly: true,
//                                             onTap: () async{
//                                               DateTime? picked = await showDatePicker(
//                                                 context: context,
//                                                 initialDate: profileSetupController.policeCheckLocalList[index].selectedDate ?? DateTime.now(),
//                                                 firstDate: DateTime(1900),
//                                                 lastDate: DateTime.now(),
//                                               );
//                                               if (picked != null) {
//                                                 setState(() {
//                                                   profileSetupController.policeCheckLocalList[index].selectedDate = picked;
//                                                   profileSetupController.policeCheckLocalList[index].policeDateController.text = "${picked.toLocal()}".split(' ')[0];
//                                                 });
//                                               }},
//                                             hintText: "Enter publish date",
//                                             validator: (value) {
//                                               if (value == null || value.isEmpty) {
//                                                 return "Date cannot be empty";
//                                               }
//                                               return null;
//                                             },
//                                           ),
//                                         ),
//                                         SizedBox(width: 10.w),
//                                         Expanded(
//                                           flex: 2,
//                                           child: UploadButton(
//                                             buttonText:
//
//                                             profileSetupController.policeCheckLocalList[index].pickedFilePath == null
//                                                 ? "Upload"
//                                                 : "Uploaded",
//                                             onPressed: () async {
//                                               FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                                 type: FileType.custom,
//                                                 allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                               );
//
//                                               if (result != null && result.files.isNotEmpty) {
//                                                 final path = result.files.single.path!;
//                                                 final file = File(path);
//
//                                                 // Upload file and get the server path
//                                                 final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                                 if (uploadedUrl != null) {
//                                                   setState(() {
//                                                     profileSetupController.policeCheckLocalList[index].pickedFilePath = uploadedUrl;
//                                                   });
//                                                   print("📄 Uploaded URL: $uploadedUrl");
//                                                 }
//                                               }
//                                             },
//                                           ),
//
//
//                                           //   doc.pickedFilePath == null ? "Upload" : "Uploaded",
//                                           //   onPressed: () async {
//                                           //     FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                           //       type: FileType.custom,
//                                           //       allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                           //     );
//                                           //     if (result != null && result.files.isNotEmpty) {
//                                           //       setState(() {
//                                           //         doc.pickedFilePath = result.files.single.path;
//                                           //       });
//                                           //     }
//                                           //   },
//                                           // ),
//                                         ),
//                                         SizedBox(width: 10.w),
//                                         if (index != 0) // First item fixed, no delete button
//                                           IconButton(
//                                             color:Colors.grey,
//                                             icon: Icon(Icons.delete_forever, color: Colors.red),
//                                             onPressed: () {
//                                               setState(() {
//                                                 profileSetupController.policeCheckLocalList.removeAt(index);
//                                               });
//                                             },
//                                           ),
//                                       ],
//                                     ),
//                                     SizedBox(height: 20.h),
//                                   ],
//                                 );
//                               }).toList(),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 50.w, right: 10),
//                                 child: CustomButton(
//                                   title: "+ Add More Doc",
//                                   titlecolor: AppColors.buttonPrimaryColor,
//                                   onpress: () {
//                                     setState(() {
//                                       profileSetupController.policeCheckLocalList.add(DocItem());
//                                     });
//                                   },
//                                 ),
//                               ),
//                               SizedBox(height: 20.h),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//
//
//
//                     ///---------Qualification-----------------------
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 10.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(width: 10.w),
//                               Image.asset(AppImages.qualiImg, width: 32.w, height: 48.h),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CustomText(
//                                   text: "Qualification",
//                                   color: AppColors.buttonPrimaryColor,
//                                   fontsize: 16.sp,
//                                   fontWeight: FontWeight.w600,
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           ...profileSetupController.qualificationLocalList.asMap().entries.map((entry) {
//                             int index = entry.key;
//                             DocItem data = entry.value;
//
//                             return Column(
//                               children: [
//                                 SizedBox(height: 10.h),
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 8.w,left: 50.w),
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 10.w),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: AppColors.primaryColor),
//                                       borderRadius: BorderRadius.circular(16.r),
//                                     ),
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton<String>(
//                                         value: data.selectedDropdownData,
//                                         hint: Text(
//                                           'Dropdown',
//                                           style: TextStyle(color: Colors.grey.shade600,fontSize: 12.sp),
//                                         ),
//                                         isExpanded: true,
//                                         icon: Icon(Icons.keyboard_arrow_down,
//                                             color: Colors.grey.shade700),
//                                         items: profileSetupController.qualificationDropdown.map((suburb) {
//                                           return DropdownMenuItem<String>(
//                                             value: suburb,
//                                             child: CustomText(
//                                               text: suburb,
//                                               fontsize: 12.sp,
//                                               color: AppColors.buttonPrimaryColor,
//                                             ),
//                                           );
//                                         }).toList(),
//                                         onChanged: (value) {
//                                           setState(() {
//                                             data.selectedDropdownData = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 20.h),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: 50.w),
//                                     Expanded(
//                                       flex:3,
//                                       child: CustomTextField(
//                                         contentPaddingVertical: 6.r,
//                                         borderRadio: 20.h,
//                                         filColor: Color(0xffEAF8F9),
//                                         controller: data.qualificationDateController,
//                                         readOnly: true,
//                                         onTap: () => _qualificationDateSelectDate(context, index),
//                                         hintText: "Enter expiry date",
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return "BirthDate cannot be empty";
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(width: 10.w),
//                                     Expanded(
//                                       flex:2,
//                                       child: UploadButton(
//                                         buttonText:
//                                         profileSetupController.qualificationLocalList[index].pickedFilePath == null
//                                             ? "Upload"
//                                             : "Uploaded",
//                                         onPressed: () async {
//                                           FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                             type: FileType.custom,
//                                             allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                           );
//
//                                           if (result != null && result.files.isNotEmpty) {
//                                             final path = result.files.single.path!;
//                                             final file = File(path);
//
//                                             // Upload file and get the server path
//                                             final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                             if (uploadedUrl != null) {
//                                               setState(() {
//                                                 profileSetupController.qualificationLocalList[index].pickedFilePath = uploadedUrl;
//                                               });
//                                               print("📄 Uploaded URL: $uploadedUrl");
//                                             }
//                                           }
//                                         },
//                                       ),
//                                       //   profileSetupController.qualificationLocalList[index].pickedFilePath == null
//                                       //       ? "Upload"
//                                       //       : "Uploaded",
//                                       //   onPressed: ()async{
//                                       //     FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                       //       type: FileType.custom,
//                                       //       allowedExtensions: ['pdf', 'jpeg'],
//                                       //     );
//                                       //
//                                       //     if (result != null && result.files.isNotEmpty) {
//                                       //       setState(() {
//                                       //         profileSetupController.qualificationLocalList[index].pickedFilePath = result.files.single.path;
//                                       //       });
//                                       //       print("file location:::___+++___+++:  ${profileSetupController.qualificationLocalList[index].pickedFilePath}");
//                                       //     }
//                                       //   },
//                                       // ),
//                                     ),
//                                     SizedBox(width: 10.w),
//                                     if (index != 0) // First item fixed, no delete button
//                                       IconButton(
//                                         color:Colors.grey,
//                                         icon: Icon(Icons.delete_forever, color: Colors.red),
//                                         onPressed: () {
//                                           setState(() {
//                                             profileSetupController.qualificationLocalList.removeAt(index);
//                                           });
//                                         },
//                                       ),
//                                     SizedBox(width: 10.w),
//                                   ],
//                                 ),
//                                 SizedBox(height: 20.h),
//                               ],
//                             );
//                           }).toList(),
//                           Padding(
//                             padding: EdgeInsets.only(left: 50.w,right: 10),
//                             child: CustomButton(
//                               title: "+ Add More Doc",
//                               titlecolor: AppColors.buttonPrimaryColor,
//                               onpress: () {
//                                 setState(() {
//                                   profileSetupController.qualificationLocalList.add(DocItem());
//                                 });
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                         ],
//                       ),
//                     ),
//
//
//                     ///---------First AID/CPR-----------------------
//                     SizedBox(height: 20.h),
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 10.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(width: 10.w),
//                               Image.asset(AppImages.aidImg, width: 32.w, height: 48.h),
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CustomText(
//                                   text: "First AID/CPR",
//                                   color: AppColors.buttonPrimaryColor,
//                                   fontsize: 16.sp,
//                                   fontWeight: FontWeight.w600,
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           ...profileSetupController.aidCprLocalList.asMap().entries.map((entry) {
//                             int index = entry.key;
//                             DocItem data = entry.value;
//
//                             return Column(
//                               children: [
//                                 SizedBox(height: 10.h),
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 8.w,left: 50.w),
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 10.w),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: AppColors.primaryColor),
//                                       borderRadius: BorderRadius.circular(16.r),
//                                     ),
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton<String>(
//                                         value: data.selectedDropdownData,
//                                         hint: Text(
//                                           'Dropdown',
//                                           style: TextStyle(color: Colors.grey.shade600,fontSize: 12.sp),
//                                         ),
//                                         isExpanded: true,
//                                         icon: Icon(Icons.keyboard_arrow_down,
//                                             color: Colors.grey.shade700),
//                                         items: profileSetupController.aidCprDropdown.map((suburb) {
//                                           return DropdownMenuItem<String>(
//                                             value: suburb,
//                                             child: CustomText(
//                                               text: suburb,
//                                               fontsize: 12.sp,
//                                               color: AppColors.buttonPrimaryColor,
//                                             ),
//                                           );
//                                         }).toList(),
//                                         onChanged: (value) {
//                                           setState(() {
//                                             data.selectedDropdownData = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 20.h),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: 50.w),
//                                     Expanded(
//                                       flex:3,
//                                       child: CustomTextField(
//                                         contentPaddingVertical: 6.r,
//                                         borderRadio: 20.h,
//                                         filColor: Color(0xffEAF8F9),
//                                         controller: data.aidCPRDateController,
//                                         readOnly: true,
//                                         onTap: () async{
//                                           DateTime? picked = await showDatePicker(
//                                             context: context,
//                                             initialDate: profileSetupController.aidCprLocalList[index].selectedDate ?? DateTime.now(),
//                                             firstDate: DateTime(1900),
//                                             lastDate: DateTime.now(),
//                                           );
//                                           if (picked != null) {
//                                             setState(() {
//                                               profileSetupController.aidCprLocalList[index].selectedDate = picked;
//                                               profileSetupController.aidCprLocalList[index].aidCPRDateController.text = "${picked.toLocal()}".split(' ')[0];
//                                             });
//                                           }
//                                         },
//                                         // async{
//                                         //   DateTime? picked = await showDatePicker(
//                                         //     context: context,
//                                         //     initialDate: DateTime.now(),
//                                         //     firstDate: DateTime(1900),
//                                         //     lastDate: DateTime.now(),
//                                         //   );
//                                         //   if (picked != null) {
//                                         //     setState(() {
//                                         //       profileSetupController.aidCprLocalList[index].selectedDate = picked;
//                                         //       profileSetupController.aidCprLocalList[index].aidCPRDateController.text = "${picked.toLocal()}".split(' ')[0];
//                                         //     });
//                                         //   }
//                                         //
//                                         // },
//                                         hintText: "Enter expiry date",
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return "Date cannot be empty";
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(width: 10.w),
//                                     Expanded(
//                                       flex: 2,
//                                       child: UploadButton(
//                                         buttonText: profileSetupController.aidCprLocalList[index].pickedFilePath == null
//                                             ? "Upload"
//                                             : "Uploaded",
//                                         onPressed: () async {
//                                           FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                             type: FileType.custom,
//                                             allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                           );
//
//                                           if (result != null && result.files.isNotEmpty) {
//                                             final path = result.files.single.path!;
//                                             final file = File(path);
//
//                                             // Upload file and get the server path
//                                             final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                             if (uploadedUrl != null) {
//                                               setState(() {
//                                                 profileSetupController.aidCprLocalList[index].pickedFilePath = uploadedUrl;
//                                               });
//                                               print("📄 Uploaded URL: $uploadedUrl");
//                                             }
//                                           }
//                                         },
//                                       ),
//                                       //   profileSetupController.aidCprLocalList[index].pickedFilePath == null
//                                       //       ? "Upload"
//                                       //       : "Uploaded",
//                                       //   onPressed: ()async{
//                                       //     FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                       //       type: FileType.custom,
//                                       //       allowedExtensions: ['pdf', 'jpeg'],
//                                       //     );
//                                       //
//                                       //     if (result != null && result.files.isNotEmpty) {
//                                       //       setState(() {
//                                       //         profileSetupController.aidCprLocalList[index].pickedFilePath = result.files.single.path;
//                                       //       });
//                                       //       print("file location:::___+++___+++:  ${profileSetupController.aidCprLocalList[index].pickedFilePath}");
//                                       //     }
//                                       //   },
//                                       // ),
//                                     ),
//                                     if (index != 0) // First item fixed, no delete button
//                                       IconButton(
//                                         color:Colors.grey,
//                                         icon: Icon(Icons.delete_forever, color: Colors.red),
//                                         onPressed: () {
//                                           setState(() {
//                                             profileSetupController.aidCprLocalList.removeAt(index);
//                                           });
//                                         },
//                                       ),
//                                     SizedBox(width: 10.w),
//                                   ],
//                                 ),
//                                 SizedBox(height: 20.h),
//                               ],
//                             );
//                           }).toList(),
//                           Padding(
//                             padding: EdgeInsets.only(left: 50.w,right: 10),
//                             child: CustomButton(
//                               title: "+ Add More Doc",
//                               titlecolor: AppColors.buttonPrimaryColor,
//                               onpress: () {
//                                 setState(() {
//                                   profileSetupController.aidCprLocalList.add(DocItem());
//                                 });
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20.h,),
//
//
//                     ///-----Working with Children(If Applicable)---------------------------
//                     Container(
//                       decoration: BoxDecoration(borderRadius: BorderRadius.circular(24.r),color: AppColors.whiteColor),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 10.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(width: 10.w),
//                               Image.asset(AppImages.workChildImg, width: 32.w,height: 48.h),
//
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CustomText(text: "Working with Children\n(If Applicable)",textAlign:TextAlign.start,color: AppColors.buttonPrimaryColor,fontsize: 16.sp,fontWeight: FontWeight.w600
//                                   ,),
//                               )
//                             ],),
//                           SizedBox(height: 10.h),
//                           Row(
//                             children: [
//                               SizedBox(width: 50.w),
//                               Expanded(
//                                 flex: 3,
//                                 child: CustomTextField(
//                                   contentPaddingVertical: 6.r,
//                                   borderRadio: 20.h,
//                                   filColor: Color(0xffEAF8F9),
//                                   controller: workChildDateController,
//                                   readOnly: true,
//                                   onTap: () async{
//                                     DateTime? selectedDate = await showDatePicker(
//                                       context: context,
//                                       initialDate: DateTime.now(),
//                                       firstDate: DateTime(1950),
//                                       lastDate: DateTime.now(),
//                                     );
//                                     if (selectedDate != null) {
//                                       setState(() {
//                                         _startDate = selectedDate;
//                                         workChildDateController.text = DateFormat('yyyy-MM-dd').format(_startDate!);
//                                       });
//                                     }
//                                   },
//                                   hintText: "Enter Expiry date",
//                                   // suffixIcon: Icon(Icons.calendar_month,color: AppColors.primaryColor,),
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "BirthDate cannot be empty";
//                                     }
//                                     // if (!AppConstants.emailValidate.hasMatch(value)) {
//                                     //   return "Invalid email address";
//                                     // }
//                                     return null;
//                                   },
//                                 ),
//                               ),
//                               Expanded(
//                                 flex: 2,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: UploadButton(buttonText:
//                                   profileSetupController.pickedWorkChildFilePath == null
//                                       ? "Upload"
//                                       : "Uploaded",
//                                     onPressed: () async {
//                                       FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                         type: FileType.custom,
//                                         allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                       );
//
//                                       if (result != null && result.files.isNotEmpty) {
//                                         final path = result.files.single.path!;
//                                         final file = File(path);
//
//                                         // Upload file and get the server path
//                                         final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                         if (uploadedUrl != null) {
//                                           setState(() {
//                                             profileSetupController.pickedWorkChildFilePath = uploadedUrl;
//                                           });
//                                           print("📄 Uploaded URL: $uploadedUrl");
//                                         }
//                                       }
//                                     },
//                                   ),
//
//                                 ),
//                               ),
//                               SizedBox(width: 10.w),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           Padding(
//                             padding:  EdgeInsets.only(left: 50.w),
//                             child: Row(
//                               children: [
//                                 SvgPicture.asset(documentResponseModel.workingWithChildren?.isVerifyed == "approved" ? AppIcons.verifyIcon: documentResponseModel.workingWithChildren?.isVerifyed == "pending"? AppIcons.pendingIcon: AppIcons.warningIcon,width: 20.w,height: 20.h,),
//                                 SizedBox(width: 8.w),
//                                 CustomText(text: documentResponseModel.workingWithChildren?.isVerifyed == "approved" ?  "Verified" : documentResponseModel.workingWithChildren?.isVerifyed == "pending"?  "Waiting for Verification": "Not Approved", color: documentResponseModel.workingWithChildren?.isVerifyed == "approved"? Color(0xff009A3F):documentResponseModel.workingWithChildren?.isVerifyed == "pending"? Color(0xffE9B000):Color(0xffF70004),fontsize: 12.sp, fontWeight: FontWeight.bold,)
//                               ],
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20.h,),
//
//
//                     ///---------Vaccination-----------------------
//                     Container(
//                       decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
//                       child: Column(
//                         children: [
//                           SizedBox(height: 10.h),
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               SizedBox(width: 10.w),
//                               Image.asset(AppImages.vacImg, width: 32.w, height: 48.h),
//
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CustomText(
//                                   text: "Vaccination",
//                                   color: AppColors.buttonPrimaryColor,
//                                   fontsize: 16.sp,
//                                   fontWeight: FontWeight.w600,
//                                   textAlign: TextAlign.start,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 10.h),
//                           ...profileSetupController.vaccinationLocalList.asMap().entries.map((entry) {
//                             int index = entry.key;
//                             DocItem data = entry.value;
//
//                             return Column(
//                               children: [
//                                 SizedBox(height: 10.h),
//                                 Padding(
//                                   padding: EdgeInsets.only(right: 8.w,left: 50.w),
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(horizontal: 10.w),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(color: AppColors.primaryColor),
//                                       borderRadius: BorderRadius.circular(16.r),
//                                     ),
//                                     child: DropdownButtonHideUnderline(
//                                       child: DropdownButton<String>(
//                                         value: data.selectedDropdownData,
//                                         hint: Text(
//                                           'Dropdown',
//                                           style: TextStyle(color: Colors.grey.shade600,fontSize: 12.sp),
//                                         ),
//                                         isExpanded: true,
//                                         icon: Icon(Icons.keyboard_arrow_down,
//                                             color: Colors.grey.shade700),
//                                         items: profileSetupController.vaccinationDropdown.map((suburb) {
//                                           return DropdownMenuItem<String>(
//                                             value: suburb,
//                                             child: CustomText(
//                                               text: suburb,
//                                               fontsize: 12.sp,
//                                               color: AppColors.buttonPrimaryColor,
//                                             ),
//                                           );
//                                         }).toList(),
//                                         onChanged: (value) {
//                                           setState(() {
//                                             data.selectedDropdownData = value;
//                                           });
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 20.h),
//                                 Row(
//                                   children: [
//                                     SizedBox(width: 50.w),
//                                     Expanded(
//                                       flex:3,
//                                       child: CustomTextField(
//                                         contentPaddingVertical: 6.r,
//                                         borderRadio: 20.h,
//                                         filColor: Color(0xffEAF8F9),
//                                         controller: data.vaccinDateController,
//                                         readOnly: true,
//                                         onTap: () async{
//                                           DateTime? picked = await showDatePicker(
//                                             context: context,
//                                             initialDate: DateTime.now(),
//                                             firstDate: DateTime(1900),
//                                             lastDate: DateTime.now(),
//                                           );
//                                           if (picked != null) {
//                                             setState(() {
//                                               profileSetupController.vaccinationLocalList[index].selectedDate = picked;
//                                               profileSetupController.vaccinationLocalList[index].vaccinDateController.text = "${picked.toLocal()}".split(' ')[0];
//                                             });
//                                           }
//
//                                         },
//                                         hintText: "Enter Publish date",
//                                         validator: (value) {
//                                           if (value == null || value.isEmpty) {
//                                             return "Date cannot be empty";
//                                           }
//                                           return null;
//                                         },
//                                       ),
//                                     ),
//                                     SizedBox(width: 10.w),
//                                     Expanded(
//                                       flex:2,
//                                       child: UploadButton(
//                                         buttonText: profileSetupController.vaccinationLocalList[index].pickedFilePath == null
//                                             ? "Upload"
//                                             : "Uploaded",
//                                         onPressed: () async {
//                                           FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                             type: FileType.custom,
//                                             allowedExtensions: ['pdf', 'jpeg', 'png'],
//                                           );
//
//                                           if (result != null && result.files.isNotEmpty) {
//                                             final path = result.files.single.path!;
//                                             final file = File(path);
//
//                                             // Upload file and get the server path
//                                             final uploadedUrl = await profileSetupController.uploadIMG(image: file);
//
//                                             if (uploadedUrl != null) {
//                                               setState(() {
//                                                 profileSetupController.vaccinationLocalList[index].pickedFilePath = uploadedUrl;
//                                               });
//                                               print("📄 Uploaded URL: $uploadedUrl");
//                                             }
//                                           }
//                                         },
//                                       ),
//                                       //   profileSetupController.vaccinationLocalList[index].pickedFilePath == null
//                                       //       ? "Upload"
//                                       //       : "Uploaded",
//                                       //   onPressed: ()async{
//                                       //     FilePickerResult? result = await FilePicker.platform.pickFiles(
//                                       //       type: FileType.custom,
//                                       //       allowedExtensions: ['pdf', 'jpeg'],
//                                       //     );
//                                       //
//                                       //     if (result != null && result.files.isNotEmpty) {
//                                       //       setState(() {
//                                       //         profileSetupController.vaccinationLocalList[index].pickedFilePath = result.files.single.path;
//                                       //       });
//                                       //       print("file location:::___+++___+++:  ${profileSetupController.vaccinationLocalList[index].pickedFilePath}");
//                                       //     }
//                                       //   },
//                                       // ),
//                                     ),
//                                     if (index != 0) // First item fixed, no delete button
//                                       IconButton(
//                                         color:Colors.grey,
//                                         icon: Icon(Icons.delete_forever, color: Colors.red),
//                                         onPressed: () {
//                                           setState(() {
//                                             profileSetupController.vaccinationLocalList.removeAt(index);
//                                           });
//                                         },
//                                       ),
//                                     SizedBox(width: 10.w),
//                                   ],
//                                 ),
//                                 SizedBox(height: 20.h),
//                               ],
//                             );
//                           }).toList(),
//                           Padding(
//                             padding: EdgeInsets.only(left: 50.w,right: 10.w),
//                             child: CustomButton(
//                               title: "+ Add More Doc",
//                               titlecolor: AppColors.buttonPrimaryColor,
//                               onpress: () {
//                                 setState(() {
//                                   profileSetupController.vaccinationLocalList.add(DocItem());
//                                 });
//                               },
//                             ),
//                           ),
//                           SizedBox(height: 20.h),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20.h,),
//
//
//
//
//                     ///-----ABN-----------------------
//                     Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
//                         child: Padding(
//                           padding:  EdgeInsets.symmetric(horizontal: 20.h),
//                           child: Column(
//                               children: [
//                                 SizedBox(height: 10.h),
//
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Image.asset(AppImages.abnImg, width: 32.w, height: 48.h),
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: CustomText(
//                                         text: "ABN*",
//                                         color: AppColors.buttonPrimaryColor,
//                                         fontsize: 16.sp,
//                                         fontWeight: FontWeight.w600,
//                                         textAlign: TextAlign.start,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 20.h),
//                                 CustomTextField(
//                                   contentPaddingVertical: 8.r,
//                                   borderRadio: 20.h,
//                                   filColor: Color(0xffEAF8F9),
//                                   controller: abnController,
//                                   hintText: "ABN number",
//                                   keyboardType:TextInputType.number,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "ABN cannot be empty";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(height: 20.h),
//                                 CustomTextField(   contentPaddingVertical: 8.r,
//                                   borderRadio: 20.h,
//                                   filColor: Color(0xffEAF8F9),
//                                   controller: businessNameController,
//                                   hintText: "Business name",
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "Business cannot be empty";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Obx(()=>
//                                         Checkbox(
//                                           checkColor: Colors.white,
//                                           activeColor: AppColors.primaryColor,
//                                           value: profileSetupController.isGSTCheck.value,
//                                           onChanged: (value) {
//                                             profileSetupController.isGSTCheck.value = value!;
//                                           },
//                                         ),
//                                     ),
//
//                                     CustomText(text: "GST Registered",color: AppColors.buttonPrimaryColor,fontWeight: FontWeight.w500,fontsize: 14.sp,),
//
//                                   ],
//                                 ),
//                                 CustomText(text: "You can quickly apply for an ABN online for \nfree at abn.gov.au",maxline: 3,textAlign: TextAlign.start,fontWeight: FontWeight.w500,color: AppColors.buttonPrimaryColor,),
//                                 SizedBox(height: 20.h),
//                               ]
//                           ),
//                         )),
//                     SizedBox(height: 20.h,),
//
//
//
//
//
//                     ///-----Bank Details-----------------------
//                     Container(
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(24.r), color: AppColors.whiteColor),
//                         child: Padding(
//                           padding:  EdgeInsets.symmetric(horizontal: 20.h),
//                           child: Column(
//                               children: [
//                                 SizedBox(height: 10.h),
//
//                                 Row(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//
//                                     Image.asset(AppImages.bankImg, width: 32.w, height: 48.h),
//
//                                     Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: CustomText(
//                                         text: "Bank Details*",
//                                         color: AppColors.buttonPrimaryColor,
//                                         fontsize: 16.sp,
//                                         fontWeight: FontWeight.w600,
//                                         textAlign: TextAlign.start,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(height: 20.h),
//                                 CustomTextField(
//                                   contentPaddingVertical: 8.r,
//                                   borderRadio: 20.h,
//                                   filColor: Color(0xffEAF8F9),
//                                   controller: BSBController,
//                                   hintText: "BSB number",
//                                   keyboardType:TextInputType.number,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "Enter BSB number";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//                                 SizedBox(height: 20.h),
//                                 CustomTextField(
//                                   contentPaddingVertical: 8.r,
//                                   borderRadio: 20.h,
//                                   filColor: Color(0xffEAF8F9),
//                                   controller: accountNoController,
//                                   hintText: "Account number",
//                                   keyboardType:TextInputType.number,
//                                   validator: (value) {
//                                     if (value == null || value.isEmpty) {
//                                       return "Enter Account number";
//                                     }
//                                     return null;
//                                   },
//                                 ),
//
//                                 SizedBox(height: 20.h),
//                               ]
//                           ),
//                         )),
//                     SizedBox(height: 20.h),
//
//
//
//                     SizedBox(height: 20.h),
//                     CustomButtonCommon(title: "Update",
//                         onpress: (){
//
//                           profileSetupController.uploadDocuments(
//                               passportExpiry: passportDateCNTRL.text,
//                               passportFilePath: documentResponseModel.passport?.document,
//
//                               driveExpiry: driveController.text,
//                               driveFrontPath: profileSetupController.driveFontFilePath ?? documentResponseModel.drivingLicense?.frontDocument,
//                               driveBackPath: profileSetupController.driveBackFilePath ?? documentResponseModel.drivingLicense?.backDocument,
//
//                               policeChecks: mergedPoliceCheckList,
//
//                               carInsDropdown: profileSetupController.selectedCarInsDropdown ?? "",
//                               carInsExpiry: carController.text,
//                               carInsFilePath: profileSetupController.pickedCarFilePath ?? "",
//
//                               qualificationLists: profileSetupController.qualificationLocalList,
//
//                               firstAidCPR: profileSetupController.aidCprLocalList,
//
//                               workingWithChildrenExpiry: workChildDateController.text,
//                               workingWithChildrenFilePath: profileSetupController.pickedWorkChildFilePath ?? "",
//
//                               vaccinations: profileSetupController.vaccinationLocalList,
//
//                               abnNumber: abnController.text,
//                               businessName: businessNameController.text,
//
//                               bsbNumber: BSBController.text,
//                               accountNumber: accountNoController.text
//
//                           );
//                           // Get.toNamed(AppRoutes.allBottomBarScreen,preventDuplicates: false);
//                         }),
//                     SizedBox(height: 20.h),
//
//                   ],
//                 )
//             ),
//           ),
//         )
//     );
//   }
// }
// class ViewButton extends StatelessWidget {
//   ViewButton({super.key, required this.buttonText, required this.onPressed,});
//   final String buttonText;
//   final VoidCallback onPressed;
//   @override
//   Widget build(BuildContext context) {
//     // return ElevatedButton.icon(
//     //   style: ElevatedButton.styleFrom(
//     //     backgroundColor: const Color(0xFF0E515F),
//     //     shape: RoundedRectangleBorder(
//     //       borderRadius: BorderRadius.circular(12.r),
//     //     ),
//     //     padding:  EdgeInsets.symmetric(horizontal: 20.w,),
//     //   ),
//     //   onPressed: onPressed,
//     //   icon:  Icon(
//     //     Icons.upload_rounded,
//     //     size: 12.sp,
//     //     color: Colors.white,
//     //   ),
//     //   label:
//     //   CustomText(text: buttonText,color: AppColors.whiteColor,fontsize: 12.sp,)
//     //
//     // );
//     return InkWell(
//       onTap: onPressed,
//       child: Container(
//         height: 54.h,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),color: Color(0xFF0E515F),),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             // Icon(
//             //   Icons.upload_rounded,
//             //   size: 12.sp,
//             // //   color: Colors.white,
//             // // ),
//
//             SizedBox(width: 10.w,),
//             CustomText(text: buttonText,color: AppColors.whiteColor,fontsize: 12.sp,)
//           ],),
//       ),
//     );
//   }
// }




import 'dart:io';

import 'package:careshiftapp/services/api_constants.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../controller/controllers.dart';
import '../../../helpers/helpers.dart';
import '../../../models/models.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../complete_profile/profile_setup_document_screen.dart';
import 'settings/pdf_view_screen.dart';

class ShowUpdateProfileDocScreen extends StatefulWidget {
  const ShowUpdateProfileDocScreen({super.key});

  @override
  State<ShowUpdateProfileDocScreen> createState() => _ShowUpdateProfileDocScreenState();
}

class _ShowUpdateProfileDocScreenState extends State<ShowUpdateProfileDocScreen> {

  DateTime? _startDate;
  ProfileSetupController profileSetupController = Get.find<ProfileSetupController>();

  // Controllers
  TextEditingController carController = TextEditingController();
  TextEditingController passportDateCNTRL = TextEditingController();
  TextEditingController driveController = TextEditingController();
  TextEditingController workChildDateController = TextEditingController();
  TextEditingController abnController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController BSBController = TextEditingController();
  TextEditingController accountNoController = TextEditingController();

  RxBool isChecked = false.obs;
  DocumentResponseModel? documentResponseModel;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  // SOLUTION 1: Proper initialization method
  Future<void> _initializeData() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Clear any existing data first
      _clearAllData();

      // Fetch fresh document data
      await profileSetupController.fetchDocumentResponse();

      // Get the document data - either from arguments or from controller
      if (Get.arguments != null && Get.arguments is DocumentResponseModel) {
        documentResponseModel = Get.arguments as DocumentResponseModel;
      } else {
        // If no arguments, get from controller's latest data
        documentResponseModel = profileSetupController.documentResponseModel.value;
      }

      if (documentResponseModel != null) {
        _populateFields();
      }
    } catch (e) {
      print("Error initializing data: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // SOLUTION 2: Clear all existing data
  void _clearAllData() {
    // Clear text controllers
    passportDateCNTRL.clear();
    driveController.clear();
    carController.clear();
    workChildDateController.clear();
    abnController.clear();
    businessNameController.clear();
    BSBController.clear();
    accountNoController.clear();

    // Clear controller lists
    profileSetupController.aidCprLocalList.clear();
    profileSetupController.vaccinationLocalList.clear();
    profileSetupController.policeCheckLocalList.clear();
    profileSetupController.qualificationLocalList.clear();

    // Reset file paths
    profileSetupController.pickedPassportFilePath = null;
    profileSetupController.driveFontFilePath = null;
    profileSetupController.driveBackFilePath = null;
    profileSetupController.pickedCarFilePath = null;
    profileSetupController.pickedWorkChildFilePath = null;

    // Reset dropdown selections
    profileSetupController.selectedCarInsDropdown = null;
  }

  // SOLUTION 3: Populate fields with fresh data
  void _populateFields() {
    if (documentResponseModel == null) return;

    // Passport data
    if (documentResponseModel!.passport?.expiryDate != null) {
      passportDateCNTRL.text = TimeFormatHelper.formatDate(
          DateTime.parse(documentResponseModel!.passport!.expiryDate!.toIso8601String())
      );
    } else {
      passportDateCNTRL.text = "No expiry date available";
    }

    // Driving license data
    if (documentResponseModel!.drivingLicense?.expiryDate != null) {
      driveController.text = TimeFormatHelper.formatDate(
          DateTime.parse(documentResponseModel!.drivingLicense!.expiryDate!.toIso8601String())
      );
    } else {
      driveController.text = "No expiry date";
    }

    // Working with children data
    if (documentResponseModel!.workingWithChildren?.expiryDate != null) {
      workChildDateController.text = TimeFormatHelper.formatDate(
          DateTime.parse(documentResponseModel!.workingWithChildren!.expiryDate!.toIso8601String())
      );
    } else {
      workChildDateController.text = "No expiry date";
    }

    // Car insurance data
    if (documentResponseModel!.carInsuranceCertificate?.expiryDate != null) {
      carController.text = TimeFormatHelper.formatDate(
          DateTime.parse(documentResponseModel!.carInsuranceCertificate!.expiryDate!.toIso8601String())
      );
    } else {
      carController.text = "No expiry date";
    }


    // ABN and Bank details
    abnController.text = documentResponseModel!.abn?.abnNumber ?? "";
    businessNameController.text = documentResponseModel!.abn?.businessName ?? "";
    BSBController.text = documentResponseModel!.bankDetails?.bsbNumber ?? "";
    accountNoController.text = documentResponseModel!.bankDetails?.accountNumber ?? "";

    // Initialize lists with at least one empty item if they're empty
    if (profileSetupController.aidCprLocalList.isEmpty) {
      profileSetupController.aidCprLocalList.add(DocItem());
    }
    if (profileSetupController.vaccinationLocalList.isEmpty) {
      profileSetupController.vaccinationLocalList.add(DocItem());
    }
    if (profileSetupController.policeCheckLocalList.isEmpty) {
      profileSetupController.policeCheckLocalList.add(DocItem());
    }
    if (profileSetupController.qualificationLocalList.isEmpty) {
      profileSetupController.qualificationLocalList.add(DocItem());
    }
  }

  // SOLUTION 4: Add refresh method for pull-to-refresh or manual refresh
  Future<void> _refreshData() async {
    await _initializeData();
  }

  @override
  void dispose() {
    carController.dispose();
    passportDateCNTRL.dispose();
    driveController.dispose();
    workChildDateController.dispose();
    abnController.dispose();
    businessNameController.dispose();
    BSBController.dispose();
    accountNoController.dispose();

    // Clear lists on dispose
    profileSetupController.aidCprLocalList.clear();
    profileSetupController.vaccinationLocalList.clear();
    profileSetupController.policeCheckLocalList.clear();
    profileSetupController.qualificationLocalList.clear();
    super.dispose();
  }

  // Date selection methods remain the same
  void _selectDate(BuildContext context) async {
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

  void _selectDriveDate(BuildContext context) async {
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

  void _selectCarDate(BuildContext context) async {
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

  List<DocItem> get mergedPoliceCheckList {
    final existingDocs = documentResponseModel?.policeCheck?.map((doc) {
      final parsedDate = DateTime.tryParse(doc.publishDate?.toIso8601String() ?? '');
      // final isVerified = doc.isVerifyed;
      //
      // // Map the isVerifyed String to bool
      // final isFromServer =  isVerified == "approved" && isVerified == "pending" && isVerified == "canceled";

      return DocItem(
        selectedDropdownData: doc.type,
        pickedFilePath: doc.document,
        selectedDate: parsedDate,
        isFromServer: doc.isVerifyed,
      );
    }).toList() ?? [];

    return [...existingDocs, ...profileSetupController.policeCheckLocalList];
  }

  List<DocItem> get mergedQualificationsList {
    final existingDocs = documentResponseModel?.qualification?.map((doc) {
      final parsedDate = DateTime.tryParse(doc.expiryDate?.toIso8601String() ?? '');

      return DocItem(
        selectedDropdownData: doc.type,
        pickedFilePath: doc.certificate,
        selectedDate: parsedDate,
        isFromServer: doc.isVerifyed,
      );
    }).toList() ?? [];

    return [...existingDocs, ...profileSetupController.qualificationLocalList];
  }
  List<DocItem> get mergedFirstAIDDataList {
    final existingDocs = documentResponseModel?.firstAid?.map((doc) {
      final parsedDate = DateTime.tryParse(doc.expiryDate?.toIso8601String() ?? '');

      return DocItem(
        selectedDropdownData: doc.type,
        pickedFilePath: doc.document,
        selectedDate: parsedDate,
        isFromServer: doc.isVerifyed,
      );
    }).toList() ?? [];

    return [...existingDocs, ...profileSetupController.aidCprLocalList];
  }

  List<DocItem> get mergedVaccinationDataList {
    final existingDocs = documentResponseModel?.vaccination?.map((doc) {
      final parsedDate = DateTime.tryParse(doc.publishDate?.toIso8601String() ?? '');
      return DocItem(
        selectedDropdownData: doc.type,
        pickedFilePath: doc.certificate,
        selectedDate: parsedDate,
        isFromServer: doc.isVerifyed,
      );
    }).toList() ?? [];

    return [...existingDocs, ...profileSetupController.vaccinationLocalList];
  }


  @override
  Widget build(BuildContext context) {

   // print("documentResponseModel.abn?.businessName${documentResponseModel.abn?.businessName}");
    return  Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(title: CustomText(text: "Document",fontWeight: FontWeight.w600,fontsize: 20.sp,color: AppColors.whiteColor,),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child:
        
              isLoading
                  ? Center(child: CircularProgressIndicator())
                  : documentResponseModel == null
                  ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 64, color: Colors.grey),
                    SizedBox(height: 16),
                    Text("No document data available"),
                    SizedBox(height: 20),
        
                    // METHOD 2: Manual retry button for error state
                    ElevatedButton.icon(
                      onPressed: () async {
                        await _refreshData();
                      },
                      icon: Icon(Icons.refresh),
                      label: Text("Retry"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
                  :  RefreshIndicator(
                onRefresh: _refreshData,
                child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
        
                        ///-----Passport---------------------------
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24.r),
                              color: AppColors.whiteColor),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(width: 10.w),
                                  Image.asset(
                                      "assets/images/passportIcon.png", width: 32.w,
                                      height: 48.h),
        
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CustomText(text: "Passport*",
                                      color: AppColors.buttonPrimaryColor,
                                      fontsize: 16.sp,
                                      fontWeight: FontWeight.w600
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
                                      onTap: () => documentResponseModel?.passport?.isVerifyed == "approved" ?SizedBox.shrink(): _selectDate(context),
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
                                    child: documentResponseModel?.passport?.isVerifyed == "approved" ?  ViewButton(
                                      buttonText: "View",
                                      onPressed: () async {
        
                                        String? documentPath = documentResponseModel?.passport?.document;
        
                                        if (documentPath != null) {
                                          String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
        
                                          if (fileExtension == 'pdf') {
                                            print("This is a PDF document.");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => PdfViewScreen(
                                                  pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                ),
                                              ),
                                            );
        
                                          } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
                                            print("This is an image file.");
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: CustomNetworkImage(
                                                      boxShape: BoxShape.rectangle,
                                                      imageUrl:'${ApiConstants.imageBaseUrl}${documentPath}',
                                                      height: 200.h,
                                                      width: double.infinity
                                                    ),// Display the image from the URL
                                                  );
                                                },
                                              );
                                            // Add your image viewer logic here (e.g., use Image widget)
                                          } else {
                                            // Handle other file types or unsupported types
                                            print("Unsupported file type.");
                                          }
                                        } else {
                                          print("Document path is null");
                                        }
        
        
                                      },
                                    ) : UploadButton(
                                      buttonText: documentResponseModel?.passport?.document == null
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
                              Padding(
                                padding:  EdgeInsets.only(left: 50.w),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(documentResponseModel?.passport?.isVerifyed == "approved" ? AppIcons.verifyIcon: documentResponseModel?.passport?.isVerifyed == "pending"? AppIcons.pendingIcon: AppIcons.warningIcon,width: 20.w,height: 20.h,),
                                    SizedBox(width: 8.w),
                                    CustomText(text: documentResponseModel?.passport?.isVerifyed == "approved" ?  "Verified" : documentResponseModel?.passport?.isVerifyed == "pending"?  "Waiting for Verification": "Not Approved", color: documentResponseModel?.passport?.isVerifyed == "approved"? Color(0xff009A3F):documentResponseModel?.passport?.isVerifyed == "pending"? Color(0xffE9B000):Color(0xffF70004),fontsize: 12.sp, fontWeight: FontWeight.bold,)
                                  ],
                                ),
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
                                          onTap: () => documentResponseModel?.drivingLicense?.isVerifyed != "approved"  ? _selectDriveDate(context):SizedBox.shrink(),
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
                                        documentResponseModel?.drivingLicense?.isVerifyed != "approved"  ? UploadButton(buttonText: documentResponseModel?.drivingLicense?.frontDocument == null
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
                                        ):ViewButton(
                                          buttonText: "View",
                                          onPressed: () async {
        
                                            String? documentPath = documentResponseModel?.drivingLicense?.frontDocument;
        
                                            if (documentPath != null) {
                                              String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
        
                                              if (fileExtension == 'pdf') {
                                                print("This is a PDF document.");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => PdfViewScreen(
                                                      pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                    ),
                                                  ),
                                                );
        
                                              } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
                                                print("This is an image file.");
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: CustomNetworkImage(
                                                          boxShape: BoxShape.rectangle,
                                                          imageUrl:'${ApiConstants.imageBaseUrl}${documentPath}',
                                                          height: 200.h,
                                                          width: double.infinity
                                                      ),// Display the image from the URL
                                                    );
                                                  },
                                                );
                                                // Add your image viewer logic here (e.g., use Image widget)
                                              } else {
                                                // Handle other file types or unsupported types
                                                print("Unsupported file type.");
                                              }
                                            } else {
                                              print("Document path is null");
                                            }
        
        
                                          },
                                        ),
                                        SizedBox(height: 6.h,),
                                        documentResponseModel?.drivingLicense?.isVerifyed != "approved"   ?  UploadButton(buttonText: documentResponseModel?.drivingLicense?.backDocument == null
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
                                        ) :ViewButton(
                                          buttonText: "View",
                                          onPressed: () async {
        
                                            String? documentPath = documentResponseModel?.drivingLicense?.backDocument;
        
                                            if (documentPath != null) {
                                              String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
        
                                              if (fileExtension == 'pdf') {
                                                print("This is a PDF document.");
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) => PdfViewScreen(
                                                      pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                    ),
                                                  ),
                                                );
        
                                              } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
                                                print("This is an image file.");
                                                showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Dialog(
                                                      child: CustomNetworkImage(
                                                          boxShape: BoxShape.rectangle,
                                                          imageUrl:'${ApiConstants.imageBaseUrl}${documentPath}',
                                                          height: 200.h,
                                                          width: double.infinity
                                                      ),// Display the image from the URL
                                                    );
                                                  },
                                                );
                                                // Add your image viewer logic here (e.g., use Image widget)
                                              } else {
                                                // Handle other file types or unsupported types
                                                print("Unsupported file type.");
                                              }
                                            } else {
                                              print("Document path is null");
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
                              Padding(
                                padding:  EdgeInsets.only(left: 50.w),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(documentResponseModel?.drivingLicense?.isVerifyed == "approved" ? AppIcons.verifyIcon: documentResponseModel?.drivingLicense?.isVerifyed == "pending"? AppIcons.pendingIcon: AppIcons.warningIcon,width: 20.w,height: 20.h,),
                                    SizedBox(width: 8.w),
                                    CustomText(text: documentResponseModel?.drivingLicense?.isVerifyed == "approved" ?  "Verified" : documentResponseModel?.drivingLicense?.isVerifyed == "pending"?  "Waiting for Verification": "Not Approved", color: documentResponseModel?.drivingLicense?.isVerifyed == "approved"? Color(0xff009A3F):documentResponseModel?.passport?.isVerifyed == "pending"? Color(0xffE9B000):Color(0xffF70004),fontsize: 12.sp, fontWeight: FontWeight.bold,)
                                  ],
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
                             documentResponseModel?.carInsuranceCertificate?.isVerifyed == "approved" ? Row(
                                children: [
                                  SizedBox(width: 50.w),
                                  Expanded(
                                    flex: 3,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 10.h),
                                        Container(
                                          height: 60.h,
                                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                                          decoration: BoxDecoration(
                                            border: Border.all(color: AppColors.primaryColor),
                                            borderRadius: BorderRadius.circular(20.r),
                                          ),
                                          child: Center(child: CustomText(text: documentResponseModel!.carInsuranceCertificate!.type.toString(),))
                                        ),
                                        SizedBox(height: 10.h),
                                        CustomTextField(
                                          contentPaddingVertical: 6.r,
                                          borderRadio: 20.h,
                                          filColor: Color(0xffEAF8F9),
                                          controller: carController,
                                          readOnly: true,
                                          onTap: () => documentResponseModel?.carInsuranceCertificate!.isVerifyed != "approved" ?_selectCarDate(context):SizedBox.shrink(),
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
                                      child: ViewButton(
                                        buttonText: "View",
                                        onPressed: () async {
        
                                          String? documentPath = documentResponseModel?.carInsuranceCertificate?.certificate;
        
                                          if (documentPath != null) {
                                            String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
        
                                            if (fileExtension == 'pdf') {
                                              print("This is a PDF document.");
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PdfViewScreen(
                                                    pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                  ),
                                                ),
                                              );
        
                                            } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
                                              print("This is an image file.");
                                              showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return Dialog(
                                                    child: CustomNetworkImage(
                                                        boxShape: BoxShape.rectangle,
                                                        imageUrl:'${ApiConstants.imageBaseUrl}${documentPath}',
                                                        height: 200.h,
                                                        width: double.infinity
                                                    ),// Display the image from the URL
                                                  );
                                                },
                                              );
                                              // Add your image viewer logic here (e.g., use Image widget)
                                            } else {
                                              // Handle other file types or unsupported types
                                              print("Unsupported file type.");
                                            }
                                          } else {
                                            print("Document path is null");
                                          }
        
        
                                        },
                                      )
        
                                    ),
        
                                  ),
                                  SizedBox(width: 10.w),
                                ],
                              ) : Row(
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
                                     documentResponseModel?.carInsuranceCertificate?.certificate == null
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
                              Padding(
                                padding:  EdgeInsets.only(left: 50.w),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(documentResponseModel?.carInsuranceCertificate?.isVerifyed == "approved" ? AppIcons.verifyIcon: documentResponseModel?.carInsuranceCertificate?.isVerifyed == "pending"? AppIcons.pendingIcon: AppIcons.warningIcon,width: 20.w,height: 20.h,),
                                    SizedBox(width: 8.w),
                                    CustomText(text: documentResponseModel?.carInsuranceCertificate?.isVerifyed == "approved" ?  "Verified" : documentResponseModel?.carInsuranceCertificate?.isVerifyed == "pending"?  "Waiting for Verification": "Not Approved", color: documentResponseModel?.carInsuranceCertificate?.isVerifyed == "approved"? Color(0xff009A3F):documentResponseModel?.carInsuranceCertificate?.isVerifyed == "pending"? Color(0xffE9B000):Color(0xffF70004),fontsize: 12.sp, fontWeight: FontWeight.bold,)
                                  ],
                                ),
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
                                      text: " Checks*",
                                      color: AppColors.buttonPrimaryColor,
                                      fontsize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h),
                              ...mergedPoliceCheckList.asMap().entries.map((entry) {
                                final index = entry.key;
                                final doc = entry.value;
                                final isNew = doc.isFromServer;

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
                                            )).toList(),
                                            onChanged: isNew != "approved"
                                                ? (value) {
                                              setState(() {
                                                doc.selectedDropdownData = value;
                                              });
                                            }
                                                : null,
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
                                            onTap: isNew != "approved"
                                                ? () async {
                                              DateTime? picked = await showDatePicker(
                                                context: context,
                                                initialDate: doc.selectedDate ?? DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );
                                              if (picked != null) {
                                                setState(() {
                                                  doc.selectedDate = picked;
                                                  doc.policeDateController.text = "${picked.toLocal()}".split(' ')[0];
                                                });
                                              }
                                            }
                                                : null,
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
                                          child: isNew != "approved" ?  UploadButton(
                                            buttonText: doc.pickedFilePath == null ? "Upload" : "Uploaded",
                                            onPressed: () async {
                                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ['pdf', 'jpeg', 'png'],
                                              );

                                              if (result != null && result.files.isNotEmpty) {
                                                final path = result.files.single.path!;
                                                final file = File(path);
                                                final uploadedUrl = await profileSetupController.uploadIMG(image: file);

                                                if (uploadedUrl != null) {
                                                  setState(() {
                                                    doc.pickedFilePath = uploadedUrl;
                                                  });
                                                  print("📄 Uploaded URL: $uploadedUrl");
                                                }
                                              }
                                            }

                                          ):ViewButton(
                                            buttonText: "View",
                                            onPressed: () async {

                                              String? documentPath =doc.pickedFilePath;

                                              if (documentPath != null) {
                                                String fileExtension = documentPath.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();

                                                if (fileExtension == 'pdf') {
                                                  print("This is a PDF document.");
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => PdfViewScreen(
                                                        pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                      ),
                                                    ),
                                                  );

                                                } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
                                                  print("This is an image file.");
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: CustomNetworkImage(
                                                            boxShape: BoxShape.rectangle,
                                                            imageUrl:'${ApiConstants.imageBaseUrl}${documentPath}',
                                                            height: 200.h,
                                                            width: double.infinity
                                                        ),// Display the image from the URL
                                                      );
                                                    },
                                                  );
                                                  // Add your image viewer logic here (e.g., use Image widget)
                                                } else {
                                                  // Handle other file types or unsupported types
                                                  print("Unsupported file type.");
                                                }
                                              } else {
                                                print("Document path is null");
                                              }


                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        if (isNew != "approved" && isNew != "pending")
                                          IconButton(
                                            color: Colors.grey,
                                            icon: Icon(Icons.delete_forever, color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                profileSetupController.policeCheckLocalList.removeAt(index - (documentResponseModel?.policeCheck?.length ?? 0));
                                              });
                                            },
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.w),
                                      child: Row(
                                        children: [
                                          if (documentResponseModel?.policeCheck != null &&
                                              documentResponseModel!.policeCheck!.isNotEmpty &&
                                              index < documentResponseModel!.policeCheck!.length)
                                            SvgPicture.asset(
                                              documentResponseModel!.policeCheck![index].isVerifyed == "approved"
                                                  ? AppIcons.verifyIcon
                                                  : documentResponseModel!.policeCheck![index].isVerifyed == "pending"
                                                  ? AppIcons.pendingIcon
                                                  : AppIcons.warningIcon,
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          SizedBox(width: 8.w),
                                          if (documentResponseModel?.policeCheck != null &&
                                              documentResponseModel!.policeCheck!.isNotEmpty &&
                                              index < documentResponseModel!.policeCheck!.length)
                                            CustomText(
                                              text: documentResponseModel!.policeCheck![index].isVerifyed == "approved"
                                                  ? "Verified"
                                                  : documentResponseModel!.policeCheck![index].isVerifyed == "pending"
                                                  ? "Waiting for Verification"
                                                  : "Not Approved",
                                              color: documentResponseModel!.policeCheck![index].isVerifyed == "approved"
                                                  ? Color(0xff009A3F)
                                                  : documentResponseModel!.policeCheck![index].isVerifyed == "pending"
                                                  ? Color(0xffE9B000)
                                                  : Color(0xffF70004),
                                              fontsize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
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
                        ///
        
        
        
                        ///---------Qualification-----------------------
                        SizedBox(height: 20.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.r),
                            color: AppColors.whiteColor,
                          ),
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
                              ...mergedQualificationsList.asMap().entries.map((entry) {
                                final index = entry.key;
                                final doc = entry.value;
                                final isNew = doc.isFromServer;
        
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
                                            items: profileSetupController.qualificationDropdown.map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: CustomText(
                                                text: item,
                                                fontsize: 12.sp,
                                                color: AppColors.buttonPrimaryColor,
                                              ),
                                            )).toList(),
                                            onChanged: isNew != "approved"
                                                ? (value) {
                                              setState(() {
                                                doc.selectedDropdownData = value;
                                              });
                                            }
                                                : null,
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
                                            controller: doc.qualificationDateController,
                                            readOnly: true,
                                            onTap: isNew != "approved"
                                                ? () async {
                                              DateTime? picked = await showDatePicker(
                                                context: context,
                                                initialDate: doc.selectedDate ?? DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );
                                              if (picked != null) {
                                                setState(() {
                                                  doc.selectedDate = picked;
                                                  doc.qualificationDateController.text = "${picked.toLocal()}".split(' ')[0];
                                                });
                                              }
                                            }
                                                : null,
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
                                            buttonText: doc.pickedFilePath == null ? "Upload" : "Uploaded",
                                            onPressed: isNew != "approved"
                                                ? () async {
                                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ['pdf', 'jpeg', 'png'],
                                              );
        
                                              if (result != null && result.files.isNotEmpty) {
                                                final path = result.files.single.path!;
                                                final file = File(path);
                                                final uploadedUrl = await profileSetupController.uploadIMG(image: file);
        
                                                if (uploadedUrl != null) {
                                                  setState(() {
                                                    doc.pickedFilePath = uploadedUrl;
                                                  });
                                                  print("📄 Uploaded URL: $uploadedUrl");
                                                }
                                              }
                                            }
                                                : () {
                                              // View existing document logic
                                              if (doc.pickedFilePath != null) {
                                                // Implement view document logic here
                                                // Similar to your Police Check view logic
                                                String? documentPath = doc.pickedFilePath;
                                                String fileExtension = documentPath!.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
        
                                                if (fileExtension == 'pdf') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => PdfViewScreen(
                                                        pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                      ),
                                                    ),
                                                  );
                                                } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: CustomNetworkImage(
                                                          boxShape: BoxShape.rectangle,
                                                          imageUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                          height: 200.h,
                                                          width: double.infinity,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        if (isNew != "approved" && isNew != "pending")
                                          IconButton(
                                            color: Colors.grey,
                                            icon: Icon(Icons.delete_forever, color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                profileSetupController.qualificationLocalList.removeAt(index - (documentResponseModel?.qualification?.length ?? 0));
                                              });
                                            },
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 14.h),
        
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.w),
                                      child: Row(
                                        children: [
                                          if (documentResponseModel?.qualification != null &&
                                              documentResponseModel!.qualification!.isNotEmpty &&
                                              index < documentResponseModel!.qualification!.length)
                                            SvgPicture.asset(
                                              documentResponseModel!.qualification![index].isVerifyed == "approved"
                                                  ? AppIcons.verifyIcon
                                                  : documentResponseModel!.qualification![index].isVerifyed == "pending"
                                                  ? AppIcons.pendingIcon
                                                  : AppIcons.warningIcon,
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          SizedBox(width: 8.w),
                                          if (documentResponseModel?.qualification != null &&
                                              documentResponseModel!.qualification!.isNotEmpty &&
                                              index < documentResponseModel!.qualification!.length)
                                            CustomText(
                                              text: documentResponseModel!.qualification![index].isVerifyed == "approved"
                                                  ? "Verified"
                                                  : documentResponseModel!.qualification![index].isVerifyed == "pending"
                                                  ? "Waiting for Verification"
                                                  : "Not Approved",
                                              color: documentResponseModel!.qualification![index].isVerifyed == "approved"
                                                  ? Color(0xff009A3F)
                                                  : documentResponseModel!.qualification![index].isVerifyed == "pending"
                                                  ? Color(0xffE9B000)
                                                  : Color(0xffF70004),
                                              fontsize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
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
                            borderRadius: BorderRadius.circular(24.r),
                            color: AppColors.whiteColor,
                          ),
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
                              ...mergedFirstAIDDataList.asMap().entries.map((entry) {
                                final index = entry.key;
                                final doc = entry.value;
                                final isNew = doc.isFromServer;
        
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
                                            items: profileSetupController.aidCprDropdown.map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: CustomText(
                                                text: item,
                                                fontsize: 12.sp,
                                                color: AppColors.buttonPrimaryColor,
                                              ),
                                            )).toList(),
                                            onChanged: isNew != "approved"
                                                ? (value) {
                                              setState(() {
                                                doc.selectedDropdownData = value;
                                              });
                                            }
                                                : null,
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
                                            controller: doc.aidCPRDateController,
                                            readOnly: true,
                                            onTap: isNew != "approved"
                                                ? () async {
                                              DateTime? picked = await showDatePicker(
                                                context: context,
                                                initialDate: doc.selectedDate ?? DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );
                                              if (picked != null) {
                                                setState(() {
                                                  doc.selectedDate = picked;
                                                  doc.aidCPRDateController.text = "${picked.toLocal()}".split(' ')[0];
                                                });
                                              }
                                            }
                                                : null,
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
                                            buttonText: doc.pickedFilePath == null ? "Upload" : "Uploaded",
                                            onPressed: isNew != "approved"
                                                ? () async {
                                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ['pdf', 'jpeg', 'png'],
                                              );
        
                                              if (result != null && result.files.isNotEmpty) {
                                                final path = result.files.single.path!;
                                                final file = File(path);
                                                final uploadedUrl = await profileSetupController.uploadIMG(image: file);
        
                                                if (uploadedUrl != null) {
                                                  setState(() {
                                                    doc.pickedFilePath = uploadedUrl;
                                                  });
                                                  print("📄 Uploaded URL: $uploadedUrl");
                                                }
                                              }
                                            }
                                                : () {
                                              // View existing document logic
                                              if (doc.pickedFilePath != null) {
                                                String? documentPath = doc.pickedFilePath;
                                                String fileExtension = documentPath!.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
        
                                                if (fileExtension == 'pdf') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => PdfViewScreen(
                                                        pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                      ),
                                                    ),
                                                  );
                                                } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: CustomNetworkImage(
                                                          boxShape: BoxShape.rectangle,
                                                          imageUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                          height: 200.h,
                                                          width: double.infinity,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        if (isNew != "approved" && isNew != "pending")
                                          IconButton(
                                            color: Colors.grey,
                                            icon: Icon(Icons.delete_forever, color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                profileSetupController.aidCprLocalList.removeAt(index - (documentResponseModel?.firstAid?.length ?? 0));
                                              });
                                            },
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 14.h),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.w),
                                      child: Row(
                                        children: [
                                          if (documentResponseModel?.firstAid != null &&
                                              documentResponseModel!.firstAid!.isNotEmpty &&
                                              index < documentResponseModel!.firstAid!.length)
                                            SvgPicture.asset(
                                              documentResponseModel!.firstAid![index].isVerifyed == "approved"
                                                  ? AppIcons.verifyIcon
                                                  : documentResponseModel!.firstAid![index].isVerifyed == "pending"
                                                  ? AppIcons.pendingIcon
                                                  : AppIcons.warningIcon,
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          SizedBox(width: 8.w),
                                          if (documentResponseModel?.firstAid != null &&
                                              documentResponseModel!.firstAid!.isNotEmpty &&
                                              index < documentResponseModel!.firstAid!.length)
                                            CustomText(
                                              text: documentResponseModel!.firstAid![index].isVerifyed == "approved"
                                                  ? "Verified"
                                                  : documentResponseModel!.firstAid![index].isVerifyed == "pending"
                                                  ? "Waiting for Verification"
                                                  : "Not Approved",
                                              color: documentResponseModel!.firstAid![index].isVerifyed == "approved"
                                                  ? Color(0xff009A3F)
                                                  : documentResponseModel!.firstAid![index].isVerifyed == "pending"
                                                  ? Color(0xffE9B000)
                                                  : Color(0xffF70004),
                                              fontsize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
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
                                      documentResponseModel?.workingWithChildren?.document == null
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
                              Padding(
                                padding:  EdgeInsets.only(left: 50.w),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(documentResponseModel?.workingWithChildren?.isVerifyed == "approved" ? AppIcons.verifyIcon: documentResponseModel?.workingWithChildren?.isVerifyed == "pending"? AppIcons.pendingIcon: AppIcons.warningIcon,width: 20.w,height: 20.h,),
                                    SizedBox(width: 8.w),
                                    CustomText(text: documentResponseModel?.workingWithChildren?.isVerifyed == "approved" ?  "Verified" : documentResponseModel?.workingWithChildren?.isVerifyed == "pending"?  "Waiting for Verification": "Not Approved", color: documentResponseModel?.workingWithChildren?.isVerifyed == "approved"? Color(0xff009A3F):documentResponseModel?.workingWithChildren?.isVerifyed == "pending"? Color(0xffE9B000):Color(0xffF70004),fontsize: 12.sp, fontWeight: FontWeight.bold,)
                                  ],
                                ),
                              ),
                              SizedBox(height: 20.h),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h,),
        
        
                        ///---------Vaccination-----------------------
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.r),
                            color: AppColors.whiteColor,
                          ),
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
                              ...mergedVaccinationDataList.asMap().entries.map((entry) {
                                final index = entry.key;
                                final doc = entry.value;
                                final isNew = doc.isFromServer;
        
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
                                            items: profileSetupController.vaccinationDropdown.map((item) => DropdownMenuItem<String>(
                                              value: item,
                                              child: CustomText(
                                                text: item,
                                                fontsize: 12.sp,
                                                color: AppColors.buttonPrimaryColor,
                                              ),
                                            )).toList(),
                                            onChanged: isNew != "approved"
                                                ? (value) {
                                              setState(() {
                                                doc.selectedDropdownData = value;
                                              });
                                            }
                                                : null,
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
                                            controller: doc.vaccinDateController,
                                            readOnly: true,
                                            onTap: isNew != "approved"
                                                ? () async {
                                              DateTime? picked = await showDatePicker(
                                                context: context,
                                                initialDate: doc.selectedDate ?? DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );
                                              if (picked != null) {
                                                setState(() {
                                                  doc.selectedDate = picked;
                                                  doc.vaccinDateController.text = "${picked.toLocal()}".split(' ')[0];
                                                });
                                              }
                                            }
                                                : null,
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
                                            buttonText: doc.pickedFilePath == null ? "Upload" : "Uploaded",
                                            onPressed: isNew != "approved"
                                                ? () async {
                                              FilePickerResult? result = await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ['pdf', 'jpeg', 'png'],
                                              );
        
                                              if (result != null && result.files.isNotEmpty) {
                                                final path = result.files.single.path!;
                                                final file = File(path);
                                                final uploadedUrl = await profileSetupController.uploadIMG(image: file);
        
                                                if (uploadedUrl != null) {
                                                  setState(() {
                                                    doc.pickedFilePath = uploadedUrl;
                                                  });
                                                  print("📄 Uploaded URL: $uploadedUrl");
                                                }
                                              }
                                            }
                                                : () {
                                              // View existing document logic
                                              if (doc.pickedFilePath != null) {
                                                String? documentPath = doc.pickedFilePath;
                                                String fileExtension = documentPath!.substring(documentPath.lastIndexOf('.') + 1).toLowerCase();
        
                                                if (fileExtension == 'pdf') {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => PdfViewScreen(
                                                        pdfUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                      ),
                                                    ),
                                                  );
                                                } else if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return Dialog(
                                                        child: CustomNetworkImage(
                                                          boxShape: BoxShape.rectangle,
                                                          imageUrl: '${ApiConstants.imageBaseUrl}${documentPath}',
                                                          height: 200.h,
                                                          width: double.infinity,
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }
                                              }
                                            },
                                          ),
                                        ),
                                        SizedBox(width: 10.w),
                                        if (isNew != "approved" && isNew != "pending")
                                          IconButton(
                                            color: Colors.grey,
                                            icon: Icon(Icons.delete_forever, color: Colors.red),
                                            onPressed: () {
                                              setState(() {
                                                profileSetupController.vaccinationLocalList.removeAt(index - (documentResponseModel?.vaccination?.length ?? 0));
                                              });
                                            },
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 14.h),
                                    Padding(
                                      padding: EdgeInsets.only(left: 50.w),
                                      child: Row(
                                        children: [
                                          if (documentResponseModel?.vaccination != null &&
                                              documentResponseModel!.vaccination!.isNotEmpty &&
                                              index < documentResponseModel!.vaccination!.length)
                                            SvgPicture.asset(
                                              documentResponseModel!.vaccination![index].isVerifyed == "approved"
                                                  ? AppIcons.verifyIcon
                                                  : documentResponseModel!.vaccination![index].isVerifyed == "pending"
                                                  ? AppIcons.pendingIcon
                                                  : AppIcons.warningIcon,
                                              width: 20.w,
                                              height: 20.h,
                                            ),
                                          SizedBox(width: 8.w),
                                          if (documentResponseModel?.vaccination != null &&
                                              documentResponseModel!.vaccination!.isNotEmpty &&
                                              index < documentResponseModel!.vaccination!.length)
                                            CustomText(
                                              text: documentResponseModel!.vaccination![index].isVerifyed == "approved"
                                                  ? "Verified"
                                                  : documentResponseModel!.vaccination![index].isVerifyed == "pending"
                                                  ? "Waiting for Verification"
                                                  : "Not Approved",
                                              color: documentResponseModel!.vaccination![index].isVerifyed == "approved"
                                                  ? Color(0xff009A3F)
                                                  : documentResponseModel!.vaccination![index].isVerifyed == "pending"
                                                  ? Color(0xffE9B000)
                                                  : Color(0xffF70004),
                                              fontsize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                  ],
                                );
                              }).toList(),
                              Padding(
                                padding: EdgeInsets.only(left: 50.w, right: 10.w),
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
        
        
        
                        SizedBox(height: 20.h),
                        CustomButtonCommon(title: "Update",
                            onpress: (){
        
                              profileSetupController.uploadDocuments(
                                  passportExpiry: passportDateCNTRL.text,
                                  passportFilePath: profileSetupController.pickedPassportFilePath ?? documentResponseModel?.passport?.document,
        
                                  driveExpiry: driveController.text,
                                  driveFrontPath: profileSetupController.driveFontFilePath ?? documentResponseModel?.drivingLicense?.frontDocument,
                                  driveBackPath: profileSetupController.driveBackFilePath ?? documentResponseModel?.drivingLicense?.backDocument,
        
                                  policeChecks: mergedPoliceCheckList,
        
                                  carInsDropdown: profileSetupController.selectedCarInsDropdown ?? "",
                                  carInsExpiry: carController.text,
                                  carInsFilePath: profileSetupController.pickedCarFilePath ?? documentResponseModel?.carInsuranceCertificate?.certificate,
        
                                  qualificationLists: mergedQualificationsList,
        
                                  firstAidCPR: mergedFirstAIDDataList,
        
                                  workingWithChildrenExpiry: workChildDateController.text,
                                  workingWithChildrenFilePath: profileSetupController.pickedWorkChildFilePath ?? documentResponseModel?.workingWithChildren?.document,
        
                                  vaccinations: mergedVaccinationDataList,
        
                                  abnNumber: abnController.text,
                                  businessName: businessNameController.text,
        
                                  bsbNumber: BSBController.text,
                                  accountNumber: accountNoController.text
        
                              );
                              // Get.toNamed(AppRoutes.allBottomBarScreen,preventDuplicates: false);
                            }),
                        SizedBox(height: 20.h),
        
                      ],
                    )
                ),
              ),
            ),
          ),
      )
    );
  }
}
class ViewButton extends StatelessWidget {
  ViewButton({super.key, required this.buttonText, required this.onPressed,});
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
            // //   color: Colors.white,
            // // ),

            SizedBox(width: 10.w,),
            CustomText(text: buttonText,color: AppColors.whiteColor,fontsize: 12.sp,)
          ],),
      ),
    );
  }
}



