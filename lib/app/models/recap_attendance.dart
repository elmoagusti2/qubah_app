import 'package:equatable/equatable.dart';

class RecapAttendance extends Equatable {
  final String? absent;
  final String? totalAttendance;
  final String? late;
  final String? totalSubmission;

  const RecapAttendance({
    this.absent,
    this.totalAttendance,
    this.late,
    this.totalSubmission,
  });

  factory RecapAttendance.fromJson(Map<String, dynamic> json) {
    return RecapAttendance(
      absent: json['absent'] as String?,
      totalAttendance: json['total_attendance'] as String?,
      late: json['late'] as String?,
      totalSubmission: json['total_submission'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'absent': absent,
        'total_attendance': totalAttendance,
        'late': late,
        'total_submission': totalSubmission,
      };

  RecapAttendance copyWith({
    String? absent,
    String? totalAttendance,
    String? late,
    String? totalSubmission,
  }) {
    return RecapAttendance(
      absent: absent ?? this.absent,
      totalAttendance: totalAttendance ?? this.totalAttendance,
      late: late ?? this.late,
      totalSubmission: totalSubmission ?? this.totalSubmission,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      absent,
      totalAttendance,
      late,
      totalSubmission,
    ];
  }
}
