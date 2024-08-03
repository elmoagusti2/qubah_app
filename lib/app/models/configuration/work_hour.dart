import 'package:equatable/equatable.dart';

class WorkHour extends Equatable {
  final String? code;
  final String? clockIn;
  final String? clockOut;

  const WorkHour({this.code, this.clockIn, this.clockOut});

  factory WorkHour.fromJson(Map<String, dynamic> json) => WorkHour(
        code: json['code'] as String?,
        clockIn: json['clock_in'] as String?,
        clockOut: json['clock_out'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'code': code,
        'clock_in': clockIn,
        'clock_out': clockOut,
      };

  WorkHour copyWith({
    String? code,
    String? clockIn,
    String? clockOut,
  }) {
    return WorkHour(
      code: code ?? this.code,
      clockIn: clockIn ?? this.clockIn,
      clockOut: clockOut ?? this.clockOut,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [code, clockIn, clockOut];
}
