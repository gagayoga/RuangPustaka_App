import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruangpustaka/app/data/model/peminjaman/response_history_peminjaman.dart';

import '../../../../components/content/customTextField.dart';
import '../../../../components/content/custom_toast.dart';
import '../../../../data/constant/endpoint.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../data/provider/storage_provider.dart';
import '../../../../style/app_colors.dart';

class HistorypeminjamanController extends GetxController with StateMixin{
  var historyPeminjaman = RxList<DataHistoryPeminjaman>();
  String idUser = StorageProvider.read(StorageKey.idUser);

  var isLoading = RxBool(true);

  double ratingBuku= 0;
  final loadingUlasan = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController ulasanController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    getDataPeminjaman("Dipinjam");
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataPeminjaman(String statusPeminjaman) async {
    isLoading.value == true;
    change(null, status: RxStatus.loading());

    try {
      final responseHistoryPeminjaman = await ApiProvider.instance().get(
          '${Endpoint.pinjamBuku}/$idUser/$statusPeminjaman');

      if (responseHistoryPeminjaman.statusCode == 200) {
        final ResponseHistoryPeminjaman responseHistory = ResponseHistoryPeminjaman.fromJson(responseHistoryPeminjaman.data);

        if (responseHistory.data!.isEmpty) {
          historyPeminjaman.clear();
          change(null, status: RxStatus.empty());
        } else {
          historyPeminjaman.assignAll(responseHistory.data!);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['Message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }finally{
      isLoading.value = false;
    }
  }

  // View Post Ulasan Buku
  Future<void> kontenBeriUlasan(String idBuku, String namaBuku) async{
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundWhite,
          title: Text(
            'Berikan Ulasan Buku',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w800,
              fontSize: 20.0,
              color: AppColors.whiteColor,
            ),
          ),

          content: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Form(
                key: formKey,
                child: ListBody(
                  children: <Widget>[

                    Text(
                      'Rating Buku',
                      style: GoogleFonts.montserrat(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    RatingBar.builder(
                      allowHalfRating: false,
                      itemCount: 5,
                      minRating: 1,
                      initialRating: 5,
                      direction: Axis.horizontal,
                      itemSize: 50,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (double value) {
                        ratingBuku = value;
                      },
                    ),

                    const SizedBox(
                      height: 15,
                    ),

                    Text(
                      'Ulasan Buku',
                      style: GoogleFonts.montserrat(
                          fontSize: 12.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.black),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    CustomTextField(
                      controller: ulasanController,
                      hinText: 'Ulasan Buku',
                      obsureText: false,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Pleasse input ulasan buku';
                        }

                        return null;
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: <Widget>[
            SizedBox(
              width: MediaQuery.of(Get.context!).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  width: MediaQuery.of(Get.context!).size.width,
                  height: 50,
                  child: TextButton(
                    autofocus: true,
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      animationDuration: const Duration(milliseconds: 300),
                    ),
                    onPressed: (){
                      postUlasanBuku(idBuku, namaBuku);
                      Navigator.of(Get.context!).pop();
                    },
                    child: Text(
                      'Simpan Ulasan Buku',
                      style: GoogleFonts.montserrat(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  postUlasanBuku(String buku, String namaBuku) async {
    loadingUlasan(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      formKey.currentState?.save();
      if (formKey.currentState!.validate()) {
        int ratingBukuInt = ratingBuku.round();
        final response = await ApiProvider.instance().post(Endpoint.ulasanBuku,
            data: dio.FormData.fromMap(
                {
                  "Rating": ratingBukuInt,
                  "BukuID": buku,
                  "Ulasan": ulasanController.text.toString()
                }
            )
        );
        if (response.statusCode == 201) {
          CustomToast.ShowToast("Ulasan Buku $namaBuku berhasil di simpan", AppColors.whiteColor, AppColors.primaryColor);
          Navigator.of(Get.context!).pop();
          ulasanController.text = '';

        } else {
          
        }
      }
      loadingUlasan(false);
    } on dio.DioException catch (e) {
      loadingUlasan(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          
        }
      } else {
        
      }
    } catch (e) {
      loadingUlasan(false);
    }
  }
}
