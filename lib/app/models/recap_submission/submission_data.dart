import 'package:equatable/equatable.dart';

class SubmissionData extends Equatable {
  final String? submissionTypeCode;
  final String? submissionTypeName;
  final int? submissionMax;
  final int? used;
  final double? result;

  const SubmissionData({
    this.submissionTypeCode,
    this.submissionTypeName,
    this.submissionMax,
    this.used,
    this.result,
  });

  factory SubmissionData.fromJson(Map<String, dynamic> json) => SubmissionData(
        submissionTypeCode: json['submission_type_code'] as String?,
        submissionTypeName: json['submission_type_name'] as String?,
        submissionMax: json['submission_max'] as int?,
        used: json['used'] as int?,
        result: (json['result'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'submission_type_code': submissionTypeCode,
        'submission_type_name': submissionTypeName,
        'submission_max': submissionMax,
        'used': used,
        'result': result,
      };

  SubmissionData copyWith({
    String? submissionTypeCode,
    String? submissionTypeName,
    int? submissionMax,
    int? used,
    double? result,
  }) {
    return SubmissionData(
      submissionTypeCode: submissionTypeCode ?? this.submissionTypeCode,
      submissionTypeName: submissionTypeName ?? this.submissionTypeName,
      submissionMax: submissionMax ?? this.submissionMax,
      used: used ?? this.used,
      result: result ?? this.result,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      submissionTypeCode,
      submissionTypeName,
      submissionMax,
      used,
      result,
    ];
  }
}
