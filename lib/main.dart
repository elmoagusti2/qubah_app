import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/http_override.dart';

import 'app/routes/app_pages.dart';

List<CameraDescription> cameras = [];
void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: AppColors.mainScheme,
    ),
  );
}
