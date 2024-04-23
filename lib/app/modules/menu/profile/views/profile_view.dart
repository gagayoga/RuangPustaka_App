import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ruangpustaka/app/data/provider/storage_provider.dart';
import 'package:ruangpustaka/app/style/app_sizes.dart';

import '../../../../style/app_colors.dart';
import '../../../../style/app_textsizes.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    AppSizes sizes = AppSizes(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundOnboarding.withOpacity(0.30),
        titleSpacing: 13,
        title: Text(
          'Profile Pengguna',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: AppColors.blackColor,
            fontSize: AppTextSizes.textButton,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: (){
              },
              child: const Icon(
                Iconsax.refresh5,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
      ),
      body: Container(
        width: sizes.sizeWidth,
        height: sizes.sizeHeight,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Row(
                  children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/home/profile.png',
                      width: 65,
                      height: 65,
                    ),
                  ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StorageProvider.read(StorageKey.username).toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: AppTextSizes.body,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor
                              ),
                            ),

                            Text(
                              StorageProvider.read(StorageKey.email).toString(),
                              style: GoogleFonts.montserrat(
                                  fontSize: AppTextSizes.body,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.blackColor
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                ],
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  Widget sectionButtonProfile(double width, double height, IconData iconDepan, String text){
    return Container(
      width: width,
      height: 50,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Icon(iconDepan),
            Text(),
            Icon(),
          ],
        ),
      ),
    );
  }
}
