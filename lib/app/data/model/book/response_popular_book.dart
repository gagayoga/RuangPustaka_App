/// Status : 200
/// Message : "Berhasil Menampilkan All Buku"
/// data : [{"BukuID":1,"FileBuku":"http://192.168.88.190:8000/storage/file/book/CRYPTO TRADING GUIDE.pdf","CoverBuku":"http://192.168.88.190:8001/storage/images/coverbook/CRYPTO TRADING GUIDE.png","Judul":"CRYPTO TRADING GUIDE","Deskripsi":"Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun.","Penulis":"Asti Isman","Penerbit":"Republika","TahunTerbit":"2006","JumlahHalaman":"438","StokBuku":10,"JenisBuku":"Baca dan Pinjam","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0,"Status":"Popular","Kategori":["Crypto Currency"]}]

class ResponsePopularBook {
  ResponsePopularBook({
      this.status, 
      this.message, 
      this.data,});

  ResponsePopularBook.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(DataPopularBook.fromJson(v));
      });
    }
  }
  int? status;
  String? message;
  List<DataPopularBook>? data;

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

/// BukuID : 1
/// FileBuku : "http://192.168.88.190:8000/storage/file/book/CRYPTO TRADING GUIDE.pdf"
/// CoverBuku : "http://192.168.88.190:8001/storage/images/coverbook/CRYPTO TRADING GUIDE.png"
/// Judul : "CRYPTO TRADING GUIDE"
/// Deskripsi : "Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun."
/// Penulis : "Asti Isman"
/// Penerbit : "Republika"
/// TahunTerbit : "2006"
/// JumlahHalaman : "438"
/// StokBuku : 10
/// JenisBuku : "Baca dan Pinjam"
/// Rating : 5
/// Total_ulasan : 1
/// JumlahRating : 5
/// JumlahPeminjam : 0
/// Status : "Popular"
/// Kategori : ["Crypto Currency"]

class DataPopularBook {
  DataPopularBook({
      this.bukuID, 
      this.fileBuku, 
      this.coverBuku, 
      this.judul, 
      this.deskripsi, 
      this.penulis, 
      this.penerbit, 
      this.tahunTerbit, 
      this.jumlahHalaman, 
      this.stokBuku, 
      this.jenisBuku, 
      this.rating, 
      this.totalUlasan, 
      this.jumlahRating, 
      this.jumlahPeminjam, 
      this.status, 
      this.kategori,});

  DataPopularBook.fromJson(dynamic json) {
    bukuID = json['BukuID'];
    fileBuku = json['FileBuku'];
    coverBuku = json['CoverBuku'];
    judul = json['Judul'];
    deskripsi = json['Deskripsi'];
    penulis = json['Penulis'];
    penerbit = json['Penerbit'];
    tahunTerbit = json['TahunTerbit'];
    jumlahHalaman = json['JumlahHalaman'];
    stokBuku = json['StokBuku'];
    jenisBuku = json['JenisBuku'];
    rating = json['Rating'];
    totalUlasan = json['Total_ulasan'];
    jumlahRating = json['JumlahRating'];
    jumlahPeminjam = json['JumlahPeminjam'];
    status = json['Status'];
    kategori = json['Kategori'] != null ? json['Kategori'].cast<String>() : [];
  }
  int? bukuID;
  String? fileBuku;
  String? coverBuku;
  String? judul;
  String? deskripsi;
  String? penulis;
  String? penerbit;
  String? tahunTerbit;
  String? jumlahHalaman;
  int? stokBuku;
  String? jenisBuku;
  int? rating;
  int? totalUlasan;
  int? jumlahRating;
  int? jumlahPeminjam;
  String? status;
  List<String>? kategori;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['BukuID'] = bukuID;
    map['FileBuku'] = fileBuku;
    map['CoverBuku'] = coverBuku;
    map['Judul'] = judul;
    map['Deskripsi'] = deskripsi;
    map['Penulis'] = penulis;
    map['Penerbit'] = penerbit;
    map['TahunTerbit'] = tahunTerbit;
    map['JumlahHalaman'] = jumlahHalaman;
    map['StokBuku'] = stokBuku;
    map['JenisBuku'] = jenisBuku;
    map['Rating'] = rating;
    map['Total_ulasan'] = totalUlasan;
    map['JumlahRating'] = jumlahRating;
    map['JumlahPeminjam'] = jumlahPeminjam;
    map['Status'] = status;
    map['Kategori'] = kategori;
    return map;
  }

}