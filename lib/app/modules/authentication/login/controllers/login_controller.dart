import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:ruangpustaka/app/style/app_colors.dart';

import '../../../../data/constant/endpoint.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../routes/app_pages.dart';

class LoginController extends GetxController {

  // Inputan TextFormField
  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isPasswordHidden = true.obs;
  
  // Validasi Inputam TextFormField
  final isPasswordValid = true.obs;
  final isEmailValid = true.obs;
  final isEmailTrue = true.obs;
  String? messageValidateEmail;
  String? messageValidatePassword;
  String? messageCheckEmailUser;

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

  // Validasi Email
  String? validateEmail(){
    String? email = emailController.text.toString().trim();

    if (email.isEmpty) {
      messageValidateEmail = 'Pleasse input email address';
      isEmailValid.value = false;
    } else if (!email.endsWith('@smk.belajar.id')) {
      messageValidateEmail = 'Email harus @smk.belajar.id';
      isEmailValid.value = false;
    }else if (!EmailValidator.validate(email)) {
      messageValidateEmail = 'Email address tidak sesuai';
      isEmailValid.value = false;
    }
    else {
      // checkEmailUser();
      isEmailValid.value = true;
      messageValidateEmail = '';
    }

    return messageValidateEmail;
  }

  // Validasi Password
  String? validatePassword(){
    String? password = passwordController.text.toString();

    if (password.isEmpty) {
      messageValidatePassword =  'Please input password';
      isPasswordValid.value = false;
    }
    else if (password.length < 8){
      messageValidatePassword =  'Panjang password harus lebih dari 8';
      isPasswordValid.value = false;
    }
    // Validasi setidaknya satu huruf besar
    else if (!password.contains(RegExp(r'[A-Z]'))) {
      messageValidatePassword =  'Password harus mengandung satu huruf besar';
      isPasswordValid.value = false;
    }
    // Validasi setidaknya satu karakter khusus
    else if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      messageValidatePassword =  'Password harus mengandung satu karakter khusus';
      isPasswordValid.value = false;
    }
    // Validasi setidaknya satu angka
    else if (!password.contains(RegExp(r'[0-9]'))) {
      messageValidatePassword =  'Password harus mengandung minimal 1 angka';
      isPasswordValid.value = false;
    }
    else{
      isPasswordValid.value = true;
      messageValidatePassword = "";
    }

    return messageValidatePassword;
  }

  // Check Email User
  checkEmailUser() async {
    try {
        final response = await ApiProvider.instance().post(Endpoint.checkEmail,
            data: dio.FormData.fromMap(
                {
                  "email": emailController.text.toString(),
                }
            ));

        if (response.statusCode == 200) {
          return messageCheckEmailUser = 'Email address ditemukan';
        } else if(response.statusCode == 404) {
          return messageCheckEmailUser = 'Email address tidak ditemukan';
        }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        if (e.response?.data != null) {
          return messageCheckEmailUser = 'Email address tidak ditemukan';
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

  // Fungsi Login API
  loginPost() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.login,
            data: dio.FormData.fromMap(
                {
                  "email": emailController.text.toString(),
                  "password": passwordController.text.toString()
                }
            )
        );
        if (response.statusCode == 200) {
          String emailUser = emailController.text.toString();
          Get.offAllNamed(
              Routes.OTPSCREEN,
            parameters: {
              'emailUser': emailUser,
            },
          );
        } else {
          showAwesomeMaterialBanner(
            "Sorry",
            "Sign In gagal, periksan koneksi internet anda",
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
      final String deskripsiText, final ContentType contentType, final Color backgroundColor) {
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
