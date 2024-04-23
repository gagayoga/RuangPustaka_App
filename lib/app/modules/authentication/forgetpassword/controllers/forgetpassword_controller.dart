
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart' as dio ;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/constant/endpoint.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/app_colors.dart';

class ForgetpasswordController extends GetxController {

  // Post OTP
  // Inputan TextFormField
  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  String? messageCheckEmailUser;
  late final isEmailTrue = true.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Fungsi check Email
  checkEmailUser() async {
    try {
      final response = await ApiProvider.instance().post(Endpoint.checkEmail,
          data: dio.FormData.fromMap(
              {
                "email": emailController.text.toString(),
              }
          ));

      if (response.statusCode == 200) {
        isEmailTrue.value = false;
        messageCheckEmailUser = 'Email address ditemukan';
        isEmailTrue.value = true;
      } else if(response.statusCode == 404) {
        isEmailTrue.value = false;
        messageCheckEmailUser = 'Email address tidak ditemukan';
        isEmailTrue.value = true;
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          isEmailTrue.value = false;
          messageCheckEmailUser = 'Email address tidak ditemukan';
        }
      } else {
        showAwesomeMaterialBanner(
          "Sorry",
          e.message ?? "",
          ContentType.failure,
          AppColors.secondaryColor,
        );
      }
    } catch (e) {
      showAwesomeMaterialBanner(
        "Sorry",
        e.toString(),
        ContentType.failure,
        AppColors.secondaryColor,
      );
    }
  }

  // Fungsi Reset Password
  resetPassword() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.resetPassword,
            data: dio.FormData.fromMap(
                {
                   "Email": emailController.text.toString().trim(),
                }
            )
        );
        if (response.statusCode == 201) {
          String emailUser = emailController.text.toString().trim();
          showAwesomeMaterialBanner(
            "Reset Password Berhasil",
            "Password Anda sudah berhasil dikirimkan melalui email Anda $emailUser",
            ContentType.success,
            AppColors.colorSuccess,
          );
          Get.offAllNamed(Routes.LOGIN);
        } else {
          showAwesomeMaterialBanner(
            "Sorry",
            "Reset password Anda sudah gagal, periksan koneksi internet anda",
            ContentType.failure,
            AppColors.secondaryColor,
          );
        }
      }
      loadinglogin(false);
    } on dio.DioException catch (e) {
      loadinglogin(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          showAwesomeMaterialBanner(
              "Pemberitahuan",
              "${e.response?.data['message']}",
              ContentType.warning,
              AppColors.colorWarning
          );
        }
      } else {
        showAwesomeMaterialBanner(
          "Sorry",
          e.message ?? "",
          ContentType.failure,
          AppColors.secondaryColor,
        );
      }
    } catch (e) {
      loadinglogin(false);
      showAwesomeMaterialBanner(
        "Sorry",
        e.toString(),
        ContentType.failure,
        AppColors.secondaryColor,
      );
    }
  }

  // Fungsi untuk snackbar
  void showAwesomeMaterialBanner(final String judulText,
      final String deskripsiText,
      final ContentType contentType,
      final Color backgroundColor) {
    final snackBar = SnackBar(
      backgroundColor: Colors.transparent,
      elevation: 0.0,
      duration: const Duration(milliseconds: 3000),
      dismissDirection: DismissDirection.down,
      padding: const EdgeInsets.symmetric(vertical: 20),
      behavior: SnackBarBehavior.floating,
      content: AwesomeSnackbarContent(
        color: backgroundColor,
        title: judulText,
        inMaterialBanner: true,
        message: deskripsiText,
        contentType: contentType,
      ),
    );

    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
