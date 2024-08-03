import 'package:equatable/equatable.dart';

import 'attendance_time.dart';
import 'employee.dart';
import 'work_hour.dart';

class Configuration extends Equatable {
  final Employee? employee;
  final WorkHour? workHour;
  final AttendanceTime? attendanceTime;

  const Configuration({this.employee, this.workHour, this.attendanceTime});

  factory Configuration.fromJson(Map<String, dynamic> json) => Configuration(
        employee: json['employee'] == null
            ? null
            : Employee.fromJson(json['employee'] as Map<String, dynamic>),
        workHour: json['work_hour'] == null
            ? null
            : WorkHour.fromJson(json['work_hour'] as Map<String, dynamic>),
        attendanceTime: json['attendance_time'] == null
            ? null
            : AttendanceTime.fromJson(
                json['attendance_time'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'employee': employee?.toJson(),
        'work_hour': workHour?.toJson(),
        'attendance_time': attendanceTime?.toJson(),
      };

  Configuration copyWith({
    Employee? employee,
    WorkHour? workHour,
    AttendanceTime? attendanceTime,
  }) {
    return Configuration(
      employee: employee ?? this.employee,
      workHour: workHour ?? this.workHour,
      attendanceTime: attendanceTime ?? this.attendanceTime,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [employee, workHour, attendanceTime];
}
