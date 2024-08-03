import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/common/common_utils.dart';
import 'package:qubah_app/main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Dialogs {
  static succesMessage({
    required BuildContext context,
    String? message,
  }) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 50,
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 3))),
            ),
            const SizedBox(height: 20),
            Lottie.asset('assets/lottie/success.json',
                repeat: false, height: 80),
            const Text(
              'Success',
              style: TextStyle(
                color: AppColors.successLottie,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              message ?? '',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static errorMessage(
      {required BuildContext context, required String message}) {
    return showModalBottomSheet(
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      ),
      isScrollControlled: true,
      context: context,
      builder: (context) => SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 10),
              width: 50,
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 3))),
            ),
            const SizedBox(height: 20),
            Lottie.asset('assets/lottie/error.json', repeat: false, height: 80),
            const Text(
              'Error occured',
              style: TextStyle(
                color: AppColors.errorLottie,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              message,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 4,
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  static loading({required BuildContext context}) => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const PopScope(
          canPop: false,
          child: Center(
            child: SizedBox(
              width: 50,
              height: 50,
              child: CircularProgressIndicator(
                color: AppColors.main,
              ),
            ),
          ),
        ),
      );

  static confirm(
      {required BuildContext context,
      String? message,
      String? subMessage,
      TextEditingController? desc,
      Function? confirm,
      Function? cancel,
      bool dismiss = true}) {
    final strings = AppLocalizations.of(context)!;
    return showDialog(
      context: context,
      barrierDismissible: dismiss,
      builder: ((context) => AlertDialog(
            surfaceTintColor: Colors.white,
            insetPadding: EdgeInsets.zero,
            actionsPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(32.0))),
            content: SizedBox(
                width: 10,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.fmd_bad,
                      size: 150,
                      color: AppColors.orangeSubmission,
                    ),
                    if (!CommonUtil.falsyChecker(message))
                      Text(
                        textAlign: TextAlign.center,
                        "$message",
                        maxLines: 2,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold),
                      ),
                    if (!CommonUtil.falsyChecker(subMessage))
                      Text(
                        textAlign: TextAlign.center,
                        "$subMessage",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                            fontWeight: FontWeight.bold),
                      ),
                    if (!CommonUtil.falsyChecker(desc))
                      TextFormField(
                        controller: desc,
                        keyboardType: TextInputType.multiline,
                        maxLines: 1,
                        decoration: InputDecoration(
                          labelText: strings.description,
                          hintStyle: const TextStyle(fontSize: 18),
                        ),
                      ),
                    const SizedBox(height: 8),
                    if (!CommonUtil.falsyChecker(confirm))
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: !CommonUtil.falsyChecker(cancel)
                                  ? () => cancel!()
                                  : () => Get.back(),
                              child: Text(strings.cancel,
                                  style: const TextStyle(color: Colors.grey))),
                          ElevatedButton(
                              style: const ButtonStyle(
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors.green30)),
                              onPressed: () => confirm!(),
                              child: Text(
                                strings.confirm,
                                style: const TextStyle(color: Colors.white),
                              )),
                        ],
                      ),
                  ],
                )),
          )),
    );
  }

  static changeLanguange({required BuildContext context}) {
    final getStorage = GetStorage();
    final strings = AppLocalizations.of(context)!;
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        var selected = getStorage.read('lang');
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          surfaceTintColor: Colors.white,
          title: Text(
            strings.chooseLanguange,
            textAlign: TextAlign.center,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                onTap: () {
                  selected = 'id';
                  getStorage.write('lang', 'id').then(
                      (value) => MyApp.setLocale(context, const Locale('id')));
                  Get.back();
                },
                title: const Text('ID - Indonesia'),
                leading: Radio(
                  fillColor: const MaterialStatePropertyAll(AppColors.main),
                  value: "id",
                  groupValue: selected,
                  onChanged: (_) {},
                ),
              ),
              ListTile(
                onTap: () {
                  selected = 'en';
                  getStorage.write('lang', 'en').then(
                      (value) => MyApp.setLocale(context, const Locale('en')));
                  Get.back();
                },
                title: const Text('EN - English'),
                leading: Radio(
                  fillColor: const MaterialStatePropertyAll(AppColors.main),
                  value: "en",
                  groupValue: selected,
                  onChanged: (_) {},
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
