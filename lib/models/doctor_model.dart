class DoctorModel {
  final String id;
  final String name;
  final String specialization;
  final String email;
  final String? phone;
  final double? rating;
  final int? experience;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialization,
    required this.email,
    this.phone,
    this.rating,
    this.experience,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      specialization: json['specialization'],
      email: json['email'],
      phone: json['phone'],
      rating: json['rating']?.toDouble(),
      experience: json['experience'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'specialization': specialization,
      'email': email,
      'phone': phone,
      'rating': rating,
      'experience': experience,
    };
  }
}
