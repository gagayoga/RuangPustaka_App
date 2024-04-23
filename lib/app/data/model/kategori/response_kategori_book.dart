/// Status : 200
/// Message : "Berhasil Get Kategori Buku"
/// data : [{"KategoriID":1,"NamaKategori":"Novel Non Fiksi","CoverKategori":"http://192.168.86.229:8000/storage/images/coverbook/Novel Non Fiksi.png"},{"KategoriID":2,"NamaKategori":"Pendidikan","CoverKategori":"http://192.168.86.229:8000/storage/images/coverbook/Pendidikan.png"},{"KategoriID":3,"NamaKategori":"Biografi","CoverKategori":"http://192.168.86.229:8000/storage/images/coverbook/Biografi.png"},{"KategoriID":4,"NamaKategori":"Novel","CoverKategori":"http://192.168.86.229:8000/storage/images/coverbook/Novel.png"},{"KategoriID":5,"NamaKategori":"Komik","CoverKategori":"http://192.168.86.229:8000/storage/images/coverbook/Komik.png"}]

class ResponseKategoriBook {
  ResponseKategoriBook({
      this.status, 
      this.message, 
      this.data,});

  ResponseKategoriBook.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataKategoriBook.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<DataKategoriBook>? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// KategoriID : 1
/// NamaKategori : "Novel Non Fiksi"
/// CoverKategori : "http://192.168.86.229:8000/storage/images/coverbook/Novel Non Fiksi.png"

class DataKategoriBook {
  DataKategoriBook({
      this.kategoriID, 
      this.namaKategori, 
      this.coverKategori,});

  DataKategoriBook.fromJson(dynamic json) {
    kategoriID = json['KategoriID'];
    namaKategori = json['NamaKategori'];
    coverKategori = json['CoverKategori'];
  }
  int? kategoriID;
  String? namaKategori;
  String? coverKategori;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['KategoriID'] = kategoriID;
    map['NamaKategori'] = namaKategori;
    map['CoverKategori'] = coverKategori;
    return map;
  }

}