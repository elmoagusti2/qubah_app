import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:latlong2/latlong.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/app/common/text_style.dart';
import 'package:qubah_app/app/models/attendance.dart';
import 'package:qubah_app/app/modules/approval/views/approval_view.dart';
import 'package:widget_zoom/widget_zoom.dart';
import '../controllers/attendance_detail_controller.dart';

class AttendanceDetailView extends GetView<AttendanceDetailController> {
  AttendanceDetailView({super.key});
  final Attendance data = Get.arguments as Attendance;
  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const Border(
          bottom: BorderSide(width: 1.0, color: AppColors.baseGrey),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
        title: AppText.textWidget14(
            text: 'Detail ${strings.attendance}', color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.baseGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppText.textWidgetBold14(text: data.date ?? '-'),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppText.textWidget14(text: strings.totalHrs),
                      AppText.textWidget12(
                          text: !CommonUtil.falsyChecker(data.totalHours)
                              ? data.totalHours!
                              : '-'),
                    ],
                  )
                ],
              ),
            ),
            const Divider(color: AppColors.baseGrey, thickness: 10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on_outlined),
                      const SizedBox(width: 4),
                      AppText.textWidgetBold14(text: strings.location)
                    ],
                  ),
                  const SizedBox(height: 10),
                  GeneralField(
                      title: strings.clockIn, subTitle: '${data.checkIn}'),
                  const SizedBox(height: 10),
                  GeneralField(
                      title: strings.address, subTitle: '${data.addressIn}'),
                  const SizedBox(height: 10),
                  if (!CommonUtil.falsyChecker(data.latIn))
                    SizedBox(
                      width: double.maxFinite,
                      height: 250,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(double.parse(data.latIn!),
                              double.parse(data.longIn!)),
                          initialZoom: 16,
                          initialRotation: 0,
                        ),
                        children: [
                          TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                          MarkerLayer(
                            markers: [
                              Marker(
                                  point: LatLng(double.parse(data.latIn!),
                                      double.parse(data.longIn!)),
                                  child: const Icon(Icons.location_on,
                                      color: Colors.red, size: 30)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  const SizedBox(height: 30),
                  ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(100)),
                    child: WidgetZoom(
                      heroAnimationTag: 'tag',
                      zoomWidget: Image.network(
                        data.pictureIn ?? '',
                        fit: BoxFit.cover,
                        width: 120,
                        height: 120,
                        errorBuilder: (context, error, stackTrace) => Container(
                          decoration:
                              const BoxDecoration(color: AppColors.red10),
                          height: 120,
                          width: 120,
                          child: const Icon(
                            Icons.error_outline_rounded,
                            size: 40,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(color: AppColors.baseGrey, thickness: 10),
            if (!CommonUtil.falsyChecker(data.checkOut))
              Container(
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined),
                        const SizedBox(width: 4),
                        AppText.textWidgetBold14(text: strings.location)
                      ],
                    ),
                    const SizedBox(height: 10),
                    GeneralField(
                        title: strings.clockOut, subTitle: '${data.checkOut}'),
                    const SizedBox(height: 10),
                    GeneralField(
                        title: strings.address, subTitle: '${data.addressOut}'),
                    const SizedBox(height: 10),
                    if (!CommonUtil.falsyChecker(data.latOut))
                      SizedBox(
                        width: double.maxFinite,
                        height: 250,
                        child: FlutterMap(
                          options: MapOptions(
                            initialCenter: LatLng(double.parse(data.latOut!),
                                double.parse(data.longOut!)),
                            initialZoom: 16,
                            initialRotation: 0,
                          ),
                          children: [
                            TileLayer(
                                urlTemplate:
                                    'https://tile.openstreetmap.org/{z}/{x}/{y}.png'),
                            MarkerLayer(
                              markers: [
                                Marker(
                                    point: LatLng(double.parse(data.latOut!),
                                        double.parse(data.longOut!)),
                                    child: const Icon(Icons.location_on,
                                        color: Colors.red, size: 30)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    const SizedBox(height: 30),
                    ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      child: WidgetZoom(
                        heroAnimationTag: 'tag',
                        zoomWidget: Image.network(
                          data.pictureOut ?? '',
                          fit: BoxFit.cover,
                          width: 120,
                          height: 120,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            decoration:
                                const BoxDecoration(color: AppColors.red10),
                            height: 120,
                            width: 120,
                            child: const Icon(
                              Icons.error_outline_rounded,
                              size: 40,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
