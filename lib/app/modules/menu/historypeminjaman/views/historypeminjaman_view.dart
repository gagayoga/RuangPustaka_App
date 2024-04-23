import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ruangpustaka/app/components/content/custom_datakosong.dart';
import 'package:ruangpustaka/app/components/content/custom_loading.dart';
import 'package:ruangpustaka/app/routes/app_pages.dart';
import 'package:ruangpustaka/app/style/app_sizes.dart';

import '../../../../components/content/customTabBar.dart';
import '../../../../style/app_colors.dart';
import '../../../../style/app_textsizes.dart';
import '../controllers/historypeminjaman_controller.dart';

class HistorypeminjamanView extends GetView<HistorypeminjamanController> {
  const HistorypeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppSizes sizes = AppSizes(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.backgroundOnboarding.withOpacity(0.30),
          titleSpacing: 13,
          title: Text(
            'History Peminjaman Buku',
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Container(
              height: 50,
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
              ),
              child: TabBar(
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                indicator: const BoxDecoration(
                  color: AppColors.secondaryColor,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  CustomTabBar(
                      tittle: 'Dipinjam',
                      onTap: () async{
                        controller.getDataPeminjaman("Dipinjam");
                      },
                      widgetText: Obx(() =>
                          Text(
                            controller.historyPeminjaman.length > 20 ? "20++" : controller.historyPeminjaman.length.toString(),
                            style: GoogleFonts.inriaSans(
                              color: const Color(0xFFEA1818),
                            ),
                          )),
                  ),
                  CustomTabBar(
                    tittle: 'Selesai',
                    onTap: () async{
                      controller.getDataPeminjaman("Selesai");
                    },
                    widgetText: Obx(() =>
                        Text(
                          controller.historyPeminjaman.length > 20 ? "20++" : controller.historyPeminjaman.length.toString(),
                          style: GoogleFonts.inriaSans(
                            color: const Color(0xFFEA1818),
                          ),
                        )),
                  ),
                  CustomTabBar(
                    tittle: 'Ditolak',
                    onTap: () async{
                      controller.getDataPeminjaman("Ditolak");
                    },
                    widgetText: Obx(() =>
                        Text(
                          controller.historyPeminjaman.length > 20 ? "20++" : controller.historyPeminjaman.length.toString(),
                          style: GoogleFonts.inriaSans(
                            color: const Color(0xFFEA1818),
                          ),
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SizedBox(
              width: sizes.sizeWidth,
              height: sizes.sizeHeight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: sizes.sizeHeight * 0.025,
                      ),

                      sectionKoleksiBuku(context),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: sizes.sizeWidth,
              height: sizes.sizeHeight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: sizes.sizeHeight * 0.025,
                      ),

                      sectionKoleksiBuku(context),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: sizes.sizeWidth,
              height: sizes.sizeHeight,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      SizedBox(
                        height: sizes.sizeHeight * 0.025,
                      ),

                      sectionKoleksiBuku(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
      ),
    );
  }

  Widget sectionKoleksiBuku(BuildContext context) {
    AppSizes sizes = AppSizes(context);
    return Obx((){
      if(controller.historyPeminjaman.isEmpty){
        return CustomSectionDataKosong(width: sizes.sizeWidth, messageError: "Mohon maaf, data history peminjaman kosong");
      }else if(controller.isLoading.value == true){
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 20.0),
          child: CustomLoading(),
        );
      }
      else{
        return SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                children:
                List.generate(
                  controller.historyPeminjaman.length,
                      (index) {
                    var dataKoleksi = controller.historyPeminjaman[index];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: MediaQuery.of(Get.context!).size.width,
                        decoration: BoxDecoration(
                            color: const Color(0xFFF5F5F5).withOpacity(0.60),
                            borderRadius: BorderRadius.circular(10)
                        ),
                        height: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Flexible(
                              flex:3,
                              child: InkWell(
                                onTap: (){
                                  if(dataKoleksi.status == "Selesai"){

                                  }else{
                                    Get.toNamed(Routes.BUKTIPEMINJAMAN, parameters: {
                                      'idPeminjaman': dataKoleksi.peminjamanID.toString(),
                                      'asalHalaman' : 'historyPeminjaman',
                                    });
                                  }
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Container(
                                    height: 150,
                                    decoration : BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.5),
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          offset: const Offset(0, 5), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    // Lebar gambar 40% dari layar
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: AspectRatio(
                                            aspectRatio: 2 / 2,
                                            child: Image.network(
                                              dataKoleksi.coverBuku.toString(),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),

                                        Positioned(
                                          left: 0,
                                          bottom: 0,
                                          right: 0,
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: dataKoleksi.status == 'Ditolak'
                                                    ? const Color(0xFFEA1818)
                                                    : dataKoleksi.status == 'Dipinjam'
                                                    ? AppColors.primaryColor
                                                    : dataKoleksi.status ==
                                                    'Selesai'
                                                    ? AppColors.colorSuccess
                                                    : const Color(0xFF1B1B1D),
                                                borderRadius: const BorderRadius.only(
                                                  bottomLeft: Radius.circular(10),
                                                  bottomRight: Radius.circular(10),
                                                )),
                                            child: Padding(
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 10, horizontal: 10),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                                  children: [
                                                    dataKoleksi.status == 'Selesai' ? const SizedBox() : const Icon(
                                                      Iconsax.info_circle,
                                                      color: Colors.white,
                                                      size: 20,
                                                    ),


                                                    dataKoleksi.status == 'Selesai' ? const SizedBox() : const SizedBox(
                                                      width: 10,
                                                    ),

                                                    Text(
                                                      dataKoleksi.status == 'Selesai' ? 'Beri Ulasan' : dataKoleksi.status.toString(),
                                                      style: GoogleFonts.poppins(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize: 13,
                                                      ),
                                                    )
                                                  ],
                                                )),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),


                            Flexible(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dataKoleksi.kodePeminjaman!,
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        color: const Color(0xFF260534),
                                        fontSize: 18.0,
                                      ),
                                      textAlign: TextAlign.start,
                                    ),
                                    Text(
                                      dataKoleksi.judulBuku!,
                                      style: GoogleFonts.poppins(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: -0.2,
                                        fontSize: 16.0,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "Tanggal Pinjam : ${dataKoleksi.tanggalPinjam!}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 12.0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "Deadline Pinjam : ${dataKoleksi.deadline!}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 12.0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                    FittedBox(
                                      child: Text(
                                        "Tanggal Kembali : ${dataKoleksi.tanggalKembali!}",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                          fontSize: 12.0,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Flexible(
                              flex: 1,
                              child: Center(
                                child: InkWell(
                                  onTap: (){
                                  },
                                  child: const Icon(
                                    CupertinoIcons.trash_fill,
                                    color: Color(0xFFFF0000),
                                    size: 26,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                )
            )
        );
      }
    });
  }
}
