import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../components/content/custom_datakosong.dart';
import '../../../components/content/custom_loading.dart';
import '../../../components/custom_search_textfield.dart';
import '../../../routes/app_pages.dart';
import '../../../style/app_colors.dart';
import '../../../style/app_sizes.dart';
import '../../../style/app_textsizes.dart';
import '../controllers/bookbypinjam_controller.dart';

class BookbypinjamView extends GetView<BookbypinjamController> {
  const BookbypinjamView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppSizes sizes = AppSizes(context);

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundOnboarding,
          titleSpacing: -10,
          title: Text(
            'Buku Pinjam Online',
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w700,
              letterSpacing: -0.3,
              color: AppColors.blackColor,
              fontSize: AppTextSizes.textButton,
            ),
          ),
          iconTheme: const IconThemeData(
            color: AppColors.primaryColor,
          ),
        ),
        body: Container(
            width: sizes.sizeWidth,
            height: sizes.sizeHeight,
            color: AppColors.backgroundWhite,
            child: Column(
              children: [
                Container(
                  height: sizes.sizeHeight * 0.11,
                  decoration: const BoxDecoration(
                    color: AppColors.backgroundOnboarding,
                  ),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                      child: CustomSearchTextField(
                          controller: controller.searchController,
                          preffixIcon: const Icon(
                            Iconsax.search_normal,
                          ),
                          onChanged: (value){
                            controller.getDataSemuaBuku();
                          },
                          hintLabel: 'Cari buku favoritmu...',
                          obsureText: false,
                          validator: (value){
                            if(value!.isEmpty){
                              return 'Tolong inputan judul buku';
                            }
                            return null;
                          }
                      ),
                    ),
                  ),
                ),

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      height: sizes.sizeHeight * 0.79,
                      color: AppColors.backgroundWhite,
                      child: Obx((){
                        if (controller.isLoading == true){
                          return const CustomLoading();
                        }else if (controller.dataSemuaBook.isEmpty){
                          return CustomSectionDataKosong(width: sizes.sizeWidth, messageError: "Mohon Maaf. Buku ${controller.searchController.text.toString()} tidak ditemukan");
                        }
                        else{
                          return sectionAllBook(sizes.sizeWidth);
                        }
                      }),
                    ),
                  ),
                )
              ],
            )
        )
    );
  }

  // Data Semua Buku
  Widget sectionAllBook(double width){
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 6 / 11.5,
      ),
      itemCount: controller.dataSemuaBook.length,
      itemBuilder: (context, index){
        EdgeInsets cardPadding = EdgeInsets.zero;
        EdgeInsets itemPadding = EdgeInsets.zero;

        if (index == 0 || index == 1) {
          itemPadding = const EdgeInsets.only(top: 10);
        }

        if (index == 0) {
          itemPadding = const EdgeInsets.only(top: 10);
        }

        if (index == 1) {
          itemPadding = const EdgeInsets.only(top: 10);
        }

        if (index == controller.dataSemuaBook.length - 1) {
          itemPadding = const EdgeInsets.only(bottom: 10);
        }

        var bukuList = controller.dataSemuaBook[index];
        return InkWell(
          onTap: () {
            Get.toNamed(Routes.DETAILBOOK,
              parameters: {
                'id': (bukuList.bukuID ?? 0).toString(),
                'judul': (bukuList.judul!).toString()
              },
            );
          },
          child: Padding(
            padding: cardPadding.add(itemPadding),
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: AppColors.greyColor.withOpacity(0.40),
                    width: 0.3
                ),
              ),
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
                            color: AppColors.colorDark,
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
    );
  }
}
