import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';
import 'package:ruangpustaka/app/style/app_textsizes.dart';
import 'package:ruangpustaka/app/style/app_themesystemoverlay.dart';

import '../../../../widgets/authentication/widget_forgetpassword.dart';
import '../controllers/forgetpassword_controller.dart';

class ForgetpasswordView extends GetView<ForgetpasswordController> {
  const ForgetpasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Tema
    Brightness currentBrightness = MediaQuery.of(context).platformBrightness;
    if(currentBrightness == Brightness.dark){
      SystemOverlayStyleUtils.setDarkStatusBar(AppColors.backgroundWhite);
    }else if (currentBrightness == Brightness.light){
      SystemOverlayStyleUtils.setLightStatusBar(AppColors.backgroundWhite);
    }

    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        title: Text(
          'Forget Password',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            color: AppColors.primaryColor,
            fontSize: AppTextSizes.body,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
      ),
      body: BuildWidgetForgetPassword(controller: controller,)
    );
  }
}
