import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ndolo_dating/helpers/route.dart';
import 'package:ndolo_dating/utils/app_strings.dart';
import 'package:ndolo_dating/views/base/custom_app_bar.dart';
import 'package:ndolo_dating/views/base/custom_button.dart';
import 'package:ndolo_dating/views/base/custom_list_tile.dart';
import 'package:ndolo_dating/views/base/custom_text.dart';

class AccountInformationScreen extends StatelessWidget {
  const AccountInformationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.accountInformation.tr),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //======================> First Name List Tile <========================
              CustomText(
                text: AppStrings.firstName.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: 'Janet'),
              SizedBox(height: 16.h),
              //======================> Last Name List Tile <========================
              CustomText(
                text: AppStrings.lastName.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: 'Janet'),
              SizedBox(height: 16.h),
              //======================> Email List Tile <========================
              CustomText(
                text: AppStrings.email.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: 'abc@gmail.com'),
              SizedBox(height: 16.h),
              //======================> Phone Number List Tile <========================
              CustomText(
                text: AppStrings.phoneNumber.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: '+880158669575'),
              SizedBox(height: 16.h),
              //======================> Country List Tile <========================
              CustomText(
                text: AppStrings.country.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: 'Bangladesh'),
              SizedBox(height: 16.h),
              //======================> State List Tile <========================
              CustomText(
                text: AppStrings.state.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: 'BD'),
              SizedBox(height: 16.h),
              //======================> City List Tile <========================
              CustomText(
                text: AppStrings.city.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: 'Dhaka'),
              SizedBox(height: 16.h),
              //======================> address List Tile <========================
              CustomText(
                text: AppStrings.address.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(title: '6391 Elgin St. Celina, Delaware 10299'),
              SizedBox(height: 16.h),
              //======================> Bio List Tile <========================
              CustomText(
                text: AppStrings.bio.tr,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                bottom: 8.h,
              ),
              CustomListTile(
                  title:
                      'Hello there! I\'m Rida, seeking a lifelong adventure partner. A blend of tradition and modernity, I find joy in the simple moments and cherish family values. With a heart that believes in love\'s magic, I\'m looking for someone to share happiness.'),
              SizedBox(height: 32.h),
              //======================> Edit Button <========================
              CustomButton(
                  onTap: () {
                    Get.toNamed(AppRoutes.editAccountInformation);
                  },
                  text: AppStrings.edit.tr),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}
