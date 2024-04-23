import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/custom_button.dart';
import '../../components/custom_textfield.dart';
import '../../routes/app_pages.dart';
import '../../style/app_colors.dart';
import '../../style/app_sizes.dart';
import '../../style/app_textsizes.dart';

class BuildWidgetLogin extends StatelessWidget {
  final dynamic controller;

  const BuildWidgetLogin({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    // Size
    AppSizes sizes = AppSizes(context);

    // Size Height Device
    bool heightDeviceSmall = sizes.sizeHeight < 740;
    bool heightDeviceLarge = sizes.sizeHeight > 740;

    return Container(
      width: sizes.sizeWidth,
      height: sizes.sizeHeight,
      color: AppColors.backgroundWhite,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: sizes.sizeWidth * 0.05),
        child: Column(
          mainAxisAlignment: heightDeviceSmall
              ? MainAxisAlignment.center
              : MainAxisAlignment.start,
          children: [

            if (heightDeviceLarge)
              SizedBox(
                height: sizes.sizeWidth * 0.25,
              ),

            FittedBox(
              child: Text(
                "Sign In",
                maxLines: 1,
                style: GoogleFonts.montserrat(
                  fontSize: AppTextSizes.headingLarge2,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
            ),

            SizedBox(
              height: sizes.sizeHeight * 0.010,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.sizeWidth * 0.10),
              child: Text(
                "Silakan masuk ke akun Anda untuk menikmati akses penuh ke koleksi digital kami.",
                maxLines: 2,
                textAlign: TextAlign.center,
                style: GoogleFonts.montserrat(
                    fontSize: AppTextSizes.body,
                    color: AppColors.greyColor,
                    fontWeight: FontWeight.w500,
                    letterSpacing: -0.5
                ),
              ),
            ),

            SizedBox(
              height: sizes.sizeHeight * 0.050,
            ),

            Form(
              key: controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Obx(() => CustomTextField(
                    controller: controller.emailController,
                    hintLabel: "ruangpustaka@smk.belajar.id",
                    labelText: "Email Address",
                    gapHeight: sizes.sizeHeight * 0.015,
                    obsureText: false,
                    onChanged: (_) => controller.validateEmail(),
                    validator: (value){
                      if (value!.isEmpty){
                        return 'Please input email address';
                      }
                      return null;
                    },
                    errorText: controller.isEmailValid.value
                        ? null : controller.messageValidateEmail,
                  ),
                  ),

                  SizedBox(
                    height: sizes.sizeHeight * 0.015,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [

                      Obx(() =>
                          CustomTextField(
                            controller: controller.passwordController,
                            hintLabel: "Password",
                            labelText: "Password",
                            gapHeight: sizes.sizeHeight * 0.015,
                            obsureText: controller.isPasswordHidden.value,
                            suffixIcon:  InkWell(
                              child: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                size: 20,
                                color: AppColors.primaryColor,
                              ),
                              onTap: () {
                                controller.isPasswordHidden.value =
                                !controller.isPasswordHidden.value;
                              },
                            ),
                            onChanged: (_)=> controller.validatePassword(),
                            errorText: controller.isPasswordValid.value
                                ? null
                                : controller.messageValidatePassword,
                            validator: (value){
                              if (value!.isEmpty){
                                return 'Please input password';
                              }
                              return null;
                            },
                          ),
                      ),

                      TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.backgroundWhite,

                          ),
                          onPressed: ()=> Get.toNamed(Routes.FORGETPASSWORD),
                          child: Text(
                            "Forget Password?",
                            style: GoogleFonts.montserrat(
                              fontSize: AppTextSizes.caption,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                      )
                    ],
                  ),

                  SizedBox(
                    height: sizes.sizeHeight * 0.030,
                  ),

                  CustomButton(
                    onPressed: (){
                      if (controller.formKey.currentState!.validate()) {
                        controller.loginPost();
                      }
                    },
                    childWidget: Obx(() => controller.loadinglogin.value?
                    const CircularProgressIndicator(
                      color: AppColors.whiteColor,
                    ):  Text(
                      "Sign In",
                      style: GoogleFonts.montserrat(
                        fontSize: AppTextSizes.textButton,
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    ),
                  ),

                  SizedBox(
                    height: sizes.sizeHeight * 0.035,
                  ),

                  sectionToSignUp(context),

                  SizedBox(
                    height: sizes.sizeHeight * 0.035,
                  ),

                  sectionDivider(),

                  SizedBox(
                    height: sizes.sizeHeight * 0.040,
                  ),

                  sectionButtonGoogle(context)
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget sectionToSignUp(BuildContext context){
    // Size
    AppSizes sizes = AppSizes(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        FittedBox(
          child: Text(
            "Don't have an account?",
            maxLines: 1,
            style: GoogleFonts.montserrat(
              fontSize: AppTextSizes.caption,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        SizedBox(
          width: sizes.sizeWidth * 0.010,
        ),

        InkWell(
          onTap: ()=> Get.offAllNamed(Routes.REGISTER),
          child: Text(
            "Sign Up",
            style: GoogleFonts.montserrat(
              fontSize: AppTextSizes.body,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        )
      ],
    );
  }

  Widget sectionDivider() {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Divider(
              color: AppColors.greyColor.withOpacity(0.10),
              thickness: 1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'Or',
              style: TextStyle(
                color: AppColors.greyColor.withOpacity(0.50),
              ),
            ),
          ),
          Expanded(
            child: Divider(
              color: AppColors.greyColor.withOpacity(0.10),
              thickness: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionButtonGoogle(BuildContext context){
    // Size
    AppSizes sizes = AppSizes(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          flex: 1,
          child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                  onPressed: (){

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.whiteColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.10),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/logo/classroom.svg',
                    fit: BoxFit.cover,
                  ),
                  label: Text(
                    "Classroom",
                    style: GoogleFonts.montserrat(
                      fontSize: AppTextSizes.body,
                      color: AppColors.greyColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
              )
          ),
        ),

        SizedBox(
          width: sizes.sizeWidth * 0.010,
        ),

        Expanded(
          flex: 1,
          child: SizedBox(
              height: 50,
              child: ElevatedButton.icon(
                  onPressed: (){

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.10),
                    ),
                  ),
                  icon: SvgPicture.asset(
                    'assets/logo/google.svg',
                    fit: BoxFit.cover,
                  ),
                  label: Text(
                    "Google",
                    style: GoogleFonts.montserrat(
                      fontSize: AppTextSizes.body,
                      color: AppColors.whiteColor,
                      fontWeight: FontWeight.w600,
                    ),
                  )
              )
          ),
        )
      ],
    );
  }
}
