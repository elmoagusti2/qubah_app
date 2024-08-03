import 'package:equatable/equatable.dart';

class Submission extends Equatable {
  final String? id;
  final String? submissionName;
  final String? submissionTypeCode;
  final String? nik;
  final String? startDate;
  final String? endDate;
  final String? createdAt;
  final String? description;
  final String? day;
  final String? status;
  final String? picture;

  const Submission({
    this.id,
    this.submissionName,
    this.submissionTypeCode,
    this.nik,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.description,
    this.day,
    this.status,
    this.picture,
  });

  factory Submission.fromJson(Map<String, dynamic> json) => Submission(
        id: json['id'] as String?,
        submissionName: json['submission_name'] as String?,
        submissionTypeCode: json['submission_type_code'] as String?,
        nik: json['nik'] as String?,
        startDate: json['start_date'] as String?,
        endDate: json['end_date'] as String?,
        createdAt: json['created_at'] as String?,
        description: json['description'] as String?,
        day: json['day'] as String?,
        status: json['status'] as String?,
        picture: json['picture'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'submission_name': submissionName,
        'submission_type_code': submissionTypeCode,
        'nik': nik,
        'start_date': startDate,
        'end_date': endDate,
        'created_at': createdAt,
        'description': description,
        'day': day,
        'status': status,
        'picture': picture,
      };

  Submission copyWith({
    String? id,
    String? submissionName,
    String? submissionTypeCode,
    String? nik,
    String? startDate,
    String? endDate,
    String? createdAt,
    String? description,
    String? day,
    String? status,
    String? picture,
  }) {
    return Submission(
      id: id ?? this.id,
      submissionName: submissionName ?? this.submissionName,
      submissionTypeCode: submissionTypeCode ?? this.submissionTypeCode,
      nik: nik ?? this.nik,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      day: day ?? this.day,
      status: status ?? this.status,
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
      startDate,
      endDate,
      createdAt,
      description,
      day,
      status,
      picture,
    ];
  }
}
