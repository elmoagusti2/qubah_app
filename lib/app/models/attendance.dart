import 'package:equatable/equatable.dart';

class Attendance extends Equatable {
  final String? date;
  final String? dateFormat;
  final String? dayName;
  final String? checkIn;
  final String? latIn;
  final String? longIn;
  final String? addressIn;
  final String? pictureIn;
  final String? descIn;
  final String? checkOut;
  final String? latOut;
  final String? longOut;
  final String? addressOut;
  final String? pictureOut;
  final String? descOut;
  final String? totalHours;

  const Attendance({
    this.date,
    this.dateFormat,
    this.dayName,
    this.checkIn,
    this.latIn,
    this.longIn,
    this.addressIn,
    this.pictureIn,
    this.descIn,
    this.checkOut,
    this.latOut,
    this.longOut,
    this.addressOut,
    this.pictureOut,
    this.descOut,
    this.totalHours,
  });

  factory Attendance.fromJson(Map<String, dynamic> json) => Attendance(
        date: json['date'] as String?,
        dateFormat: json['date_format'] as String?,
        dayName: json['day_name'] as String?,
        checkIn: json['check_in'] as String?,
        latIn: json['lat_in'] as String?,
        longIn: json['long_in'] as String?,
        addressIn: json['address_in'] as String?,
        pictureIn: json['picture_in'] as String?,
        descIn: json['desc_in'] as String?,
        checkOut: json['check_out'] as String?,
        latOut: json['lat_out'] as String?,
        longOut: json['long_out'] as String?,
        addressOut: json['address_out'] as String?,
        pictureOut: json['picture_out'] as String?,
        descOut: json['desc_out'] as String?,
        totalHours: json['total_hours'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'date': date,
        'date_format': dateFormat,
        'day_name': dayName,
        'check_in': checkIn,
        'lat_in': latIn,
        'long_in': longIn,
        'address_in': addressIn,
        'picture_in': pictureIn,
        'desc_in': descIn,
        'check_out': checkOut,
        'lat_out': latOut,
        'long_out': longOut,
        'address_out': addressOut,
        'picture_out': pictureOut,
        'desc_out': descOut,
        'total_hours': totalHours,
      };

  Attendance copyWith({
    String? date,
    String? dateFormat,
    String? dayName,
    String? checkIn,
    String? latIn,
    String? longIn,
    String? addressIn,
    String? pictureIn,
    String? descIn,
    String? checkOut,
    String? latOut,
    String? longOut,
    String? addressOut,
    String? pictureOut,
    String? descOut,
    String? totalHours,
  }) {
    return Attendance(
      date: date ?? this.date,
      dateFormat: dateFormat ?? this.dateFormat,
      dayName: dayName ?? this.dayName,
      checkIn: checkIn ?? this.checkIn,
      latIn: latIn ?? this.latIn,
      longIn: longIn ?? this.longIn,
      addressIn: addressIn ?? this.addressIn,
      pictureIn: pictureIn ?? this.pictureIn,
      descIn: descIn ?? this.descIn,
      checkOut: checkOut ?? this.checkOut,
      latOut: latOut ?? this.latOut,
      longOut: longOut ?? this.longOut,
      addressOut: addressOut ?? this.addressOut,
      pictureOut: pictureOut ?? this.pictureOut,
      descOut: descOut ?? this.descOut,
      totalHours: totalHours ?? this.totalHours,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      date,
      dateFormat,
      dayName,
      checkIn,
      latIn,
      longIn,
      addressIn,
      pictureIn,
      descIn,
      checkOut,
      latOut,
      longOut,
      addressOut,
      pictureOut,
      descOut,
      totalHours,
    ];
  }
}
