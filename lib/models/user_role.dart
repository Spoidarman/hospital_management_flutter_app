enum UserRole {
  patient,
  doctor;

  String get value {
    switch (this) {
      case UserRole.patient:
        return 'patient';
      case UserRole.doctor:
        return 'doctor';
    }
  }

  static UserRole fromString(String role) {
    switch (role.toLowerCase()) {
      case 'patient':
        return UserRole.patient;
      case 'doctor':
        return UserRole.doctor;
      default:
        throw Exception('Unknown role: $role');
    }
  }
}
