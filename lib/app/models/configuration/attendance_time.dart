import 'package:equatable/equatable.dart';

class AttendanceTime extends Equatable {
  final String? checkIn;
  final String? checkOut;
  final String? totalHours;

  const AttendanceTime({this.checkIn, this.checkOut, this.totalHours});

  factory AttendanceTime.fromJson(Map<String, dynamic> json) {
    return AttendanceTime(
      checkIn: json['check_in'] as String?,
      checkOut: json['check_out'] as String?,
      totalHours: json['total_hours'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'check_in': checkIn,
        'check_out': checkOut,
        'total_hours': totalHours,
      };

  AttendanceTime copyWith({
    String? checkIn,
    String? checkOut,
    String? totalHours,
  }) {
    return AttendanceTime(
      checkIn: checkIn ?? this.checkIn,
      checkOut: checkOut ?? this.checkOut,
      totalHours: totalHours ?? this.totalHours,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [checkIn, checkOut, totalHours];
}
