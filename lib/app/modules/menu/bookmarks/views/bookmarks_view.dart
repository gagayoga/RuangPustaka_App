import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../components/content/custom_datakosong.dart';
import '../../../../components/content/custom_loading.dart';
import '../../../../routes/app_pages.dart';
import '../../../../style/app_colors.dart';
import '../../../../style/app_sizes.dart';
import '../../../../style/app_textsizes.dart';
import '../controllers/bookmarks_controller.dart';

class BookmarksView extends GetView<BookmarksController> {
  const BookmarksView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppSizes sizes = AppSizes(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundOnboarding.withOpacity(0.30),
        titleSpacing: 13,
        title: Text(
          'Koleksi Buku',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: AppColors.blackColor,
            fontSize: AppTextSizes.textButton,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
              onTap: (){
                controller.refreshData();
              },
              child: const Icon(
                Iconsax.refresh5,
                color: AppColors.primaryColor,
              ),
            ),
          )
        ],
        iconTheme: const IconThemeData(
          color: AppColors.primaryColor,
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.backgroundWhite,
        backgroundColor: AppColors.primaryColor,
        onRefresh: () async{
          controller.refreshData();
        },
        child: SizedBox(
          width: sizes.sizeWidth,
          height: sizes.sizeBody,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: sectionAllBook(sizes.sizeWidth),
          ),
        ),
      )
    );
  }

  // Data Semua Buku
  Widget sectionAllBook(double width){

    return Obx((){
      if(controller.isLoading == true){
        return const Padding(
          padding: EdgeInsets.all(15.0),
          child: CustomLoading(),
        );
      }
      if(controller.koleksiBook.isEmpty){
        return CustomSectionDataKosong(width: width, messageError: "Maaf Data Koleksi Buku Kososng.");
      }else{
        return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0,
            childAspectRatio: 6 / 8,
          ),
          itemCount: controller.koleksiBook.length,
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

            if (index == controller.koleksiBook.length - 1) {
              itemPadding = const EdgeInsets.only(bottom: 10);
            }
            var bukuList = controller.koleksiBook[index];
            return AspectRatio(
              aspectRatio: 6 / 8,
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

                      Center(
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: Stack(
                            children: [
                              GestureDetector(
                                onTap: (){
                                  Get.toNamed(Routes.DETAILBOOK,
                                    parameters: {
                                      'id': (bukuList.bukuID ?? 0).toString(),
                                      'judul': (bukuList.judul!).toString()
                                    },
                                  );
                                },
                                onLongPress: (){
                                  controller.isBookmarked.value = true;
                                },
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                                  child: AspectRatio(
                                    aspectRatio: 6 / 8,
                                    child: Image.network(
                                      bukuList.coverBuku.toString(),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),

                              bukuList.statusBuku == 'Popular' ?
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
                                      bottomLeft: Radius.circular(10),
                                      bottomRight: Radius.circular(10),
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
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      }
    });
  }
}
