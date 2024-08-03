import 'package:equatable/equatable.dart';

class SubmissionType extends Equatable {
  final String? id;
  final String? code;
  final String? name;
  final String? isPicture;
  const SubmissionType({this.id, this.code, this.name, this.isPicture});

  factory SubmissionType.fromJson(Map<String, dynamic> json) {
    return SubmissionType(
      id: json['id'] as String?,
      code: json['code'] as String?,
      name: json['name'] as String?,
      isPicture: json['is_picture'] as String?,
    );
  }

  Map<String, dynamic> toJson() =>
      {'id': id, 'code': code, 'name': name, 'is_picture': isPicture};

  SubmissionType copyWith({
    String? id,
    String? code,
    String? name,
    String? isPicture,
  }) {
    return SubmissionType(
        id: id ?? this.id,
        code: code ?? this.code,
        name: name ?? this.name,
        isPicture: isPicture ?? this.isPicture);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, code, name, isPicture];
}
