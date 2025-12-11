import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/auth/role_selection_screen.dart';
import '../screens/patient/patient_dashboard.dart';
import '../screens/doctor/doctor_dashboard.dart';

class AppRoutes {
  static const String roleSelection = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String patientDashboard = '/patient-dashboard';
  static const String doctorDashboard = '/doctor-dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());
      case login:
        final role = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => LoginScreen(role: role));
      case register:
        final role = settings.arguments as String?;
        return MaterialPageRoute(builder: (_) => RegisterScreen(role: role));
      case patientDashboard:
        return MaterialPageRoute(builder: (_) => const PatientDashboard());
      case doctorDashboard:
        return MaterialPageRoute(builder: (_) => const DoctorDashboard());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
