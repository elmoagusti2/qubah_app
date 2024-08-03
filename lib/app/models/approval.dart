import 'package:equatable/equatable.dart';

class Approval extends Equatable {
  final String? id;
  final String? submissionName;
  final String? submissionTypeCode;
  final String? nik;
  final String? name;
  final String? startDate;
  final String? endDate;
  final String? createdAt;
  final String? description;
  final String? day;
  final String? picture;

  const Approval({
    this.id,
    this.submissionName,
    this.submissionTypeCode,
    this.nik,
    this.name,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.description,
    this.day,
    this.picture,
  });

  factory Approval.fromJson(Map<String, dynamic> json) => Approval(
        id: json['id'] as String?,
        submissionName: json['submission_name'] as String?,
        submissionTypeCode: json['submission_type_code'] as String?,
        nik: json['nik'] as String?,
        name: json['name'] as String?,
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as String?,
        createdAt: json['created_at'] as String?,
        description: json['description'] as String?,
        day: json['day'] as String?,
        picture: json['picture'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'submission_name': submissionName,
        'submission_type_code': submissionTypeCode,
        'nik': nik,
        'name': name,
        'start_date': startDate,
        'end_date': endDate,
        'created_at': createdAt,
        'description': description,
        'day': day,
        'picture': picture,
      };

  Approval copyWith({
    String? id,
    String? submissionName,
    String? submissionTypeCode,
    String? nik,
    String? name,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? description,
    String? day,
    String? picture,
  }) {
    return Approval(
      id: id ?? this.id,
      submissionName: submissionName ?? this.submissionName,
      submissionTypeCode: submissionTypeCode ?? this.submissionTypeCode,
      nik: nik ?? this.nik,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      day: day ?? this.day,
      picture: picture ?? this.picture,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      submissionName,
      submissionTypeCode,
      nik,
      name,
      startDate,
      endDate,
      createdAt,
      description,
      day,
      picture,
    ];
  }
}
