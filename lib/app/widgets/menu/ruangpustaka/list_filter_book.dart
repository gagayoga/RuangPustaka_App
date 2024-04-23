import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../style/app_colors.dart';

class ItemFilterBook extends StatelessWidget {
  final VoidCallback onTap;
  final String namaFilter;

  const ItemFilterBook({
    super.key,
    required this.onTap,
    required this.namaFilter,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      child: TextButton(
          onPressed: onTap,
          style: TextButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            backgroundColor: const Color(0XFFF5F5F5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Text(
              namaFilter,
              style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: AppColors.blackColor,
              ),
            ),
          )
      ),
    );
  }
}
