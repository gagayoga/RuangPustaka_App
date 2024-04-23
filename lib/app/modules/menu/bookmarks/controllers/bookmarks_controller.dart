import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ruangpustaka/app/components/content/custom_toast.dart';
import 'package:ruangpustaka/app/data/model/book/response_koleksi_book.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';

import '../../../../data/constant/endpoint.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../data/provider/storage_provider.dart';

class BookmarksController extends GetxController with StateMixin{

  var koleksiBook = RxList<DataBookmark>();
  String idUser = StorageProvider.read(StorageKey.idUser);
  final id = Get.parameters['id'];

  // Jumlah Data
  int get jumlahKoleksiBook => koleksiBook.length;

  var loading = false.obs;

  var isLoading = RxBool(true);

  // LongPress
  var isBookmarked = RxBool(false);

  void handleLongPress() {
    isBookmarked.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 1));
    getData();
  }

  Future<void> getData() async {
    isLoading.value = true;
    change(null, status: RxStatus.loading());

    try {
      final responseKoleksiBuku = await ApiProvider.instance().get(
          '${Endpoint.bookmark}/$idUser');

      if (responseKoleksiBuku.statusCode == 200) {
        final ResponseKoleksiBook responseKoleksi = ResponseKoleksiBook.fromJson(responseKoleksiBuku.data);

        if (responseKoleksi.data!.isEmpty) {
          koleksiBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          koleksiBook.assignAll(responseKoleksi.data!);
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
    }finally{
      isLoading.value = false;
    }
  }

  deleteKoleksiBook(String id, BuildContext context) async {
    loading(true);
    try {
      FocusScope.of(Get.context!).unfocus();
      var userID = StorageProvider.read(StorageKey.idUser).toString();
      var bukuID = id.toString();

      var response = await ApiProvider.instance().delete(
          '${Endpoint.deleteBookmark}$userID/koleksi/$bukuID');

      if (response.statusCode == 200) {
        CustomToast.ShowToast("Buku berhasil dihapus di koleksi buku", AppColors.backgroundWhite, AppColors.primaryColor);
        getData();
      } else {
        CustomToast.ShowToast("Buku gagal dihapus, silakan coba kembali", AppColors.backgroundWhite, AppColors.blackColor);
      }
      loading(false);
    } on DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null) {
          CustomToast.ShowToast(e.response?.data?['Message'] ?? "Terjadi kesalahan", AppColors.backgroundWhite, AppColors.blackColor);
        }
      } else {
        CustomToast.ShowToast(e.message ?? "Terjadi kesalahan", AppColors.backgroundWhite, AppColors.blackColor);
      }
    } catch (e) {
      loading(false);
      CustomToast.ShowToast(e.toString(), AppColors.backgroundWhite, AppColors.blackColor);
    }
  }
}
