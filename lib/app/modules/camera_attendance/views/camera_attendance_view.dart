import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/enum.dart';
import 'package:qubah_app/main.dart';

import '../controllers/camera_attendance_controller.dart';

class CameraAttendanceView extends StatefulWidget {
  const CameraAttendanceView({super.key});

  @override
  State<CameraAttendanceView> createState() => _CameraAttendanceViewState();
}

class _CameraAttendanceViewState extends State<CameraAttendanceView>
    with WidgetsBindingObserver {
  final controller = Get.put(CameraAttendanceController());
  CameraController? cameraController;
  bool _isCameraInitialized = false;
  XFile? image;

  void onNewCameraSelected() async {
    final previousCameraController = cameraController;
    final CameraController camCom =
        CameraController(cameras[1], ResolutionPreset.high);
    await previousCameraController?.dispose();
    if (mounted) {
      setState(() {
        cameraController = camCom;
      });
    }

    camCom.addListener(() {
      if (mounted) setState(() {});
    });

    try {
      await camCom.initialize();
    } on CameraException catch (_) {
      // print('Error initializing camera: $e');
    }

    if (mounted) {
      setState(() {
        _isCameraInitialized = cameraController!.value.isInitialized;
      });
    }
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode;
    onNewCameraSelected();
    super.initState();
  }

  @override
  void dispose() {
    cameraController?.dispose();
    Get.delete<CameraAttendanceController>();

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraCont = cameraController;
    if (cameraCont == null || !cameraCont.value.isInitialized) {
      return;
    }

    if (state == AppLifecycleState.inactive) {
      cameraCont.dispose();
    } else if (state == AppLifecycleState.resumed) {
      onNewCameraSelected();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isCameraInitialized
          ? Stack(
              children: [
                Container(
                    color: Colors.black,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height),
                Transform.scale(
                  scale: 1 /
                      (cameraController!.value.aspectRatio *
                          MediaQuery.of(context).size.aspectRatio),
                  alignment: Alignment.topCenter,
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CameraPreview(cameraController!)),
                ),
                ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(0.5),
                    BlendMode.srcOut,
                  ),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          backgroundBlendMode: BlendMode.dstOut,
                        ),
                      ),
                      Align(
                        alignment: const Alignment(0, -0.3),
                        child: Container(
                          width: 320,
                          height: 370,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.all(
                              Radius.elliptical(
                                300,
                                350,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                locationWidget(context),
                buttonTakePicture(),
                buttonRetake(),
                buttonAttendance(),
              ],
            )
          : Container(),
    );
  }

  Align locationWidget(BuildContext context) {
    return Align(
        alignment: const Alignment(0, 0.7),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          // height: 80,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5), color: Colors.white),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Lokasi saat ini',
                style: TextStyle(color: AppColors.main),
              ),
              Container(
                margin: const EdgeInsets.only(top: 6),
                padding: const EdgeInsets.only(top: 6),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 0.5, color: Colors.grey),
                  ),
                ),
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                            child: TextField(
                          controller: controller.address,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                            isDense: true,
                          ),
                          style: const TextStyle(color: Colors.grey),
                        )),
                        Container(
                          margin: const EdgeInsets.only(left: 10, right: 5),
                          height: 20,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (controller.requestLocation.value ==
                                  RequestState.error)
                                buttonTryAgain(),
                              const SizedBox(width: 2),
                              AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 300),
                                  transitionBuilder: (child, animation) =>
                                      ScaleTransition(
                                        scale: animation,
                                        child: child,
                                      ),
                                  child: controller.requestLocation.value ==
                                          RequestState.success
                                      ? Container(
                                          key: const ValueKey<int>(0),
                                          child: const Center(
                                              child: Icon(
                                            Icons.place,
                                            size: 20,
                                            color: Colors.green,
                                          )))
                                      : controller.requestLocation.value ==
                                              RequestState.loading
                                          ? const SizedBox(
                                              width: 15,
                                              height: 15,
                                              key: ValueKey<int>(1),
                                              child: CircularProgressIndicator(
                                                  strokeWidth: 2))
                                          : Container(
                                              key: const ValueKey<int>(0),
                                              child: const Icon(
                                                Icons.place,
                                                size: 20,
                                                color: Colors.red,
                                              ))),
                            ],
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ));
  }

  Align buttonAttendance() {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () async {
          await controller.doCheckRequirement();
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.circle, color: Colors.white, size: 50),
              Icon(Icons.done_all, color: AppColors.main, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  Align buttonRetake() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: InkWell(
        onTap: () async {
          controller.isTakePhoto.value = false;
          cameraController!.resumePreview();
        },
        onLongPress: () {},
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(Icons.circle, color: Colors.white, size: 50),
              Icon(Icons.replay, color: AppColors.main, size: 30),
            ],
          ),
        ),
      ),
    );
  }

  Align buttonTakePicture() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Obx(() => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) => ScaleTransition(
                scale: animation,
                child: child,
              ),
          child: controller.isTakePhoto.value
              ? const SizedBox.shrink()
              : Container(
                  key: const ValueKey<int>(1),
                  child: InkWell(
                    onTap: () async {
                      await controller.takePicture(cameraController);

                      cameraController!.pausePreview();
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.circle, color: Colors.white, size: 80),
                          Icon(Icons.circle, color: AppColors.main, size: 65),
                        ],
                      ),
                    ),
                  ),
                ))),
    );
  }

  SizedBox buttonTryAgain() {
    return SizedBox(
      height: 20,
      child: ElevatedButton(
        onPressed: () => controller.doInitLocation(),
        style: ButtonStyle(
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 10)),
          surfaceTintColor: const MaterialStatePropertyAll(Colors.red),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              return Colors.white;
            },
          ),
        ),
        child: const Text(
          'Search again',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
