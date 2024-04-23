import 'package:get/get.dart';

import '../controllers/ruangpustakapage_controller.dart';

class RuangpustakapageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RuangpustakapageController>(
      () => RuangpustakapageController(),
    );
  }
}
