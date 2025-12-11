import 'package:flutter/foundation.dart';
import '../config/api_config.dart';
import '../services/api_service.dart';
import '../models/appointment_model.dart';

class AppointmentProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<AppointmentModel> _appointments = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<AppointmentModel> get appointments => _appointments;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchAppointments({String? doctorId, String? patientId}) async {
    _isLoading = true;
    notifyListeners();

    try {
      String url = ApiConfig.appointments;
      if (doctorId != null) {
        url = '${ApiConfig.doctorAppointments}?doctorId=$doctorId';
      } else if (patientId != null) {
        url = '${ApiConfig.appointments}?patientId=$patientId';
      }

      final response = await _apiService.get(url);

      if (response['success']) {
        final List<dynamic> data = response['data'];
        _appointments =
            data.map((json) => AppointmentModel.fromJson(json)).toList();
        _errorMessage = null;
      } else {
        _errorMessage = response['message'];
      }
    } catch (e) {
      _errorMessage = 'Failed to fetch appointments: $e';
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> bookAppointment(Map<String, dynamic> appointmentData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response =
          await _apiService.post(ApiConfig.bookAppointment, appointmentData);

      if (response['success']) {
        await fetchAppointments();
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = response['message'];
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = 'Failed to book appointment: $e';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }
}
