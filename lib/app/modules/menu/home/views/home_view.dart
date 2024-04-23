import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ruangpustaka/app/data/provider/storage_provider.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';
import 'package:ruangpustaka/app/style/app_textsizes.dart';
import 'package:ruangpustaka/app/widgets/menu/home/widget_home.dart';

import '../../../../style/app_themesystemoverlay.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
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
        backgroundColor: AppColors.backgroundWhite,
        title: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  SizedBox(
                    width: 45,
                    height: 45,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'assets/home/profile.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(
                    width: 5,
                  ),

                  Obx((){
                    final currentIndex = controller.currentIndex.value;
                    String usernameUser = StorageProvider.read(StorageKey.username);
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hallo $usernameUser',
                          style: GoogleFonts.montserrat(
                            fontSize: AppTextSizes.subheadline,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w700,
                            letterSpacing: -0.3,
                          ),
                        ),

                        const SizedBox(
                          height: 3,
                        ),

                        Text(
                          controller.textList[currentIndex],
                          style: GoogleFonts.montserrat(
                            fontSize: AppTextSizes.small,
                            color: AppColors.greyColor,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.3,),
                        )
                      ],
                    );
                  })
                ],
              ),
            ),
          ],
        ),
        actions: const [
          SizedBox(
            width: 45,
            height: 45,
            child: Icon(
              Iconsax.notification_bing5,
              size: 30,
              color: AppColors.blackColor,
            ),
          )
        ],
        centerTitle: true,
      ),

      body: BuildWidgetHome(controller: controller),
    );
  }
}
