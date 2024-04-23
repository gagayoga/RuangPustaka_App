import 'package:get/get.dart';

import '../controllers/pagescanqrcode_controller.dart';

class PagescanqrcodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PagescanqrcodeController>(
      () => PagescanqrcodeController(),
    );
  }
}
