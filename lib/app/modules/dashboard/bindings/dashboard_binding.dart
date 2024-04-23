import 'package:get/get.dart';
import 'package:ruangpustaka/app/modules/bookbypinjam/controllers/bookbypinjam_controller.dart';
import 'package:ruangpustaka/app/modules/bookbypinjam/views/bookbypinjam_view.dart';
import 'package:ruangpustaka/app/modules/buktipeminjaman/controllers/buktipeminjaman_controller.dart';
import 'package:ruangpustaka/app/modules/menu/bookmarks/controllers/bookmarks_controller.dart';
import 'package:ruangpustaka/app/modules/menu/historypeminjaman/controllers/historypeminjaman_controller.dart';
import 'package:ruangpustaka/app/modules/menu/home/controllers/home_controller.dart';
import 'package:ruangpustaka/app/modules/menu/profile/controllers/profile_controller.dart';
import 'package:ruangpustaka/app/modules/menu/ruangpustakapage/controllers/ruangpustakapage_controller.dart';

import '../controllers/dashboard_controller.dart';

class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(
      () => DashboardController(),
    );

    Get.lazyPut<HomeController>(
          () => HomeController(),
    );

    Get.lazyPut<BookmarksController>(
          () => BookmarksController(),
    );

    Get.lazyPut<RuangpustakapageController>(
          () => RuangpustakapageController(),
    );

    Get.lazyPut<HistorypeminjamanController>(
          () => HistorypeminjamanController(),
    );

    Get.lazyPut<ProfileController>(
          () => ProfileController(),
    );
  }
}
