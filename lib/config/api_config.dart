class ApiConfig {
  // Change this to your Node.js backend URL
  static const String baseUrl = 'http://localhost:3000/api';

  // Auth endpoints
  static const String login = '$baseUrl/auth/login';
  static const String register = '$baseUrl/auth/register';

  // Patient endpoints
  static const String appointments = '$baseUrl/appointments';
  static const String bookAppointment = '$baseUrl/appointments/book';

  // Doctor endpoints
  static const String doctors = '$baseUrl/doctors';
  static const String doctorAppointments = '$baseUrl/doctors/appointments';

  // Headers
  static Map<String, String> getHeaders({String? token}) {
    return {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }
}
