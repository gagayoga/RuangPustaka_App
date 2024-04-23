class Endpoint {
  static const String baseUrlApi =
      "http://192.168.92.229:8001/api/users/";

  // Authenticated
  static const String register = "${baseUrlApi}registrasi";
  static const String login = "${baseUrlApi}login";
  static const String logout = "${baseUrlApi}logout";
  static const String checkEmail = "${baseUrlApi}check-email";
  static const String verifyOTp = "${baseUrlApi}verify-otp";
  static const String resetPassword = "${baseUrlApi}forgot-password";


  // Book
  static const String book = "${baseUrlApi}all-buku";
  static const String detailBuku = "${baseUrlApi}buku/detail";
  static const String newBook = "${baseUrlApi}buku/new";
  static const String popularBook = "${baseUrlApi}popular/buku";
  static const String detailBook = "${baseUrlApi}buku/detail";

  // Bookmark
  static const String bookmark = "${baseUrlApi}koleksi";
  static const String deleteBookmark = baseUrlApi;

  // Kategori Book
  static const String kategori = "${baseUrlApi}kategori";
  static const String bookByKategori = "${baseUrlApi}buku-by-kategori";

  // Peminjaman
  static const String pinjamBuku = "${baseUrlApi}pinjam";
  static const String detailPeminjaman = "${baseUrlApi}detail/pinjam";

  // Ulasan
  static const String ulasanBuku = "${baseUrlApi}ulasan";
}