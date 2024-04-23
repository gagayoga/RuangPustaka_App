import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ruangpustaka/app/data/model/peminjaman/response_history_peminjaman.dart';

import '../../../../data/constant/endpoint.dart';
import '../../../../data/provider/api_provider.dart';
import '../../../../data/provider/storage_provider.dart';

class HistorypeminjamanController extends GetxController with StateMixin{
  var historyPeminjaman = RxList<DataHistoryPeminjaman>();
  String idUser = StorageProvider.read(StorageKey.idUser);

  var isLoading = RxBool(true);

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
}
