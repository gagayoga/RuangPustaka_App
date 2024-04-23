import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/constant/endpoint.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/app_colors.dart';

class RegisterController extends GetxController {

  final loadingregister = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  var isPasswordHidden = true.obs;

  // Validasi Inputam TextFormField
  final isPasswordValid = true.obs;
  final isEmailValid = true.obs;
  final isUsernameValid = true.obs;
  String? messageValidateUsername;
  String? messageValidateEmail;
  String? messageValidatePassword;

  // CheckBox
  var isChecked = false.obs;

  void toggleCheckBox() {
    isChecked.value = !isChecked.value;
  }


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

  // Validasi Username
  String? validateUsername(){
    String? username = usernameController.text.toString();

    if (username.isEmpty) {
      messageValidateUsername = 'Pleasse input username';
      isUsernameValid.value = false;
    }else {
      isUsernameValid.value = true;
      messageValidateUsername = "";
    }

    return messageValidateUsername;
  }

  // Validasi Email
  String? validateEmail(){
    String? email = emailController.text.toString();

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
      isEmailValid.value = true;
      messageValidateEmail = "";
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
    }else if (password.length < 8){
      messageValidatePassword =  'Panjang password harus lebih dari 8';
      isPasswordValid.value = false;
    }
    else{
      isPasswordValid.value = true;
      messageValidatePassword = "";
    }

    return messageValidatePassword;
  }

  // Validasi CheckBox
  void showCheckBoxError() {
    showAwesomeMaterialBanner(
        "Pemberitahuan",
        "Anda harus mensetujui ketentuan dan privasi aplikasi ruang pustaka. Click checkbox terlebih dahulu sebelum sign up. Terima kasih",
        ContentType.help,
        AppColors.primaryColor
    );
  }

  // Fungsi Register API
  registerPost() async {

    loadingregister(true);

    try {

      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.register,
            data: {
              "username": usernameController.text.toString(),
              "email": emailController.text.toString(),
              "password": passwordController.text.toString()
            });

        if (response.statusCode == 201) {
          String username =  usernameController.text.toString();
          showAwesomeMaterialBanner(
            "Sign Up Success",
            "Sign Up berhasil, Hallo $username, silakan Sign In terlebih dahulu",
            ContentType.success,
            AppColors.colorSuccess,
          );
          Get.offAllNamed(Routes.LOGIN);
        } else {
          showAwesomeMaterialBanner(
            "Sorry",
            "Sign Up gagal, periksan koneksi internet anda",
            ContentType.failure,
            AppColors.secondaryColor,
          );
        }
      }
      loadingregister(false);
    } on DioException catch (e) {
      loadingregister(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          showAwesomeMaterialBanner(
              "Pemberitahuan",
              "${e.response?.data['Message']}",
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
      loadingregister(false);
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
