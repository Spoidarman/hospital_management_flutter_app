class AppointmentModel {
  final String id;
  final String patientId;
  final String patientName;
  final String doctorId;
  final String doctorName;
  final DateTime dateTime;
  final String status; // pending, confirmed, completed, cancelled
  final String? symptoms;
  final String? diagnosis;

  AppointmentModel({
    required this.id,
    required this.patientId,
    required this.patientName,
    required this.doctorId,
    required this.doctorName,
    required this.dateTime,
    required this.status,
    this.symptoms,
    this.diagnosis,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['_id'] ?? json['id'],
      patientId: json['patientId'],
      patientName: json['patientName'],
      doctorId: json['doctorId'],
      doctorName: json['doctorName'],
      dateTime: DateTime.parse(json['dateTime']),
      status: json['status'],
      symptoms: json['symptoms'],
      diagnosis: json['diagnosis'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'patientName': patientName,
      'doctorId': doctorId,
      'doctorName': doctorName,
      'dateTime': dateTime.toIso8601String(),
      'status': status,
      'symptoms': symptoms,
      'diagnosis': diagnosis,
    };
  }
}
