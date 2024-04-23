import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:ruangpustaka/app/components/content/custom_datakosong.dart';
import 'package:ruangpustaka/app/routes/app_pages.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';
import 'package:ruangpustaka/app/style/app_sizes.dart';
import 'package:ruangpustaka/app/widgets/menu/ruangpustaka/list_filter_book.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../components/custom_search_textfield.dart';
import '../../../../style/app_textsizes.dart';
import '../controllers/ruangpustakapage_controller.dart';

class RuangpustakapageView extends GetView<RuangpustakapageController> {
  const RuangpustakapageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    // Size
    AppSizes sizes = AppSizes(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: RefreshIndicator(
          color: AppColors.backgroundWhite,
          backgroundColor: AppColors.primaryColor,
          onRefresh: () async{
            await Future.delayed(
              const Duration(milliseconds: 1000),
            );
            controller.getDataKategori();
            controller.getDataSemuaBuku('allbuku');
          },
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: AppColors.backgroundWhite,
                elevation: 0,
                pinned: true,
                centerTitle: false,
                expandedHeight: 305,
                toolbarHeight: sizes.sizeHeight * 0.11,
                floating: true,
                flexibleSpace: Stack(
                  children: [
                    const Positioned.fill(
                      child: Image(
                        image: AssetImage(
                          'assets/ruangpustaka/bg_ruangpustaka.png',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),

                    Positioned(
                      top: kToolbarHeight,
                      left: 10,
                      right: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: CustomSearchTextField(
                                controller: controller.searchController,
                                preffixIcon: const Icon(
                                  Iconsax.search_normal,
                                ),
                                onChanged: (value){
                                  controller.getDataSemuaBuku(value);
                                },
                                hintLabel: 'Cari buku favoritmu...',
                                obsureText: false,
                                validator: (value){
                                  if(value!.isEmpty){
                                    return 'Tolong inputan karakter';
                                  }
                                  return null;
                                }
                            ),
                          ),

                          const SizedBox(
                            width: 10,
                          ),

                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.backgroundWhite,
                            ),
                            child: InkWell(
                              onTap: (){
                              },
                              child: const Icon(
                                Iconsax.scan_barcode,
                                size: 30,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              SliverAppBar(
                backgroundColor: AppColors.backgroundWhite,
                elevation: 0,
                pinned: true,
                bottom: const PreferredSize(
                    preferredSize: Size.fromHeight(-10.0),
                    child: SizedBox(),
                ),
                flexibleSpace: Obx(() =>
                controller.dataKategoriBook.isEmpty ? shimmerDataKategori() : sectionDataKategori(),
                ),
              ),

              SliverAppBar(
                backgroundColor: AppColors.backgroundWhite,
                elevation: 0,
                toolbarHeight: 10,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      Text(
                        'Temukan Buku Favoritmu..',
                        style: GoogleFonts.montserrat(
                          color: AppColors.blackColor,
                          fontSize: AppTextSizes.body,
                          letterSpacing: -0.3,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Obx((){
                if(controller.isLoading == true){
                  return sectionShimmerSemuaBuku();
                }else if(controller.dataSemuaBook.isEmpty){
                  return sectionDataKosong(sizes.sizeWidth);
                }else{
                  return sectionAllBook();
                }
              }),
            ],
          ),
        ),
      )
    );
  }

  // Data Kategori
  Widget sectionDataKategori(){
    return Center(
      child: SizedBox(
        height: 45,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(width: 10),

              ItemFilterBook(
                  onTap: (){
                    controller.getDataSemuaBuku('bacaonline');
                  },
                  namaFilter: "Baca Online"),

              const SizedBox(width: 5),

              ItemFilterBook(
                  onTap: (){
                    controller.getDataSemuaBuku('pinjamonline');
                  },
                  namaFilter: "Pinjam Online"),

              const SizedBox(width: 5),

              ItemFilterBook(
                  onTap: (){
                    controller.getDataSemuaBuku('bacadanpinjam');
                  },
                  namaFilter: "Baca dan Pinjam"),

              const SizedBox(width: 10),
            ],
        ),
      ),
    );
  }

  Widget shimmerDataKategori(){
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(
                  left: index == 0 ? 10 : 0,
                  right: index < controller.dataKategoriBook.length - 1 ? 5 : 5,
                ),
                child: Container(
                  width: 130,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.blackColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Container(
                      height: 20,
                      color: AppColors.backgroundWhite,
                    ),
                  )
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  // End Data Kategori

  // Data Semua Buku
  Widget sectionShimmerSemuaBuku() {
    return SliverAppBar(
      toolbarHeight: 30,
      expandedHeight: 30,
      flexibleSpace: Center(
        child: SizedBox(
          width: 30,
          height: 35,
          child: Lottie.asset(
              'assets/logo/logo_loading.json',
              fit: BoxFit.cover,
              repeat: true,
          ),
        ),
      ),
    );
  }

  Widget sectionAllBook(){
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 6 / 10.5,
      ),
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          EdgeInsets cardPadding = EdgeInsets.zero;
          if (index % 2 == 0) {
            cardPadding = const EdgeInsets.only(left: 10);
          } else {
            cardPadding = const EdgeInsets.only(right: 10);
          }
          var bukuList = controller.dataSemuaBook[index];
          return
            Padding(
              padding: cardPadding,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      color: AppColors.greyColor.withOpacity(0.40),
                      width: 0.3
                  ),
                ),
                child: InkWell(
                  onTap: (){
                    Get.toNamed(Routes.DETAILBOOK,
                      parameters: {
                        'id': (bukuList.bukuID ?? 0).toString(),
                        'judul': (bukuList.judul!).toString()
                      },
                    );
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Container(
                        width: double.infinity,
                        height: 225,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          color: AppColors.backgroundOnboarding.withOpacity(0.25),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: AspectRatio(
                                    aspectRatio: 6 / 8,
                                    child: Image.network(
                                      bukuList.coverBuku.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),

                                bukuList.status == 'Popular' ?
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
                                ) : const SizedBox(),

                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    width: 115,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                      color: AppColors.backgroundWhite,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
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
                                            Iconsax.tick_square,
                                            color: AppColors.primaryColor,
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            bukuList.jenisBuku.toString(),
                                            style: GoogleFonts.montserrat(
                                              letterSpacing: -0.3,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.blackColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              bukuList.judul.toString(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: AppColors.blackColor,
                                letterSpacing: -0.3,
                                fontSize: AppTextSizes.caption,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            Text(
                              bukuList.penulis.toString(),
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyColor,
                                letterSpacing: -0.3,
                                fontSize: AppTextSizes.small,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            const SizedBox(
                              height: 5,
                            ),

                            bukuList.stokBuku == null ? const SizedBox() : Text(
                              'Tersedia : ${bukuList.stokBuku.toString()}',
                              style: GoogleFonts.montserrat(
                                fontWeight: FontWeight.w600,
                                color: AppColors.greyColor,
                                letterSpacing: -0.3,
                                fontSize: AppTextSizes.small,
                              ),
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),

                            Padding(
                              padding: const EdgeInsets.only(top: 5),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        bukuList.rating != null && bukuList.rating! > 0 ?
                                        RatingBarIndicator(
                                          rating: bukuList.rating!,
                                          itemCount: 5,
                                          direction: Axis.horizontal,
                                          itemSize: 15,
                                          itemBuilder: (context, _) =>
                                          const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                        ) :
                                        RatingBarIndicator(
                                          rating: 5,
                                          itemCount: 5,
                                          direction: Axis.horizontal,
                                          itemSize: 15,
                                          itemBuilder: (context, _) => Icon(
                                            Icons.star,
                                            color: AppColors.greyColor
                                                .withOpacity(0.3),
                                          ),
                                        ),

                                        const SizedBox(
                                          width: 5,
                                        ),

                                        Text(
                                          '(${bukuList.totalUlasan.toString()})',
                                          style: GoogleFonts.montserrat(
                                            fontWeight: FontWeight.w600,
                                            color: AppColors.greyColor,
                                            letterSpacing: -0.3,
                                            fontSize: AppTextSizes.caption,
                                          ),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),

                                  const SizedBox(
                                    width: 5,
                                  ),

                                  Text(
                                    '•••',
                                    style: GoogleFonts.montserrat(
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.greyColor,
                                      letterSpacing: -0.3,
                                      fontSize: AppTextSizes.caption,
                                    ),
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
        },
        childCount: controller.dataSemuaBook.length,
      ),
    );
  }
  // End Data Semua Buku

  Widget sectionDataKosong(double width){
    return SliverAppBar(
      toolbarHeight: 400,
      leading: const SizedBox(),
      backgroundColor: AppColors.backgroundWhite,
      elevation: 0,
      flexibleSpace: CustomSectionDataKosong(width: width, messageError: "Mohon Maaf. Buku ${controller.searchController.text.toString()} tidak ditemukan")
    );
  }
}
