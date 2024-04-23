import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ruangpustaka/app/routes/app_pages.dart';

class CustomFiturUtama extends StatelessWidget {
  const CustomFiturUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            buildItemFitur('assets/home/fitur/fitur1.png', () {}),
            const SizedBox(
              width: 10,
            ),
            buildItemFitur('assets/home/fitur/fitur2.png', () {
              Get.toNamed(Routes.BOOKBYPINJAM);
            }),
          ],
        ),
        Row(
          children: [
            buildItemFitur('assets/home/fitur/fitur3.png', () {
              Get.toNamed(Routes.BOOKKATEGORIPAGE);
            }),
            const SizedBox(
              width: 10,
            ),
            buildItemFitur('assets/home/fitur/fitur4.png', () {
              Get.toNamed(Routes.RUANGPUSTAKAPAGE);
            }),
          ],
        ),
      ],
    );
  }

  Widget buildItemFitur(String asssetImageFitur, VoidCallback onTap) {
    return Flexible(
      flex: 1,
      child: SizedBox(
        height: 135,
        child: InkWell(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  asssetImageFitur,
                ),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
