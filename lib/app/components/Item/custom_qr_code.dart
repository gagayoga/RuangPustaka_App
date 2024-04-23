import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';

class CustomQrCode extends StatelessWidget {
  final String code;

  const CustomQrCode({Key? key, required this.code}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QrImageView(
        data: code,
        version: QrVersions.auto,
        eyeStyle: const QrEyeStyle(color: AppColors.primaryColor),
        size: 200.0,
        gapless: false,
      ),
    );
  }
}
