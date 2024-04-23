import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/custom_button.dart';
import '../../style/app_colors.dart';
import '../../style/app_sizes.dart';
import '../../style/app_textsizes.dart';

class BuildWidgetForgetPassword extends StatelessWidget {
  final dynamic controller;

  const BuildWidgetForgetPassword({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Size
    AppSizes sizes = AppSizes(context);
    
    return Container(
      width: sizes.sizeWidth,
      height: sizes.sizeHeight,
      color: AppColors.backgroundWhite,
      child: Column(
        children: [

          SizedBox(
            height: sizes.sizeHeight * 0.010,
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: sizes.sizeWidth * 0.05),
            child: Text(
              'Masukan alamat email akun Anda untuk mendapatkan password terbaru dari akun Anda.',
              maxLines: 3,
              style: GoogleFonts.montserrat(
                fontSize: AppTextSizes.body,
                color: AppColors.greyColor,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.5,
              ),
            ),
          ),

          SizedBox(
            height: sizes.sizeHeight * 0.020,
          ),

          Form(
            key: controller.formKey,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.sizeWidth * 0.05),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Email Address",
                    textAlign: TextAlign.start,
                    style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyColor,
                      fontSize: AppTextSizes.caption,
                      letterSpacing: -0.3,
                    ),
                  ),

                  SizedBox(
                    height: sizes.sizeHeight * 0.015,
                  ),

                  Obx(() =>
                      TextFormField(
                        onChanged: (_)=> controller.checkEmailUser(),
                        controller: controller.emailController,
                        style: GoogleFonts.montserrat(
                            fontSize: AppTextSizes.body,
                            fontWeight: FontWeight.w600,
                            color: AppColors.blackColor
                        ),
                        decoration: InputDecoration(
                          hintText: "ruangpustaka@smk.belajar.id",
                          hintStyle: GoogleFonts.montserrat(
                              fontSize: AppTextSizes.body,
                              fontWeight: FontWeight.w600,
                              color: AppColors.greyColor
                          ),
                          errorText: controller.isEmailTrue.value
                              ? null
                              : controller.messageCheckEmailUser,
                          errorStyle: GoogleFonts.montserrat(
                              fontSize: AppTextSizes.small,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryColor
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.secondaryColor, width: 1.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder:  OutlineInputBorder(
                            borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.3),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                        ),
                        validator: (value){
                          if (value!.isEmpty){
                            return 'Please input email address';
                          }
                          return null;
                        },
                      ),
                  ),

                  SizedBox(
                    height: sizes.sizeHeight * 0.040,
                  ),

                  CustomButton(
                    onPressed: (){
                      controller.resetPassword();
                    },
                    childWidget: Obx(() => controller.loadinglogin.value?
                    const CircularProgressIndicator(
                      color: AppColors.whiteColor,
                    ): Text(
                      "Submit",
                      style: GoogleFonts.montserrat(
                        fontSize: AppTextSizes.textButton,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ),),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
