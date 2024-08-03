import 'package:equatable/equatable.dart';

class Users extends Equatable {
  final String? id;
  final String? code;
  final String? employeeNik;
  final String? name;
  final String? company;
  final String? position;
  final String? employeeStatus;
  final String? joinDate;
  final String? photo;
  final String? token;

  const Users({
    this.id,
    this.code,
    this.employeeNik,
    this.name,
    this.company,
    this.position,
    this.employeeStatus,
    this.joinDate,
    this.photo,
    this.token,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        id: json['id'] as String?,
        code: json['code'] as String?,
        employeeNik: json['employee_nik'] as String?,
        name: json['name'] as String?,
        company: json['company'] as String?,
        position: json['position'] as String?,
        employeeStatus: json['employee_status'] as String?,
        joinDate: json['join_date'] as String?,
        photo: json['photo'] as String?,
        token: json['token'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'code': code,
        'employee_nik': employeeNik,
        'name': name,
        'company': company,
        'position': position,
        'employee_status': employeeStatus,
        'join_date': joinDate,
        'photo': photo,
        'token': token,
      };

  Users copyWith({
    String? id,
    String? code,
    String? employeeNik,
    String? name,
    String? company,
    String? position,
    String? employeeStatus,
    String? joinDate,
    String? photo,
    String? token,
  }) {
    return Users(
      id: id ?? this.id,
      code: code ?? this.code,
      employeeNik: employeeNik ?? this.employeeNik,
      name: name ?? this.name,
      company: company ?? this.company,
      position: position ?? this.position,
      employeeStatus: employeeStatus ?? this.employeeStatus,
      joinDate: joinDate ?? this.joinDate,
      photo: photo ?? this.photo,
      token: token ?? this.token,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      code,
      employeeNik,
      name,
      company,
      position,
      employeeStatus,
      joinDate,
      photo,
      token,
    ];
  }
}
