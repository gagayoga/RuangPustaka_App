import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ruangpustaka/app/style/app_sizes.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../style/app_colors.dart';
import '../../../../style/app_textsizes.dart';
import '../controllers/bookviewer_controller.dart';

class BookviewerView extends GetView<BookviewerController> {
  const BookviewerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    AppSizes sizes = AppSizes(context);
    String mode = Get.parameters['modeBuku'].toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.colorDark,
        titleSpacing: 0,
        title: Text(
          Get.parameters['judulBuku'].toString(),
          maxLines: 1,
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.w700,
            letterSpacing: -0.3,
            color: AppColors.whiteColor,
            fontSize: AppTextSizes.textButton,
          ),
        ),
        iconTheme: const IconThemeData(
          color: AppColors.whiteColor,
        ),
      ),
      body: mode == "Viewer" ? Container(
        width: sizes.sizeWidth,
        height: sizes.sizeHeight,
        color: AppColors.colorDark,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 90),
          child: SfPdfViewer.network(
            Get.parameters['fileBuku'].toString(),
            scrollDirection: PdfScrollDirection.horizontal,
            canShowScrollHead: false,
            pageSpacing: 0,
            enableDoubleTapZooming: true,
            pageLayoutMode: PdfPageLayoutMode.single,
            controller: controller.pdfViewerController,
            onPageChanged: (details) {
              if (details.newPageNumber > 3) {
                controller.pdfViewerController.jumpToPage(3);
              }
            },
          ),
        ),
      ) :
      Container(
        width: sizes.sizeWidth,
        height: sizes.sizeHeight,
        color: AppColors.colorDark,
        child: SfPdfViewer.network(
          Get.parameters['fileBuku'].toString(),
          scrollDirection: PdfScrollDirection.horizontal,
          canShowScrollHead: false,
          pageSpacing: 0,
          enableDoubleTapZooming: true,
          pageLayoutMode: PdfPageLayoutMode.single,
          controller: controller.pdfViewerController,
        ),
      ),
    );
  }
}
