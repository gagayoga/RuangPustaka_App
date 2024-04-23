import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shimmer/shimmer.dart';

import '../../../components/custom_carousel_image.dart';
import '../../../components/custom_fitur_utama.dart';
import '../../../routes/app_pages.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_sizes.dart';
import '../../../style/app_textsizes.dart';

class BuildWidgetHome extends StatelessWidget {
  final dynamic controller;
  
  const BuildWidgetHome({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {

    // Size
    AppSizes sizes = AppSizes(context);
    
    return RefreshIndicator(
      color: AppColors.backgroundWhite,
      backgroundColor: AppColors.primaryColor,
      onRefresh: () async{
        await Future.delayed(
          const Duration(milliseconds: 1000),
        );
        controller.refreshData();
      },
      child: Container(
        width: sizes.sizeWidth,
        height: sizes.sizeHeight,
        color: AppColors.backgroundWhite,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: sizes.sizeHeight * 0.005,
                      ),

                      SliderScreen(),

                      SizedBox(
                        height: sizes.sizeHeight * 0.025,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              'Fitur Popular',
                              style: GoogleFonts.montserrat(
                                  fontSize: AppTextSizes.subheadline,
                                  color: AppColors.blackColor,
                                  letterSpacing: -0.3,
                                  fontWeight: FontWeight.w700
                              ),
                            ),

                            SizedBox(
                              height: sizes.sizeHeight * 0.005,
                            ),

                            const CustomFiturUtama(),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: sizes.sizeHeight * 0.030,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Kategori Teratas',
                                style: GoogleFonts.montserrat(
                                  color: AppColors.primaryColor,
                                  fontSize: AppTextSizes.caption,
                                  letterSpacing: -0.3,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              Text(
                                'Rekomendasi Teratas',
                                style: GoogleFonts.montserrat(
                                  color: AppColors.blackColor,
                                  fontSize: AppTextSizes.body,
                                  letterSpacing: -0.3,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          ),
                        ),

                        Center(
                          child: Text(
                            'Lihat Semua>',
                            style: GoogleFonts.montserrat(
                              fontSize: AppTextSizes.caption,
                              color: AppColors.secondaryColor,
                              letterSpacing: -0.3,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),

                  SizedBox(
                    height: sizes.sizeHeight * 0.020,
                  ),

                  SizedBox(
                      width: sizes.sizeWidth,
                      child: Obx((){
                        if(controller.dataKategoriBook.isEmpty){
                          return sectionShimmerDataKategori(context);
                        }else{
                          return sectionDataKategoriBook(context);
                        }
                      }),
                      ),

                  SizedBox(
                    height: sizes.sizeHeight * 0.040,
                  ),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      sectionBukuPopular(),

                      SizedBox(
                        height: sizes.sizeHeight * 0.020,
                      ),

                      sectionLayoutBukuPopular(sizes.sizeWidth),
                    ],
                  ),

                  SizedBox(
                    height: sizes.sizeHeight * 0.040,
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: sectionLayoutArticel(sizes.sizeWidth, sizes.sizeHeight),
                  ),
                ],
              ),
            ),

            Obx(() {
              if (controller.showBanner.value) {
                return Positioned.fill(
                  child: Container(
                    width: sizes.sizeWidth,
                    height: sizes.sizeHeight,
                    decoration: BoxDecoration(
                        color: AppColors.blackColor.withOpacity(0.90)
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: sizes.sizeWidth * 0.10, vertical: sizes.sizeHeight * 0.20),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: 400,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.asset(
                                'assets/home/banner.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Align(
                            alignment: Alignment.topRight,
                            child: FractionalTranslation(
                              translation: const Offset(0.2, -0.20),
                              child: InkWell(
                                onTap: (){
                                  controller.showBanner.value = false;
                                },
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: AppColors.backgroundWhite,
                                  ),
                                  child: const Icon(
                                    Iconsax.close_circle,
                                    color: AppColors.primaryColor,
                                    size: 28,
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return const SizedBox(); // Tidak ada banner yang ditampilkan
              }
            })
          ],
        ),
      ),
    );
  }

  // Section Kategori Buku
  Widget sectionDataKategoriBook(BuildContext context){
    return SizedBox(
        height: 208,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: controller.dataKategoriBook.length + 1,
          itemBuilder: (context, index){
            if (index < controller.dataKategoriBook.length) {
              var kategori = controller.dataKategoriBook![index];
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 10 : 0,
                  right: index < controller.dataKategoriBook.length - 1 ? 10 : 10,
                ),
                child: Card(
                  elevation: 0,
                  margin: EdgeInsets.zero,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: (){
                          Get.toNamed(
                              Routes.BOOKKATEGORIPAGE,
                              parameters: {
                                'idBukuKategori' : kategori.kategoriID.toString(),
                                'namaKategoriBuku' : kategori.namaKategori.toString(),
                              }
                          );
                        },
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 135,
                              height: 205,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: ColorFiltered(
                                  colorFilter: ColorFilter.mode(
                                    Colors.black.withOpacity(0.10), // Ubah nilai opacity sesuai kebutuhan
                                    BlendMode.darken,
                                  ),
                                  child: ShaderMask(
                                    shaderCallback: (Rect bounds) {
                                      return LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          AppColors.blackColor.withOpacity(0.30),
                                          AppColors.blackColor.withOpacity(0.60)
                                        ],
                                        stops: const [0, 0.8681],
                                      ).createShader(bounds);
                                    },
                                    blendMode: BlendMode.srcATop,
                                    child: AspectRatio(
                                      aspectRatio: 4 / 6,
                                      child: Image.network(
                                        kategori.coverKategori.toString(),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),

                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Container(
                                decoration: const BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.only(
                                      bottomRight: Radius.circular(10),
                                      bottomLeft: Radius.circular(10),
                                    )
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: Text(
                                    kategori.namaKategori.toString(),
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    style: GoogleFonts.montserrat(
                                      color: AppColors.whiteColor,
                                      fontSize: AppTextSizes.caption,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: -0.3,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }else{
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Container(
                  width: 135,
                  height: 205,
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Stack(
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30, left:15),
                          child: Text(
                            'Lihat kategori lainnya',
                            style: GoogleFonts.montserrat(
                              color: AppColors.greyColor,
                              fontSize: AppTextSizes.caption,
                              letterSpacing: -0.3,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 15,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Lihat Semua',
                                maxLines: 1,
                                style: GoogleFonts.montserrat(
                                  color: AppColors.greyColor,
                                  fontSize: AppTextSizes.caption,
                                  letterSpacing: -0.3,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const Icon(
                                Iconsax.arrow_right,
                                color: AppColors.greyColor,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              );
            }
          },
        ),
    );
  }

  Widget sectionShimmerDataKategori(BuildContext context){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: SizedBox(
          height: 205,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          Container(
                            width: 135,
                            height: 205,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.greyColor.withOpacity(0.30)
                            ),
                          ),

                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(0.40),
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                  )
                              ),
                              child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                                  child: Container(
                                    width: double.infinity,
                                    height: 15,
                                    color: AppColors.whiteColor,
                                  )
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
          ),
        ),
      ),
    );
  }
  // End Section Kategori Buku

  // Section Buku Popular
  Widget sectionBukuPopular(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Buku Popular',
            style: GoogleFonts.montserrat(
              color: AppColors.primaryColor,
              fontSize: AppTextSizes.caption,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w700,
            ),
          ),

          Text(
            'Rekomendasi Buku Popular',
            style: GoogleFonts.montserrat(
              color: AppColors.blackColor,
              fontSize: AppTextSizes.body,
              letterSpacing: -0.3,
              fontWeight: FontWeight.w700,
            ),
          )
        ],
      ),
    );
  }

  Widget sectionLayoutBukuPopular(double width){
    return Stack(
      children: [
        Container(
          width: width,
          height: 280,
          color: AppColors.primaryColor,
        ),

        Positioned(
          right: 0,
          left: 0,
          top: 20,
          bottom: 20,
          child: Obx(() => controller.dataPopularBook.isEmpty
              ? shimmerListBukuPopular() : sectionListBukuPopular(),
          ),
        )
      ],
    );
  }

  Widget sectionListBukuPopular(){
    return SizedBox(
        height: 280,
        child: Obx((){
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: controller.dataPopularBook.length + 1,
            itemBuilder: (context, index){
              if(index == 0){
                return Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: index < controller.dataPopularBook.length - 1 ? 20 : 10,
                  ),
                  child: Container(
                    width: 135,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image.asset(
                      'assets/home/popular_book.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }
              if (index < controller.dataPopularBook.length) {
                var dataBuku = controller.dataPopularBook[index];
                return Padding(
                  padding: EdgeInsets.only(
                    right: index < controller.dataPopularBook.length - 1 ? 10 : 10,
                  ),
                  child: Card(
                    color: Colors.transparent,
                    elevation: 0,
                    margin: EdgeInsets.zero,
                    child: InkWell(
                      highlightColor: Colors.transparent,
                      focusColor: Colors.transparent,
                      splashColor: AppColors.backgroundOnboarding.withOpacity(0.10),
                      onTap: () {
                      },
                      child: SizedBox(
                        width: 135,
                        height: 280,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                  width: 135,
                                  height: 180,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: ColorFiltered(
                                      colorFilter: ColorFilter.mode(
                                        Colors.black.withOpacity(0.45),
                                        BlendMode.darken,
                                      ),
                                      child: AspectRatio(
                                        aspectRatio: 4 / 6,
                                        child: Image.network(
                                          dataBuku.coverBuku.toString(),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
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
                                ),
                              ],
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    dataBuku.judul.toString(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.w600,
                                        fontSize: AppTextSizes.caption,
                                        letterSpacing: -0.4
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 5,
                                  ),

                                  Text(
                                    dataBuku.penulis.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.montserrat(
                                        color: AppColors.backgroundWhite.withOpacity(0.70),
                                        fontWeight: FontWeight.w600,
                                        fontSize: AppTextSizes.small,
                                        letterSpacing: -0.4
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }else{
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Container(
                    width: 135,
                    height: 250,
                    decoration: BoxDecoration(
                        color: AppColors.whiteColor.withOpacity(0.20),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Stack(
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30, left:15),
                            child: Text(
                              'Lihat buku popular lainnya',
                              style: GoogleFonts.montserrat(
                                color: AppColors.whiteColor,
                                fontSize: AppTextSizes.caption,
                                letterSpacing: -0.3,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 15,
                          left: 0,
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Lihat Semua',
                                  maxLines: 1,
                                  style: GoogleFonts.montserrat(
                                    color: AppColors.whiteColor,
                                    fontSize: AppTextSizes.caption,
                                    letterSpacing: -0.3,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                const Icon(
                                  Iconsax.arrow_right,
                                  color: AppColors.whiteColor,
                                  size: 16,
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          );
        }),
    );
  }

  Widget shimmerListBukuPopular(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: 4,
          itemBuilder: (context, index) =>
              Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 10 : 0,
                  right: index < controller.dataPopularBook.length - 1 ? 10 : 10,
                ),
                child: SizedBox(
                  width: 135,
                  height: 250,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 135,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.greyColor.withOpacity(0.30),
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: const AspectRatio(
                              aspectRatio: 4/6,
                            )
                        ),
                      ),

                      const SizedBox(
                        height: 5,
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Container(
                            width: double.infinity,
                            height: 14,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: AppColors.whiteColor.withOpacity(0.60),
                            ),
                          ),

                          const SizedBox(
                            height: 5,
                          ),

                          Container(
                            width: double.infinity,
                            height: 12,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: AppColors.whiteColor.withOpacity(0.60),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
        ),
      ),
    );
  }
  // End Section Buku Popular

  // Section Articel
  Widget sectionLayoutArticel(double width, double height){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Update Informasi',
              style: GoogleFonts.montserrat(
                color: AppColors.primaryColor,
                fontSize: AppTextSizes.caption,
                letterSpacing: -0.3,
                fontWeight: FontWeight.w700,
              ),
            ),

            Text(
              'Dapatkan Informasi Terbaru',
              style: GoogleFonts.montserrat(
                color: AppColors.blackColor,
                fontSize: AppTextSizes.body,
                letterSpacing: -0.3,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),

        SizedBox(
          height: height * 0.020,
        ),

        sectionArtikelFirst(width),

        SizedBox(
          height: height * 0.025,
        ),

        Column(
          children: [
            sectionListArticel(width),
            SizedBox(
              height: height * 0.015,
            ),
            sectionListArticel(width),
          ],
        ),

        SizedBox(
          height: height * 0.040,
        ),
      ],
    );
  }

  Widget sectionArtikelFirst(double width){
    return Container(
      width: width,
      height: 230,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.whiteColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              SizedBox(
                width: width,
                height: 150,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  ),
                  child: ColorFiltered(
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.45),
                      BlendMode.darken,
                    ),
                    child: Image.asset(
                      'assets/home/artikel.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),

              Positioned(
                top: 10,
                left: 10,
                child: SizedBox(
                  width: 30,
                  height: 40,
                  child: SvgPicture.asset(
                    'assets/logo/logo_white.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              )
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical:10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ruang Pustaka Sebuah Aplikasi Transformasi Perpustakaan Digital',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    color: AppColors.blackColor,
                    fontSize: AppTextSizes.body,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 5,
                ),

                Text(
                  'Umum 1 April 2024',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    color: AppColors.greyColor,
                    fontSize: AppTextSizes.small,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget sectionListArticel(double width,){
    return SizedBox(
      width: width,
      height: 100,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: ColorFiltered(
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.25),
                BlendMode.darken,
              ),
              child: Image.asset(
                'assets/home/artikel.png',
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(
            width: 15,
          ),

          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ruang Pustaka Sebuah Aplikasi Transformasi Perpustakaan Digital',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    color: AppColors.blackColor,
                    fontSize: AppTextSizes.body,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  'Umum 1 April 2024',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.montserrat(
                    color: AppColors.greyColor,
                    fontSize: AppTextSizes.small,
                    letterSpacing: -0.3,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
