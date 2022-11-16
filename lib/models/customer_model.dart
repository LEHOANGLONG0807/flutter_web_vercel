import 'package:app_visitor/common/common.dart';

class CustomerModel {
  final DateTime dateIn;
  final String firstName;
  final String lastName;
  final String company;
  final String purpose;
  final String initialsName;
  String? urlAvatar;
  final DateTime timeIn;
  final String customerId;
  DateTime? timeOut;
  String urlPdf;
  int id;

  CustomerModel({
    required this.dateIn,
    required this.firstName,
    required this.lastName,
    required this.company,
    required this.purpose,
    required this.initialsName,
    required this.timeIn,
    this.urlAvatar,
    required this.customerId,
    this.timeOut,
    this.id = -1,
    this.urlPdf = '',
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
    firstName: json["first_name"] ?? '',
    lastName: json["last_name"] ?? '',
    company: json["company"] ?? '',
    purpose: json["purpose"] ?? '',
    customerId: json["customer_id"] ?? 'HTH-',
    urlAvatar: json["avatar"] ?? '',
    initialsName: json["initials_name"] ?? '-',
    urlPdf: json["url_file_printing"] ?? '',
    dateIn: utcStringToLocal(json["time_in"]) ?? DateTime.now(),
    timeIn: utcStringToLocal(json["time_in"]) ?? DateTime.now(),
    timeOut: utcStringToLocal(json["time_out"]),
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "company": company,
    "purpose": purpose,
    "url_avatar": urlAvatar,
    "customer_id": customerId,
    "date_in": dateIn.toUtc().formatDateddMMyyyy,
    "initials_name": initialsName,
    "time_in": localDateTimeToUTCString(timeIn),
    "time_out": localDateTimeToUTCString(timeOut),
    "url_pdf": urlPdf,
  };

  String get displayName => firstName + ' ' + lastName;

  static DateTime? utcStringToLocal(String? input) {
    if (input == null || input.isEmpty) return null;
    String time=input;
    if(!input.contains('Z')){
      time+='Z';
    }
    return DateTime.tryParse(time)?.toLocal();
  }

  static String? localDateTimeToUTCString(DateTime? input) {
    return input?.toUtc().toIso8601String();
  }
}
