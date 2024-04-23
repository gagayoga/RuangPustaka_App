import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ruangpustaka/app/components/content/custom_loading.dart';
import 'package:ruangpustaka/app/components/custom_button.dart';
import 'package:ruangpustaka/app/components/custom_textfield_peminjaman.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';
import 'package:ruangpustaka/app/style/app_sizes.dart';

import '../../../../data/model/book/response_detail_book.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/app_textsizes.dart';
import '../controllers/detailbook_controller.dart';

class DetailbookView extends GetView<DetailbookController> {
  const DetailbookView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    AppSizes sizes = AppSizes(context);

    return Scaffold(
      appBar: AppBar(
        titleSpacing: -5,
        toolbarHeight: 50,
        title: Text(
          Get.parameters['judul'].toString(),
          style: GoogleFonts.montserrat(
              fontSize: 16.0,
              color: Colors.black,
              fontWeight: FontWeight.w700),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        actions: [
          Obx(() {
            var dataBuku = controller.dataDetailBook.value?.buku;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                icon: Icon(
                  dataBuku?.status == 'Tersimpan'
                      ? CupertinoIcons.heart_fill
                      : CupertinoIcons.suit_heart,
                  color: dataBuku?.status == 'Tersimpan'
                      ? const Color(0xFF080BA1)
                      : Colors.black,
                  size: 24,
                ),
                onPressed: () {
                  if (dataBuku?.status == 'Tersimpan') {
                    controller.deleteKoleksiBook(context);
                  } else {
                    controller.addKoleksiBuku(context);
                  }
                },
              ),
            );
          })
        ],
      ),
      body: Container(
        color: AppColors.backgroundOnboarding.withOpacity(0.70),
        width: sizes.sizeWidth,
        height: sizes.sizeBody,
        child: Stack(
          children: [
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.only(
                    bottom: 95), // Sesuaikan dengan tinggi tombol
                child: kontenDataDetailBuku(context),
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 90,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5).withOpacity(0.70),
                    border: Border(
                      top: BorderSide(
                        color: const Color(0xFF424242).withOpacity(0.20),
                        width: 0.2,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: buttonDetailBuku(),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget kontenDataDetailBuku(BuildContext context) {
    AppSizes sizes = AppSizes(context);

    return Obx(
          () {
        if (controller.dataDetailBook.isNull) {
          return Padding(
            padding: EdgeInsets.only(top: sizes.sizeBody * 0.4),
            child: const CustomLoading(),
          );
        } else if (controller.dataDetailBook.value == null) {
          return Padding(
            padding: EdgeInsets.only(top: sizes.sizeBody * 0.4),
            child: const CustomLoading(),
          );
        } else {
          var dataBuku = controller.dataDetailBook.value?.buku;
          var dataKategori = controller.dataDetailBook.value?.kategori;
          var dataUlasan = controller.dataDetailBook.value?.ulasan;
          return  Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      spreadRadius: -1,
                      blurRadius: 20,
                      offset: const Offset(0, -1), // changes position of shadow
                    ),
                  ],
                ),
                height: 250,
                child: Stack(
                  children: [

                    Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: SizedBox(
                        width: sizes.sizeWidth,
                        height: 250,
                        child: Stack(
                          children: [
                            Image.network(
                              dataBuku!.coverBuku.toString(),
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            ),
                            BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 2, sigmaY:2),
                              child: Container(
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Center(
                        child: SizedBox(
                          width: 135,
                          height: 200,
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Image.network(
                                  dataBuku.coverBuku.toString(),
                                  fit: BoxFit.cover,
                                ),
                              ),

                              dataBuku.fileBuku == "Kosong" ? const SizedBox() :
                              Positioned(
                                right: 10,
                                bottom: 10,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: AppColors.backgroundWhite.withOpacity(0.60),
                                  ),
                                  child: InkWell(
                                    onTap: (){
                                      Get.toNamed(Routes.BOOKVIEWER,
                                      parameters: {
                                        'judulBuku' : dataBuku.judul.toString(),
                                        'fileBuku' : dataBuku.fileBuku.toString(),
                                        'modeBuku' : "Viewer",
                                      });
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.all(3.0),
                                      child: Icon(Iconsax.eye),
                                    ),
                                  ),
                                ),
                              ),

                              dataBuku.keterangan == 'Tidak Popular' ? const SizedBox() : Positioned(
                                top: 0,
                                left: 0,
                                right: 20,
                                child: Container(
                                  width: 115,
                                  height: 30,
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondaryColor,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12),
                                      bottomRight: Radius.circular(12),
                                      bottomLeft: Radius.circular(0),
                                      topRight: Radius.circular(12),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Icon(
                                          Iconsax.chart,
                                          color: Colors.white,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          'Popular',
                                          style: GoogleFonts.montserrat(
                                            letterSpacing: -0.3,
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.whiteColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ) ,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),


              Container(
                color: AppColors.backgroundWhite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: sizes.sizeHeight * 0.015,
                      ),

                      Text(
                        dataBuku.judul!,
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                          letterSpacing: -0.4,
                          fontSize: 28.0,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.start,
                      ),

                      FittedBox(
                        child: Text(
                          "${dataBuku.penerbit!} | @${dataBuku.tahunTerbit!} ",
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: 16.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      SizedBox(
                        height: sizes.sizeHeight * 0.020,
                      ),

                      Container(
                        width: sizes.sizeWidth,
                        decoration: BoxDecoration(
                          color: AppColors.backgroundOnboarding.withOpacity(0.30),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Center(
                                    child: SizedBox(
                                      width: 35,
                                      height: 35,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.asset(
                                          'assets/home/profile.png',
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 10,
                                  ),

                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        dataBuku.penulis ?? '',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.black,
                                            fontSize: 12
                                        ),
                                      ),

                                      Text(
                                        'Bahagia itu sederhana',
                                        style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: Colors.black.withOpacity(0.50),
                                            fontSize: 10
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    color: AppColors.backgroundWhite,
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: const Icon(Iconsax.profile_circle),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: sizes.sizeHeight * 0.005,
              ),


              Container(
                color: AppColors.backgroundWhite,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    child: Container(
                      width: sizes.sizeWidth,
                      decoration: BoxDecoration(
                          color: const Color(0xFFFFFFFF).withOpacity(0.30),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: const Color(0xFF61677D).withOpacity(0.20),
                            width: 0.5,
                          )),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    dataBuku.jumlahHalaman!,
                                    style: GoogleFonts.montserrat(
                                      color: AppColors.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    'Halaman',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 25,
                              width: 1,
                              color: Colors.white,
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    dataBuku.jumlahRating!.toString(),
                                    style: GoogleFonts.montserrat(
                                      color: AppColors.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    'Rating',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 25,
                              width: 1,
                              color: Colors.white,
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    dataBuku.stokBuku == null ? "0" : dataBuku.stokBuku.toString(),
                                    style: GoogleFonts.montserrat(
                                      color: AppColors.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    'Stok Buku',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              height: 25,
                              width: 1,
                              color: Colors.white,
                            ),
                            Flexible(
                              flex: 1,
                              child: Column(
                                children: [
                                  Text(
                                    dataBuku.jumlahPeminjam!.toString(),
                                    style: GoogleFonts.montserrat(
                                      color: AppColors.primaryColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  ),
                                  Text(
                                    'Peminjam',
                                    style: GoogleFonts.montserrat(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: sizes.sizeHeight * 0.005,
              ),

              Container(
                color: AppColors.backgroundWhite,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: sizes.sizeHeight * 0.010,
                      ),

                      Text(
                        "Deskripsi Buku",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),

                      SizedBox(
                        height: sizes.sizeHeight * 0.005,
                      ),

                      Text(
                        dataBuku.deskripsi!,
                        maxLines: 15,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.w400,
                            color: Colors.black.withOpacity(0.80),
                            fontSize: 14.0,
                            letterSpacing: -0.3
                        ),
                        textAlign: TextAlign.justify,
                      ),

                      SizedBox(
                        height: sizes.sizeHeight * 0.010,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: sizes.sizeHeight * 0.005,
              ),

              Container(
                width: sizes.sizeWidth,
                color: AppColors.backgroundWhite,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Kategori Buku",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontSize: 16.0,
                        ),
                      ),
                      SizedBox(
                        height: sizes.sizeHeight * 0.005,
                      ),
                      Wrap(
                        children: dataKategori!.map((kategori) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: TextButton(
                              onPressed: () {
                                // Tambahkan fungsi yang ingin dijalankan saat tombol ditekan
                              },
                              style: TextButton.styleFrom(
                                backgroundColor: AppColors.backgroundOnboarding.withOpacity(0.50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                              ),
                              child: Text(
                                kategori,
                                style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w600,
                                  color: Colors
                                      .black, // Sesuaikan dengan warna yang diinginkan
                                  fontSize: 14.0,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: sizes.sizeHeight * 0.005,
              ),

              Container(
                color: AppColors.backgroundWhite,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(
                        height: sizes.sizeHeight * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "Ulasan Buku",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: Colors.black,
                              fontSize: 16.0,
                            ),
                          ),

                          Text(
                            "Lihat semua>",
                            style: GoogleFonts.montserrat(
                              fontWeight: FontWeight.w700,
                              color: AppColors.secondaryColor,
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: sizes.sizeHeight * 0.010,
                      ),
                      buildUlasanList(dataUlasan),

                      SizedBox(
                        height: sizes.sizeHeight * 0.010,
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget buildUlasanList(List<Ulasan>? ulasanList) {
    final width = MediaQuery.of(Get.context!).size.width;

    return ulasanList != null && ulasanList.isNotEmpty
        ? ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ulasanList.length,
      itemBuilder: (context, index) {
        Ulasan ulasan = ulasanList[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.backgroundOnboarding.withOpacity(0.50),
              borderRadius: BorderRadius.circular(10),
            ),
            width: width,
            child: Padding(
              padding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Center(
                        child: SizedBox(
                          width: 35,
                          height: 35,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/home/profile.png',
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        width: width * 0.035,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              ulasan.users?.username ?? '',
                              style: GoogleFonts.montserrat(
                                  fontWeight: FontWeight.w700,
                                  color: Colors.black,
                                  fontSize: 12),
                            ),

                            const SizedBox(height: 3,),

                            // Menampilkan rating di bawah teks penulis
                            RatingBarIndicator(
                              direction: Axis.horizontal,
                              rating: ulasan.rating!.toDouble(),
                              itemCount: 5,
                              itemSize: 10,
                              itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  Text(
                    ulasan.ulasan ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 12.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    )
        : Container(
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5).withOpacity(0.50),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF424242).withOpacity(0.1),
          width: 0.2,
        ),
      ),
      child: Text(
        'Belum ada ulasan buku',
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w500,
          color: Colors.black,
          fontSize: 14.0,
        ),
      ),
    );
  }

  Widget buttonDetailBuku() {
    const Color buttonColor = Color(0xFF080BA1);
    const Color borderColor = Color(0xFF424242);

    return Obx((){
      var dataBuku = controller.dataDetailBook.value?.buku;

      if(controller.dataDetailBook.value == null){
        return const SizedBox();
      }else{
        if(dataBuku?.jenisBuku == "Baca Online"){
          return SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                  color: borderColor.withOpacity(0.30),
                  width: 0.3,
                ),
              ),
              onPressed: () {
                Get.toNamed(Routes.BOOKVIEWER,
                    parameters: {
                      'judulBuku' : dataBuku!.judul.toString(),
                      'fileBuku' : dataBuku.fileBuku.toString(),
                      'modeBuku' : "bacaBuku",
                    });
              },
              child: Text(
                "Baca Buku",
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }else if(dataBuku?.jenisBuku == 'Pinjam Online'){
          return SizedBox(
            width: double.infinity,
            height: 50.0,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: dataBuku?.statusPeminjaman == 'Belum dipinjam' ? AppColors.primaryColor : AppColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                side: BorderSide(
                  color: borderColor.withOpacity(0.30),
                  width: 0.3,
                ),
              ),
              onPressed: () {
                if (dataBuku?.statusPeminjaman == 'Belum dipinjam') {
                  showModalBottomSheet(
                      context: Get.context!,
                      builder: (BuildContext context){
                        return showConfirmPeminjaman(Get.context!, dataBuku!.judul.toString());
                      }
                  );
                }else if(dataBuku?.statusPeminjaman == 'Dipinjam'){
                  return;
                }
              },
              child: Text(
                dataBuku?.statusPeminjaman == 'Belum dipinjam'
                    ? 'Pinjam Buku' : 'Dipinjam',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          );
        }else{
          return Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        color: borderColor.withOpacity(0.30),
                        width: 0.3,
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed(Routes.BOOKVIEWER,
                          parameters: {
                            'judulBuku' : dataBuku!.judul.toString(),
                            'fileBuku' : dataBuku.fileBuku.toString(),
                            'modeBuku' : "bacaBuku",
                          });
                    },
                    child: Text(
                      'Baca Buku',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  height: 50.0,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: dataBuku?.statusPeminjaman == "Belum dipinjam" ? AppColors.primaryColor : AppColors.secondaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      side: BorderSide(
                        color: borderColor.withOpacity(0.30),
                        width: 0.3,
                      ),
                    ),
                    onPressed: () {
                      if (dataBuku?.statusPeminjaman == 'Belum dipinjam') {
                        Get.toNamed(Routes.HOME,
                          parameters: {
                            'id': (dataBuku?.bukuID ?? 0).toString(),
                            'judul': (dataBuku?.judul!).toString()
                          },
                        );
                      }else if(dataBuku?.statusPeminjaman == 'Dipinjam'){
                        Get.toNamed(Routes.BUKTIPEMINJAMAN,
                          parameters: {
                            'id': (dataBuku?.bukuID ?? 0).toString(),
                            'judul': (dataBuku?.judul!).toString()
                          },
                        );
                      }
                    },
                    child: Text(
                      dataBuku?.statusPeminjaman == 'Belum dipinjam'
                          ? 'Pinjam Buku' : 'Dipinjam',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      }
    });
  }

  // Widget Konfirmasi Peminjaman
  Widget showConfirmPeminjaman(BuildContext context, String judulBuku){

    AppSizes sizes = AppSizes(context);
    return Container(
      width: sizes.sizeWidth,
      height: sizes.sizeHeight,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        color: AppColors.backgroundWhite
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
                Text(
                  "Konfirmasi Peminjaman",
                  maxLines: 1,
                  style: GoogleFonts.montserrat(
                      fontSize: 18.0,
                      letterSpacing: -0.3,
                      color: AppColors.blackColor,
                      fontWeight: FontWeight.w800),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizes.sizeWidth * 0.25, vertical: 15),
                  child: Divider(height: 2,color: AppColors.greyColor.withOpacity(0.30)),
                ),
                const SizedBox(height: 20),
                Text(
                  judulBuku,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontSize: 20.0,
                      letterSpacing: -0.3,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 30),
                CustomTextFieldPeminjaman(
                    suffixIcon: const Icon(Iconsax.calendar, color: AppColors.primaryColor),
                    controller: controller.formattedToday,
                    hintLabel: "Tanggal Peminjaman", labelText: "Tanggal Peminjaman" ,
                    gapHeight: 10, obsureText: false),

                const SizedBox(height: 10),
                CustomTextFieldPeminjaman(
                    suffixIcon: const Icon(Iconsax.calendar, color: AppColors.primaryColor),
                    controller: controller.formattedTwoWeeksLater,
                    hintLabel: "Deadline Peminjaman", labelText: "Deadline Peminjaman" ,
                    gapHeight: 10, obsureText: false),
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Obx(() => Checkbox(
                        value: controller.isChecked.value,
                        onChanged: (value) {
                          controller.toggleCheckBox();
                        },
                        activeColor: AppColors.primaryColor,
                      )
                      ),
                      Expanded(
                        child: Text(
                          "Setuju dengan jadwal peminjaman buku!",
                          maxLines: 1,
                          style: GoogleFonts.montserrat(
                            fontSize: AppTextSizes.small,
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                CustomButton(
                onPressed: (){
                  if (!controller.isChecked.value) {
                    return;
                  }
                  controller.addPeminjamanBuku();
                },
                childWidget: Text(
                  "Setuju dan Lanjutkan",
                   style: GoogleFonts.montserrat(
                    fontSize: AppTextSizes.textButton,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
