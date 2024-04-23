import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../style/app_colors.dart';
import '../../style/app_textsizes.dart';

class CustomSectionDataKosong extends StatelessWidget {
  final double width;
  final String messageError;

  const CustomSectionDataKosong({
    super.key,
    required this.width,
    required this.messageError,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: 400,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),
          child: Column(
            children: [
              const SizedBox(
                height: 5,
              ),

              SizedBox(
                width: 250,
                height: 250,
                child: SvgPicture.asset(
                  'assets/logo/empty.svg',
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(
                height: 10,
              ),

              Text(
                messageError,
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryColor,
                  letterSpacing: -0.3,
                  fontSize: AppTextSizes.body,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
