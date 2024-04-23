import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ruangpustaka/app/components/Item/custom_qr_code.dart';
import 'package:ruangpustaka/app/components/content/custom_loading.dart';
import 'package:ruangpustaka/app/components/custom_button.dart';
import 'package:ruangpustaka/app/style/app_colors.dart';
import 'package:ruangpustaka/app/style/app_textsizes.dart';

import '../../../routes/app_pages.dart';
import '../controllers/buktipeminjaman_controller.dart';

class BuktipeminjamanView extends GetView<BuktipeminjamanController> {
  const BuktipeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
        body: Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Stack(
            children: [

              Container(
                width: width,
                height: height * 0.30,
                decoration: const BoxDecoration(
                  color: AppColors.primaryColor,
                ),
              ),

              Positioned.fill(
                left: 10,
                right: 10,
                bottom: 10,
                child: Padding(
                  padding: const EdgeInsets.only(top: 80, bottom: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Stack(
                      children: [
                        kontenData(width, height),

                        Align(
                          alignment: Alignment.topCenter,
                          child: FractionalTranslation(
                            translation: const Offset(0.01, -0.50),
                            child: SizedBox(
                              width: 65,
                              height: 65,
                              child: SvgPicture.asset(
                                'assets/logo/checklist.svg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
    );
  }

  Widget kontenData(double width, double height){
    return Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 30),
        child: Obx((){
          String asalHalaman = Get.parameters['asalHalaman'].toString();

          if (controller.detailPeminjaman.value.isNull){
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Center(
                child: CustomLoading()
              ),
            );
          }else{
            var dataPeminjaman = controller.detailPeminjaman.value;

            return SingleChildScrollView(
              child: Column(
                children: [

                  const SizedBox(
                    height: 10,
                  ),

                  FittedBox(
                    child: Text(
                      'Peminjaman Buku Berhasil',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700,
                          color: AppColors.blackColor,
                          letterSpacing: -0.5,
                          fontSize: 20.0
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  Divider(
                    color: Colors.black.withOpacity(0.10),
                    thickness: 1,
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  CustomQrCode(code: dataPeminjaman!.kodePeminjaman.toString()),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  kontenBuktiPeminjaman(
                      'Tanggal Peminjaman', dataPeminjaman.tanggalPinjam.toString()
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  kontenBuktiPeminjaman(
                      'Deadline Peminjaman', dataPeminjaman.deadline.toString()
                  ),

                  SizedBox(
                    height: height * 0.040,
                  ),

                  Divider(
                    color: Colors.black.withOpacity(0.10),
                    thickness: 1,
                  ),

                  SizedBox(
                    height: height * 0.030,
                  ),

                  kontenBuktiPeminjaman(
                      'Nama Peminjam', dataPeminjaman.username.toString()
                  ),

                  SizedBox(
                    height: height * 0.010,
                  ),

                  kontenBuktiPeminjaman(
                      'Email Peminjam', dataPeminjaman.email.toString()
                  ),

                  SizedBox(
                    height: height * 0.015,
                  ),

                  kontenBuktiPeminjaman(
                      'Nama Buku', dataPeminjaman.judulBuku.toString()
                  ),

                  SizedBox(
                    height: height * 0.040,
                  ),

                  FittedBox(
                    child: Text(
                      'Jangan lupa kembalikan buku tepat waktu. Terima kasih.',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w600,
                          color: AppColors.greyColor,
                          fontSize: 12.0
                      ),
                    ),
                  ),

                  SizedBox(
                    height: height * 0.050,
                  ),

                  CustomButton(
                      onPressed: (){
                        String asalHalaman = Get.parameters['asalHalaman'].toString();
                        if (asalHalaman == 'detailBuku') {
                          Get.offAllNamed(Routes.DASHBOARD); // Navigasi ke halaman detail buku
                        } else if (asalHalaman == 'historyPeminjaman') {
                          Get.back();
                        }
                      },
                      childWidget: Text(
                        'Kembali',
                        style: GoogleFonts.montserrat(
                          letterSpacing: -0.3,
                          fontSize: AppTextSizes.textButton,
                          fontWeight: FontWeight.w600,
                          color: AppColors.whiteColor,
                        ),
                      ),
                  ),

                  SizedBox(
                    height: height * 0.020,
                  ),
                ],
              ),
            );
          }
        })
    );
  }

  Widget kontenBuktiPeminjaman(String judul, String isi){
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 3,
            child: Text(
              judul,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  letterSpacing: -0.3,
                  fontSize: 14.0
              ),
            ),
          ),

          Flexible(
            flex: 3,
            child: Text(
              isi,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 16.0
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget kontenButton(final onPressed,final Widget child,
      final double radius,
      final Color buttonColor,){
    const Color borderColor = Color(0xFF424242);
    return SizedBox(
        width: double.infinity,
        height: 50.0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius)
            ),
            side: const BorderSide(
              color: borderColor, // Warna border (stroke)
              width: 1.3, // Lebar border (stroke)
            ),
          ),
          onPressed: onPressed,
          child: child,
        )
    );
  }
}
