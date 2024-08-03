import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String? id;
  final String? code;
  final String? nik;
  final String? name;
  final String? company;
  final String? position;
  final String? employeeStatus;
  final String? joinDate;
  final String? photo;
  final String? isSupervisor;

  const Employee({
    this.id,
    this.code,
    this.nik,
    this.name,
    this.company,
    this.position,
    this.employeeStatus,
    this.joinDate,
    this.photo,
    this.isSupervisor,
  });

  factory Employee.fromJson(Map<String, dynamic> json) => Employee(
        id: json['id'] as String?,
        code: json['code'] as String?,
        nik: json['nik'] as String?,
        name: json['name'] as String?,
        company: json['company'] as String?,
        position: json['position'] as String?,
        employeeStatus: json['employee_status'] as String?,
        joinDate: json['join_date'] as String?,
        photo: json['photo'] as String?,
        isSupervisor: json['is_supervisor'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'nik': nik,
        'name': name,
        'company': company,
        'position': position,
        'employee_status': employeeStatus,
        'join_date': joinDate,
        'photo': photo,
        'is_supervisor': isSupervisor,
      };

  Employee copyWith({
    String? id,
    String? code,
    String? nik,
    String? name,
    String? company,
    String? position,
    String? employeeStatus,
    String? joinDate,
    String? photo,
    String? isSupervisor,
  }) {
    return Employee(
      id: id ?? this.id,
      code: code ?? this.code,
      nik: nik ?? this.nik,
      name: name ?? this.name,
      company: company ?? this.company,
      position: position ?? this.position,
      employeeStatus: employeeStatus ?? this.employeeStatus,
      joinDate: joinDate ?? this.joinDate,
      photo: photo ?? this.photo,
      isSupervisor: isSupervisor ?? this.isSupervisor,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      code,
      nik,
      name,
      company,
      position,
      employeeStatus,
      joinDate,
      photo,
      isSupervisor,
    ];
  }
}
