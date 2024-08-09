import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:local_auth/local_auth.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/app/domain/repositories/api_client.dart';
import 'package:qubah_app/app/modules/dashboard/controllers/dashboard_controller.dart';
import 'package:qubah_app/app/modules/widgets/alert.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:dio/dio.dart' as d;
import 'package:qubah_app/app/modules/widgets/dialogs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CameraAttendanceController extends GetxController {
  final ApiClient apiClient = ApiClient();
  Position? position;
  final address = TextEditingController();
  final addressDetail = ''.obs;
  final requestLocation = RequestState.empty.obs;
  XFile? image;
  final isTakePhoto = false.obs;
  String statusId = Get.arguments;
  final FaceDetector _faceDetector = FaceDetector(
    options: FaceDetectorOptions(
      enableContours: true,
      enableLandmarks: true,
      performanceMode: FaceDetectorMode.accurate,
    ),
  );
  final strings = AppLocalizations.of(Get.context!)!;
  final _localAuth = LocalAuthentication();

  @override
  void onInit() async {
    await doInitLocation();
    super.onInit();
  }

  doInitLocation() async {
    requestLocation.value = RequestState.loading;
    try {
      var detPosition =
          await determinePosition().timeout(const Duration(seconds: 10));
      if (!detPosition['error']) {
        position = detPosition['position'];
        List<Placemark> placemarks = await placemarkFromCoordinates(
            position!.latitude, position!.longitude);
        address.text = '${placemarks[0].thoroughfare}';
        addressDetail.value =
            '${placemarks[0].street}, ${placemarks[0].subLocality}, ${placemarks[0].locality}, ${placemarks[0].subAdministrativeArea}, ${placemarks[0].administrativeArea} ${placemarks[0].postalCode}';
        requestLocation.value = RequestState.success;
      } else {
        requestLocation.value = RequestState.error;
        AppAlert.error(context: Get.context!, message: detPosition['message']);
      }
    } catch (e) {
      requestLocation.value = RequestState.error;
    }
  }

  Future<Map<String, dynamic>> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return {
        'message': "Nyalakan GPS device anda.",
        'error': true,
      };
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return {
          'message': "Izin Menggunakan GPS ditolak",
          'error': true,
        };
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return {
        'message':
            "Silahkan Buka Setting Aplikasi, dan perbolehkan akses lokasi untuk aplikasi. ",
        'error': true,
      };
    }
    Position position = await Geolocator.getCurrentPosition();
    return {
      'position': position,
      'message': "Berhasil Mendapatkan posisi device",
      'error': false,
    };
  }

  Future takePicture(CameraController? cameraController) async {
    final CameraController? cameraCont = cameraController;
    if (cameraCont!.value.isTakingPicture) {
      return null;
    }
    image = await cameraCont.takePicture();
    cameraController?.pausePreview();
    final imageTemporary = XFile(image!.path);
    image = imageTemporary;
    final filePath = image!.path;

    final lastIndex = filePath.lastIndexOf(RegExp(r'.jp'));
    final splitted = filePath.substring(0, (lastIndex));
    final outPath = "${splitted}_out${filePath.substring(lastIndex)}";
    final resizedImage = await FlutterImageCompress.compressAndGetFile(
        filePath, outPath,
        quality: 50, minHeight: 600, minWidth: 800);
    image = resizedImage;
    isTakePhoto.value = true;
  }

  doSubmit() async {
    Dialogs.loading(context: Get.context!);
    if (!CommonUtil.falsyChecker(image?.path) &&
        !CommonUtil.falsyChecker(position?.latitude) &&
        !CommonUtil.falsyChecker(addressDetail.value) &&
        !CommonUtil.falsyChecker(address.text)) {
      d.FormData formData = d.FormData.fromMap({
        "picture": await d.MultipartFile.fromFile(image!.path),
        "lat": "${position?.latitude}",
        "long": "${position?.longitude}",
        "address": addressDetail.value,
        "status_id": statusId,
        "description": address.text
      });
      final (ResponseStatus status, res) =
          await apiClient.post(url: 'attendance', data: formData);
      if (status == ResponseStatus.success) {
        if (res['status']) {
          final dash = Get.find<DashboardController>();
          if (statusId == 'AS01') {
            dash.clockIn.value = res['data']['time'];
          } else {
            dash.clockOut.value = res['data']['time'];
          }
          dash.totalHrs.value = res['data']['total_hours'];
          dash.update();
          Get.back();
          Get.back();
          AppAlert.success(
              context: Get.context!,
              message: res['message'] ?? 'Successfully attendance');
        } else {
          Get.back();
          AppAlert.error(
              context: Get.context!,
              message: res['message'] ?? 'Error occurred');
        }
      }
      if (status == ResponseStatus.errorResponse ||
          status == ResponseStatus.error) {
        Get.back();
        AppAlert.error(
            context: Get.context!, message: res['message'] ?? 'Error occurred');
      }
    } else {
      Get.back();
      AppAlert.error(context: Get.context!, message: 'Please fill field');
    }
  }

  doCheckRequirement() async {
    Future.delayed(Duration.zero, () => Dialogs.loading(context: Get.context!));
    if (CommonUtil.falsyChecker(image?.path)) {
      await Future.delayed(const Duration(seconds: 1), () => Get.back());
      AppAlert.error(context: Get.context!, message: strings.takeImage);
    } else if (CommonUtil.falsyChecker(position?.latitude) &&
            CommonUtil.falsyChecker(addressDetail.value) ||
        address.text.isEmpty) {
      await Future.delayed(const Duration(seconds: 1), () => Get.back());
      AppAlert.error(context: Get.context!, message: strings.addressNotFound);
    } else {
      final inputImage = InputImage.fromFilePath(image!.path);
      final faces = await _faceDetector.processImage(inputImage);
      Get.back();
      faces.isNotEmpty
          ? doCheckFingerBiometric()
          : AppAlert.error(
              context: Get.context!, message: strings.pleaseTakeface);
    }
  }

  doCheckFingerBiometric() async {
    try {
      final isUserAuthenticated = await _localAuth.authenticate(
          localizedReason: 'Authenticate Yourself',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
            biometricOnly: true,
          ));
      if (isUserAuthenticated) {
        doSubmit();
      } else {}
    } on PlatformException catch (e) {
      //if device not support
      if (kDebugMode) {
        print('$e');
      }
      doSubmit();
    }
  }
}
