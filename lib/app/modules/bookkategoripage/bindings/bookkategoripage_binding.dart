import 'package:get/get.dart';

import '../controllers/bookkategoripage_controller.dart';

class BookkategoripageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookkategoripageController>(
      () => BookkategoripageController(),
    );
  }
}
