import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';
import 'package:ruangpustaka/app/style/app_textsizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintLabel;
  final String labelText;
  final double gapHeight;
  final bool obsureText;
  final Widget? suffixIcon;
  final void Function(String) onChanged;
  final String? errorText;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintLabel,
    required this.labelText,
    required this.gapHeight,
    required this.obsureText,
    this.suffixIcon,
    required this.onChanged,
    required this.errorText,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          labelText,
          textAlign: TextAlign.start,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w600,
            color: AppColors.greyColor,
            fontSize: AppTextSizes.caption,
            letterSpacing: -0.3,
          ),
        ),

        SizedBox(
          height: gapHeight,
        ),

        TextFormField(
          controller: controller,
          onChanged: onChanged,
          obscureText: obsureText,
          style: GoogleFonts.montserrat(
              fontSize: AppTextSizes.body,
              fontWeight: FontWeight.w600,
              color: AppColors.blackColor
          ),
          decoration: InputDecoration(
            errorText: errorText,
            errorStyle: GoogleFonts.montserrat(
                fontSize: AppTextSizes.small,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryColor
            ),
            hintText: hintLabel,
            hintStyle: GoogleFonts.montserrat(
                fontSize: AppTextSizes.body,
                fontWeight: FontWeight.w600,
                color: AppColors.greyColor
            ),
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder:  OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.3),
              borderRadius: BorderRadius.circular(10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.secondaryColor, width: 1),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedBorder:  OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.3),
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
