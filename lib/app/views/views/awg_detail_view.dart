import 'package:flutter/material.dart';

import 'package:get/get.dart';

class AwgDetailView extends GetView {
  const AwgDetailView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AwgDetailView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AwgDetailView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
