import 'package:equatable/equatable.dart';

import 'submission_data.dart';

class RecapSubmission extends Equatable {
  final int? total;
  final int? used;
  final int? balance;
  final List<SubmissionData>? submission;

  const RecapSubmission({
    this.total,
    this.used,
    this.balance,
    this.submission,
  });

  factory RecapSubmission.fromJson(Map<String, dynamic> json) {
    return RecapSubmission(
      total: json['total'] as int?,
      used: json['used'] as int?,
      balance: json['balance'] as int?,
      submission: (json['submission'] as List<dynamic>?)
          ?.map((e) => SubmissionData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'total': total,
        'used': used,
        'balance': balance,
        'submission': submission?.map((e) => e.toJson()).toList(),
      };

  RecapSubmission copyWith({
    int? total,
    int? used,
    int? balance,
    List<SubmissionData>? submission,
  }) {
    return RecapSubmission(
      total: total ?? this.total,
      used: used ?? this.used,
      balance: balance ?? this.balance,
      submission: submission ?? this.submission,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [total, used, balance, submission];
}
