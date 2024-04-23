import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:ruangpustaka/app/modules/menu/bookmarks/views/bookmarks_view.dart';
import 'package:ruangpustaka/app/modules/menu/home/views/home_view.dart';
import 'package:ruangpustaka/app/modules/menu/profile/views/profile_view.dart';
import 'package:ruangpustaka/app/modules/menu/ruangpustakapage/views/ruangpustakapage_view.dart';

import '../../../components/content/customBarMaterial.dart';
import '../../buktipeminjaman/views/buktipeminjaman_view.dart';
import '../../menu/historypeminjaman/views/historypeminjaman_view.dart';
import '../controllers/dashboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(builder: (controller) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: IndexedStack(
          index: controller.tabIndex,
          children: const [
            HomeView(),
            BookmarksView(),
            RuangpustakapageView(),
            HistorypeminjamanView(),
            ProfileView(),
          ],
        ),
        bottomNavigationBar: CustomBottomBarMaterial(
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
        ),
      );
    });
  }
}
