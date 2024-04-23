import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ruangpustaka/app/data/model/book/response_all_book.dart';

import '../../../../data/constant/endpoint.dart';
import '../../../../data/model/kategori/response_kategori_book.dart';
import '../../../../data/provider/api_provider.dart';

class RuangpustakapageController extends GetxController with StateMixin{

  // Seacrh
  final TextEditingController searchController = TextEditingController();

  // Get Data
  var dataKategoriBook = RxList<DataKategoriBook>();
  var dataSemuaBook = RxList<DataAllBook>();
  var isLoading = RxBool(true);

  String scannedQrCode = "";

  @override
  void onInit() {
    super.onInit();
    getDataKategori();
    getDataSemuaBuku('allbuku');
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get Data Kategori
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

  // Get Data Semua Buku
  Future<void> getDataSemuaBuku(String keyword) async {
    isLoading.value = true;
    dataSemuaBook.clear();
    change(null, status: RxStatus.loading());

    try {
      final responseSemuaBook = await ApiProvider.instance().get('${Endpoint.book}/$keyword');

      if (responseSemuaBook.statusCode == 200) {
        final ResponseAllBook responseBook = ResponseAllBook.fromJson(responseSemuaBook.data);

        if (responseBook.data!.isEmpty) {
          dataSemuaBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          dataSemuaBook(responseBook.data);

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

}
