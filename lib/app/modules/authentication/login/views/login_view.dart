import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';

import '../../../../style/app_themesystemoverlay.dart';
import '../../../../widgets/authentication/widget_login.dart';
import '../controllers/login_controller.dart';


class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        primary: false,
        child: BuildWidgetLogin(controller: controller),
      )
    );
  }
}
