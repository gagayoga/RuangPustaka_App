import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../components/custom_button.dart';
import '../../style/app_colors.dart';
import '../../style/app_sizes.dart';
import '../../style/app_textsizes.dart';

class BuildWidgetOTP extends StatelessWidget {
  final dynamic controller;
  const BuildWidgetOTP({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    // Size
    AppSizes sizes = AppSizes(context);

    return SingleChildScrollView(
      child: Container(
        width: sizes.sizeWidth,
        height: sizes.sizeHeight,
        color: AppColors.backgroundWhite,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: sizes.sizeWidth * 0.05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: sizes.sizeHeight * 0.050,
              ),

              SizedBox(
                width: sizes.sizeWidth,
                height: sizes.sizeHeight * 0.45,
                child: Image.asset(
                  'assets/gif/animation_otp.gif',
                  fit: BoxFit.fitHeight,
                ),
              ),

              SizedBox(
                height: sizes.sizeHeight * 0.015,
              ),

              FittedBox(
                child: Text(
                  'OTP Verification',
                  style: GoogleFonts.montserrat(
                    fontSize: AppTextSizes.subheadline,
                    color: AppColors.primaryColor,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
              ),

              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: controller.textOTP,
                      style: GoogleFonts.montserrat(
                        fontSize: AppTextSizes.body,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.5,
                      ),
                    ),
                    TextSpan(
                      text: controller.emailUser,
                      style: GoogleFonts.montserrat(
                        fontSize: AppTextSizes.body,
                        color: AppColors.primaryColor, // Ubah warna menjadi biru sesuai kebutuhan
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.5,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: sizes.sizeHeight * 0.035,
              ),

              Form(
                key: controller.formKey,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(5, (index) => Expanded(
                      child: SizedBox(
                        height: 68,
                        child: Padding(
                          padding: EdgeInsets.only(right: index < 4 ? 8 : 8),
                          child: TextFormField(
                            controller: controller.controllers[index],
                            keyboardType: TextInputType.number,
                            style: GoogleFonts.montserrat(
                                fontSize: AppTextSizes.headline,
                                fontWeight: FontWeight.w700
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            onChanged: (value){
                              // Jika nilai input kosong, fokus akan beralih ke input sebelumnya
                              if (value.isEmpty) {
                                if (index > 0) {
                                  FocusScope.of(context).previousFocus();
                                }
                              } else if (value.length == 1) {
                                // Jika nilai input memiliki panjang 1, fokus akan beralih ke input berikutnya
                                FocusScope.of(context).nextFocus();
                              }
                            },
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(1),
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              hintText: "0",
                              hintStyle: GoogleFonts.montserrat(
                                  fontSize: AppTextSizes.headline,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.greyColor.withOpacity(0.30)
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              enabledBorder:  OutlineInputBorder(
                                borderSide: const BorderSide(color: AppColors.greyColor, width: 0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder:  OutlineInputBorder(
                                borderSide: const BorderSide(color: AppColors.primaryColor, width: 0.8),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                            ),
                          ),
                        ),
                      ),
                    ))
                ),
              ),

              SizedBox(
                height: sizes.sizeHeight * 0.030,
              ),

              CustomButton(
                onPressed: (){
                  controller.verifikasiOTP();
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
                ),
              ),

              SizedBox(
                height: sizes.sizeHeight * 0.035,
              ),

              sectionResendOTP(),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionResendOTP(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [

        FittedBox(
          child: Text(
            "Belum dapat kode OTP?",
            maxLines: 1,
            style: GoogleFonts.montserrat(
              fontSize: AppTextSizes.caption,
              color: AppColors.greyColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        const SizedBox(
          width: 5,
        ),

        InkWell(
          onTap: (){

          },
          child: Text(
            "Send OTP",
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
}
