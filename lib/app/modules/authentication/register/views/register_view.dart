import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../style/app_colors.dart';
import '../../../../style/app_themesystemoverlay.dart';
import '../../../../widgets/authentication/widget_register.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);
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
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          reverse: true,
          primary: false,
          child: BuildWidgetRegister(controller: controller,),
        )
    );
  }


}
