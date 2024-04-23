import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/kategori/Response_Book_Kategori.dart';
import '../../../data/provider/api_provider.dart';

class BookkategoripageController extends GetxController with StateMixin{

  // Seacrh
  final TextEditingController searchController = TextEditingController();

  var isLoading = RxBool(true);

  // Get Data
  var dataKategoriBook = RxList<DataBookByKategori>();
  final idKategori = Get.parameters['idBukuKategori'];
  
  @override
  void onInit() {
    super.onInit();
    getDataBukuByKategori();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Get Data Semua Buku
  Future<void> getDataBukuByKategori() async {
    isLoading.value = true;
    dataKategoriBook.clear();
    change(null, status: RxStatus.loading());

    String keyword = searchController.text.toString();
    try {
      final responseBook;
      if (keyword == ''){
        responseBook = await ApiProvider.instance().get(
            '${Endpoint.bookByKategori}/$idKategori/search/null');
      }else{
        responseBook = await ApiProvider.instance().get(
            '${Endpoint.bookByKategori}/$idKategori/search/$keyword');
      }


      if (responseBook.statusCode == 200) {
        final ResponseBookKategori responseBookKategori = ResponseBookKategori.fromJson(responseBook.data);

        if (responseBookKategori.data!.isEmpty) {
          dataKategoriBook.clear();
          change(null, status: RxStatus.empty());
        } else {
          dataKategoriBook(responseBookKategori.data);

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
