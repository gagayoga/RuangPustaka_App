import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ruangpustaka/app/components/content/custom_toast.dart';
import 'package:ruangpustaka/app/data/model/book/response_detail_book.dart';
import 'package:ruangpustaka/app/routes/app_pages.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';
import 'package:intl/intl.dart';

import '../../../../data/constant/endpoint.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../data/provider/storage_provider.dart';

class DetailbookController extends GetxController with StateMixin{

  var dataDetailBook = Rxn<DataDetailBook>();
  final id = Get.parameters['id'];

  var loading = false.obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String formattedToday;
  late String formattedTwoWeeksLater;

  // CheckBox
  var isChecked = false.obs;

  void toggleCheckBox() {
    isChecked.value = !isChecked.value;
  }

  @override
  void onInit() {
    super.onInit();
    getDataDetailBuku(id);

    // Get Tanggal hari ini
    DateTime todayDay = DateTime.now();

    // Menambahkan 14 hari ke tanggal hari ini
    DateTime twoWeeksLater = todayDay.add(const Duration(days: 14));

    // Format tanggal menjadi string menggunakan intl package
    formattedToday = DateFormat('yyyy-MM-dd').format(todayDay);
    formattedTwoWeeksLater = DateFormat('yyyy-MM-dd').format(twoWeeksLater);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getDataDetailBuku(String? idBuku) async {
    change(null, status: RxStatus.loading());

    try {
      final responseDetailBuku = await ApiProvider.instance().get(
          '${Endpoint.detailBuku}/$idBuku');

      if (responseDetailBuku.statusCode == 200) {
        final ResponseDetailBook responseBuku = ResponseDetailBook.fromJson(responseDetailBuku.data);

        if (responseBuku.data == null) {
          change(null, status: RxStatus.empty());
        } else {
          dataDetailBook(responseBuku.data);
          change(null, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("Gagal Memanggil Data"));
      }
    } on DioException catch (e) {
      if (e.response != null) {
        final responseData = e.response?.data;
        if (responseData != null) {
          final errorMessage = responseData['message'] ?? "Unknown error";
          change(null, status: RxStatus.error(errorMessage));
        }
      } else {
        change(null, status: RxStatus.error(e.message));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

  Future<void> addKoleksiBuku(BuildContext context) async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().post(
        Endpoint.bookmark,
        data: {
          "UserID": userID,
          "BukuID": bukuID,
        },
      );

      if (response.statusCode == 201) {
        String judulBuku = Get.parameters['judul'].toString();
        CustomToast.ShowToast("Buku $judulBuku berhasil disimpan di koleksi buku", AppColors.blackColor, AppColors.whiteColor);
        getDataDetailBuku(bukuID);
      } else {
        CustomToast.ShowToast("Buku gagal disimpan, silakan coba kembali", AppColors.blackColor, AppColors.whiteColor);
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          CustomToast.ShowToast(e.response?.data?['message'] ?? "Terjadi kesalahan", AppColors.blackColor, AppColors.whiteColor);
        }
      } else {
        CustomToast.ShowToast(e.message ?? "Terjadi kesalahan", AppColors.blackColor, AppColors.whiteColor);
      }
    } catch (e) {
      loading(false);
      CustomToast.ShowToast(e.toString(), AppColors.blackColor, AppColors.whiteColor);
    }
  }

  deleteKoleksiBook(BuildContext context) async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();
      var response = await ApiProvider.instance().delete(
          '${Endpoint.deleteBookmark}$userID/koleksi/$bukuID');

      if (response.statusCode == 200) {
        CustomToast.ShowToast("Buku berhasil dihapus di koleksi buku", AppColors.blackColor, AppColors.whiteColor);
        getDataDetailBuku(id);
      } else {
        CustomToast.ShowToast("Buku gagal dihapus, silakan coba kembali", AppColors.blackColor, AppColors.whiteColor);
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          CustomToast.ShowToast(e.response?.data?['Message'] ?? "Terjadi kesalahan", AppColors.blackColor, AppColors.whiteColor);
        }
      } else {
        CustomToast.ShowToast(e.message ?? "Terjadi kesalahan", AppColors.blackColor, AppColors.whiteColor);
      }
    } catch (e) {
      loading(false);
      CustomToast.ShowToast(e.toString(), AppColors.blackColor, AppColors.whiteColor);
    }
  }

  addPeminjamanBuku() async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var bukuID = id.toString();

      var responsePostPeminjaman = await ApiProvider.instance().post(Endpoint.pinjamBuku,
        data: {
          "BukuID": bukuID,
        },
      );

      if (responsePostPeminjaman.statusCode == 201) {
        CustomToast.ShowToast("Buku berhasil dipinjam", AppColors.blackColor, AppColors.whiteColor);
      } else {
        CustomToast.ShowToast("Buku gagal dipinjam, silakan coba kembali", AppColors.blackColor, AppColors.whiteColor);
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          CustomToast.ShowToast("${e.response?.data?['message']}", AppColors.blackColor, AppColors.whiteColor);
        }
      } else {
        CustomToast.ShowToast(e.message ?? "Terjadi kesalahan", AppColors.blackColor, AppColors.whiteColor);
      }
    } catch (e) {
      loading(false);
      CustomToast.ShowToast(e.toString(), AppColors.blackColor, AppColors.whiteColor);
    }
  }
}
