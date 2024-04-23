import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../data/constant/endpoint.dart';
import '../../../../data/model/Book/response_book_new.dart';
import '../../../../data/model/Book/response_popular_book.dart';
import '../../../../data/model/kategori/response_kategori_book.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../data/provider/storage_provider.dart';

class HomeController extends GetxController with StateMixin{

  // Seacrh
  final TextEditingController searchController = TextEditingController();

  // Animation Text
  late AnimationController animationController;
  final textList = [
    'Buka buku, dan bukalah duniamu.',
    'Jangan lupa tersenyum hari ini!',
    'Baca buku adalah hobi yang luar biasa!',
    'Semangat dalam mengejar impian!',
  ].obs;
  final currentIndex = 0.obs;

  // Banner Pemberitahuan
  RxBool showBanner = false.obs;

  void showNotificationBanner() {
    String statusBanner = StorageProvider.read(StorageKey.showBanner);
    if (statusBanner == 'true') {
      showBanner.value = false;
    } else {
      Timer(const Duration(seconds: 5), () {
        showBanner.value = true;
        StorageProvider.write(StorageKey.showBanner, 'true');
      });
    }
  }
  
  // Get Kategori Buku
  var dataKategoriBook = RxList<DataKategoriBook>();
  var dataPopularBook = RxList<DataPopularBook>();
  var dataNewBook = RxList<DataBookNew>();

  @override
  void onInit(){
    super.onInit();

    // Timer mengganti text di animation text home
    Timer.periodic(const Duration(seconds: 30), (timer) {
      currentIndex.value = (currentIndex.value + 1) % textList.length;
    });

    // GetData API
    getDataPopular();
    getDataKategori();

    // Show Banner
    showNotificationBanner();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();

  }

  // Fungsi refresh data
  void refreshData() async{
    await getDataNewBook();
    await getDataPopular();
    await getDataKategori();
  }

  void clearData() async{
    dataNewBook.clear();
    dataKategoriBook.clear();
    dataPopularBook.clear();
  }

  Future<void> getDataNewBook() async {
    dataNewBook.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseNew = await ApiProvider.instance().get(Endpoint.newBook);

      if (responseNew.statusCode == 200) {
        final ResponseBookNew responseBukuNew = ResponseBookNew.fromJson(responseNew.data);

        if (responseBukuNew.data!.isEmpty) {
          dataNewBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          dataNewBook(responseBukuNew.data!);

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

  Future<void> getDataKategori() async {
    dataKategoriBook.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseKategori = await ApiProvider.instance().get(Endpoint.kategori);

      if (responseKategori.statusCode == 200) {
        final ResponseKategoriBook responseKategoriBuku = ResponseKategoriBook.fromJson(responseKategori.data);

        if (responseKategoriBuku.data!.isEmpty) {
          dataKategoriBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          dataKategoriBook(responseKategoriBuku.data);

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

  Future<void> getDataPopular() async {
    dataPopularBook.clear();
    change(null, status: RxStatus.loading());

    try {
      final responsePopular = await ApiProvider.instance().get(Endpoint.popularBook);

      if (responsePopular.statusCode == 200) {
        final ResponsePopularBook responseBukuPopular = ResponsePopularBook.fromJson(responsePopular.data);

        if (responseBukuPopular.data!.isEmpty) {
          dataPopularBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          dataPopularBook(responseBukuPopular.data);

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
}
