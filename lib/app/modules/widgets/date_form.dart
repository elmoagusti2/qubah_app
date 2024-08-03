import 'package:flutter/material.dart';
import 'package:flutter_date_pickers/flutter_date_pickers.dart';
import 'package:qubah_app/app/common/app_colors.dart';
import 'package:qubah_app/app/modules/widgets/button.dart';

class DateForm extends StatefulWidget {
  const DateForm({
    super.key,
    required this.function,
  });

  final Function function;

  @override
  State<DateForm> createState() => _DateFormState();
}

class _DateFormState extends State<DateForm> {
  DatePeriod _selectedPeriod = DatePeriod(
      DateTime.now().subtract(const Duration(days: 5)), DateTime.now());
  final DateTime _firstDate =
      DateTime.now().subtract(const Duration(days: 3450));
  final DateTime _lastDate = DateTime.now().add(const Duration(days: 345));
  void _onSelectedDateChanged(DatePeriod newPeriod) {
    setState(() {
      _selectedPeriod = newPeriod;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.6,
      child: Container(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 5),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 50,
              decoration: const BoxDecoration(
                  border:
                      Border(bottom: BorderSide(color: Colors.grey, width: 3))),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Center(
                    child: RangePicker(
                      initiallyShowDate: DateTime.now(),
                      selectedPeriod: _selectedPeriod,
                      onChanged: _onSelectedDateChanged,
                      firstDate: _firstDate,
                      lastDate: _lastDate,
                      datePickerLayoutSettings: DatePickerLayoutSettings(
                          scrollPhysics: const NeverScrollableScrollPhysics(),
                          monthPickerPortraitWidth:
                              MediaQuery.of(context).size.width),
                      datePickerStyles: DatePickerRangeStyles(
                          selectedPeriodMiddleDecoration:
                              const BoxDecoration(color: AppColors.blue20),
                          selectedPeriodMiddleTextStyle:
                              const TextStyle(color: AppColors.main),
                          selectedDateStyle:
                              const TextStyle(color: AppColors.white)),
                    ),
                  ),
                  AppButton.general(
                      title: 'Apply',
                      onTap: () => widget.function(
                          _selectedPeriod.start, _selectedPeriod.end))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
