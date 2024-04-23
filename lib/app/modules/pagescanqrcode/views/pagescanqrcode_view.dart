import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pagescanqrcode_controller.dart';

class PagescanqrcodeView extends GetView<PagescanqrcodeController> {
  const PagescanqrcodeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PagescanqrcodeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PagescanqrcodeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
