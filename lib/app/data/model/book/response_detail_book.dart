/// Status : 200
/// Message : "Berhasil Menampilkan Detail Buku"
/// data : {"Buku":{"BukuID":1,"FileBuku":"http://192.168.92.229:8000/storage/file/book/CRYPTO TRADING GUIDE.pdf","CoverBuku":"http://192.168.92.229:8000/storage/images/coverbook/CRYPTO TRADING GUIDE.png","Judul":"CRYPTO TRADING GUIDE","Deskripsi":"Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun.","Penulis":"Asti Isman","Penerbit":"Republika","TahunTerbit":"2006","JumlahHalaman":"438","StokBuku":10,"JenisBuku":"Baca dan Pinjam","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0,"Status":"Belum disimpan","Keterangan":"Popular","StatusPeminjaman":"Belum dipinjam"},"Kategori":["Crypto Currency"],"Ulasan":[{"UlasanID":1,"UserID":1,"BukuID":1,"Ulasan":"Keren bukunya, rekomendasi buat kalian pokoknya mah. Keren bukunya, Mantap rekomendasi buat kalian pokoknya mah. Keren bukunya, rekomendasi buat kalian pokoknya mah.","Rating":5,"created_at":"2024-04-21T11:13:36.000000Z","updated_at":"2024-04-21T11:13:36.000000Z","users":{"id":1,"Username":"Gagayoga","Email":"yoga.irgi14@smk.belajar.id","Password":"$2y$12$ljewyfKbEVfXuNSMw5IcleUSl/V/vjLIDmmmXSPxFWTaqXovok0nq","Level":"User","otp_token":"77091","otp_expiry":"2024-04-21 05:42:36","created_at":"2024-04-21T04:43:10.000000Z","updated_at":"2024-04-21T05:41:36.000000Z"}}]}

class ResponseDetailBook {
  ResponseDetailBook({
      this.status, 
      this.message, 
      this.data,});

  ResponseDetailBook.fromJson(dynamic json) {
    status = json['Status'];
    message = json['Message'];
    data = json['data'] != null ? DataDetailBook.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  DataDetailBook? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['Status'] = status;
    map['Message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// Buku : {"BukuID":1,"FileBuku":"http://192.168.92.229:8000/storage/file/book/CRYPTO TRADING GUIDE.pdf","CoverBuku":"http://192.168.92.229:8000/storage/images/coverbook/CRYPTO TRADING GUIDE.png","Judul":"CRYPTO TRADING GUIDE","Deskripsi":"Dalam cerita Laskar Pelangi, kita mengenal Ikal sebagai tokoh aku. Di novel Sang Pemimpi, masa SMA Ikal ini akan diceritakan. Bersama Arai dan Jimbron, semangat Ikal untuk menjelajahi Eropa hingga Afrika akan tergugah. Hal ini tak lepas dari campur tangan guru mereka.\n\nJudul “Sang Pemimpi” agaknya sangat cocok dengan karakter novel yang menggugah semangat ini. Novel ini bisa membangkitkan harapan dan menginspirasi, meskipun melalui jalan kemiskinan dan masalah sosial yang berlika-liku. Terlebih, penulisnya membeberkan komentar tentang masalah sosial dengan nada jenaka, membuat pembacanya tertawa miris dalam ironi.\n\nDi dunia nyata, pada dasarnya kita tak melulu dapat termotivasi. Namun, novel ini dipandang sebagai cerita yang realistis daripada menyuapi kita dengan cerita dunia yang pesimis, sehingga sudut pandangnya melihat berbagai kemungkinan untuk menggapai mimpi. Meski hidup dalam kenyataan menjadi orang miskin di Belitung, Ikal bisa menyadari bahwa melakukan hal terbaik yang bisa dilakukan saat ini adalah langkah paling realistis dari pemikiran apa pun.","Penulis":"Asti Isman","Penerbit":"Republika","TahunTerbit":"2006","JumlahHalaman":"438","StokBuku":10,"JenisBuku":"Baca dan Pinjam","Rating":5,"Total_ulasan":1,"JumlahRating":5,"JumlahPeminjam":0,"Status":"Belum disimpan","Keterangan":"Popular","StatusPeminjaman":"Belum dipinjam"}
/// Kategori : ["Crypto Currency"]
/// Ulasan : [{"UlasanID":1,"UserID":1,"BukuID":1,"Ulasan":"Keren bukunya, rekomendasi buat kalian pokoknya mah. Keren bukunya, Mantap rekomendasi buat kalian pokoknya mah. Keren bukunya, rekomendasi buat kalian pokoknya mah.","Rating":5,"created_at":"2024-04-21T11:13:36.000000Z","updated_at":"2024-04-21T11:13:36.000000Z","users":{"id":1,"Username":"Gagayoga","Email":"yoga.irgi14@smk.belajar.id","Password":"$2y$12$ljewyfKbEVfXuNSMw5IcleUSl/V/vjLIDmmmXSPxFWTaqXovok0nq","Level":"User","otp_token":"77091","otp_expiry":"2024-04-21 05:42:36","created_at":"2024-04-21T04:43:10.000000Z","updated_at":"2024-04-21T05:41:36.000000Z"}}]

class DataDetailBook {
  DataDetailBook({
      this.buku, 
      this.kategori, 
      this.ulasan,});

  DataDetailBook.fromJson(dynamic json) {
    buku = json['Buku'] != null ? Buku.fromJson(json['Buku']) : null;
    kategori = json['Kategori'] != null ? json['Kategori'].cast<String>() : [];
    if (json['Ulasan'] != null) {
      ulasan = [];
      json['Ulasan'].forEach((v) {
        ulasan?.add(Ulasan.fromJson(v));
      });
    }
  }
  Buku? buku;
  List<String>? kategori;
  List<Ulasan>? ulasan;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (buku != null) {
      map['Buku'] = buku?.toJson();
    }
    map['Kategori'] = kategori;
    if (ulasan != null) {
      map['Ulasan'] = ulasan?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// UlasanID : 1
/// UserID : 1
/// BukuID : 1
/// Ulasan : "Keren bukunya, rekomendasi buat kalian pokoknya mah. Keren bukunya, Mantap rekomendasi buat kalian pokoknya mah. Keren bukunya, rekomendasi buat kalian pokoknya mah."
/// Rating : 5
/// created_at : "2024-04-21T11:13:36.000000Z"
/// updated_at : "2024-04-21T11:13:36.000000Z"
/// users : {"id":1,"Username":"Gagayoga","Email":"yoga.irgi14@smk.belajar.id","Password":"$2y$12$ljewyfKbEVfXuNSMw5IcleUSl/V/vjLIDmmmXSPxFWTaqXovok0nq","Level":"User","otp_token":"77091","otp_expiry":"2024-04-21 05:42:36","created_at":"2024-04-21T04:43:10.000000Z","updated_at":"2024-04-21T05:41:36.000000Z"}

class Ulasan {
  Ulasan({
      this.ulasanID, 
      this.userID, 
      this.bukuID, 
      this.ulasan, 
      this.rating, 
      this.createdAt, 
      this.updatedAt, 
      this.users,});

  Ulasan.fromJson(dynamic json) {
    ulasanID = json['UlasanID'];
    userID = json['UserID'];
    bukuID = json['BukuID'];
    ulasan = json['Ulasan'];
    rating = json['Rating'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    users = json['users'] != null ? Users.fromJson(json['users']) : null;
  }
  int? ulasanID;
  int? userID;
  int? bukuID;
  String? ulasan;
  int? rating;
  String? createdAt;
  String? updatedAt;
  Users? users;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['UlasanID'] = ulasanID;
    map['UserID'] = userID;
    map['BukuID'] = bukuID;
    map['Ulasan'] = ulasan;
    map['Rating'] = rating;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (users != null) {
      map['users'] = users?.toJson();
    }
    return map;
  }

}

/// id : 1
/// Username : "Gagayoga"
/// Email : "yoga.irgi14@smk.belajar.id"
/// Password : "$2y$12$ljewyfKbEVfXuNSMw5IcleUSl/V/vjLIDmmmXSPxFWTaqXovok0nq"
/// Level : "User"
/// otp_token : "77091"
/// otp_expiry : "2024-04-21 05:42:36"
/// created_at : "2024-04-21T04:43:10.000000Z"
/// updated_at : "2024-04-21T05:41:36.000000Z"

class Users {
  Users({
      this.id, 
      this.username, 
      this.email, 
      this.password, 
      this.level, 
      this.otpToken, 
      this.otpExpiry, 
      this.createdAt, 
      this.updatedAt,});

  Users.fromJson(dynamic json) {
    id = json['id'];
    username = json['Username'];
    email = json['Email'];
    password = json['Password'];
    level = json['Level'];
    otpToken = json['otp_token'];
    otpExpiry = json['otp_expiry'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
  int? id;
  String? username;
  String? email;
  String? password;
  String? level;
  String? otpToken;
  String? otpExpiry;
  String? createdAt;
  String? updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['Username'] = username;
    map['Email'] = email;
    map['Password'] = password;
    map['Level'] = level;
    map['otp_token'] = otpToken;
    map['otp_expiry'] = otpExpiry;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    return map;
  }

}

/// BukuID : 1
/// FileBuku : "http://192.168.92.229:8000/storage/file/book/CRYPTO TRADING GUIDE.pdf"
/// CoverBuku : "http://192.168.92.229:8000/storage/images/coverbook/CRYPTO TRADING GUIDE.png"
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
/// Status : "Belum disimpan"
/// Keterangan : "Popular"
/// StatusPeminjaman : "Belum dipinjam"

class Buku {
  Buku({
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
      this.keterangan, 
      this.statusPeminjaman,});

  Buku.fromJson(dynamic json) {
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
    keterangan = json['Keterangan'];
    statusPeminjaman = json['StatusPeminjaman'];
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
  String? keterangan;
  String? statusPeminjaman;

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
    map['Keterangan'] = keterangan;
    map['StatusPeminjaman'] = statusPeminjaman;
    return map;
  }

}