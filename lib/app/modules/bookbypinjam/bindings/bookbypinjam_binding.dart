import 'package:get/get.dart';

import '../controllers/bookbypinjam_controller.dart';

class BookbypinjamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookbypinjamController>(
      () => BookbypinjamController(),
    );
  }
}
