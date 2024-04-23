import 'package:get/get.dart';

import '../controllers/bookviewer_controller.dart';

class BookviewerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookviewerController>(
      () => BookviewerController(),
    );
  }
}
