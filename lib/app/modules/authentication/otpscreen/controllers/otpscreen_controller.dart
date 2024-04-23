
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/constant/endpoint.dart';
import '../../../../data/model/user/response_login.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../data/provider/storage_provider.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/app_colors.dart';

class OtpscreenController extends GetxController {

  List<TextEditingController> controllers = List.generate(5, (index) => TextEditingController());
  FocusNode nextFocusNode = FocusNode();

  late String emailUser;
  late String textOTP;

  // Post OTP
  final loadinglogin = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // Get Kode Otp
  String getOtpFromTextFields() {
    String otp = '';
    for (TextEditingController controller in controllers) {
      otp += controller.text;
    }
    return otp;
  }


  @override
  void onInit() {
    super.onInit();
    for (var i = 0; i < controllers.length - 1; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          // Fokuskan ke controller berikutnya jika panjang karakter = 1
          FocusScope.of(Get.context!).requestFocus(nextFocusNode);
        }
      });

      emailUser = Get.parameters['emailUser'].toString();
      textOTP = "Masukan kode OTP yang telah di kirimkan ke email ";
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  verifikasiOTP() async {
    loadinglogin(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.verifyOTp,
            data: dio.FormData.fromMap(
                {
                  "email": Get.parameters['emailUser'].toString(),
                  "otp": getOtpFromTextFields(),
                }
            )
        );
        if (response.statusCode == 200) {
          ResponseLogin responseLogin = ResponseLogin.fromJson(response.data);
          await StorageProvider.write(StorageKey.status, "logged");
          await StorageProvider.write(StorageKey.username, responseLogin.data!.username.toString());
          await StorageProvider.write(StorageKey.tokenUser, responseLogin.data!.token.toString());
          await StorageProvider.write(StorageKey.idUser, responseLogin.data!.id.toString());
          await StorageProvider.write(StorageKey.email, responseLogin.data!.email.toString());

          String usernameUser = responseLogin.data!.username.toString();
          showAwesomeMaterialBanner(
            "Verifikasi Berhasil",
            "Proses verifikasi akun berhasil, selamat datang kembali $usernameUser",
            ContentType.success,
            AppColors.colorSuccess,
          );
          Get.offAllNamed(Routes.DASHBOARD);
        } else {
          showAwesomeMaterialBanner(
            "Sorry",
            "Verifikasi akun gagal, periksan koneksi internet anda",
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
