import 'dart:convert';
import 'dart:io'; // Import untuk File
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  // Pastikan IP ini sesuai dengan IP Laptop Anda (Cek pakai 'ipconfig')
  static const String baseUrl = 'http://192.168.1.6:8000/api';

  // ===========================================================================
  // AUTHENTICATION
  // ===========================================================================

  // Register
  static Future<bool> register(
      String username, String email, String password) async {
    final url = Uri.parse('$baseUrl/register');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'username': username,
          'email': email,
          'password': password,
          'role': 'seeker', // Default role 'seeker'
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        if (data['access_token'] != null) {
          await _saveToken(data['access_token']);
        }
        return true;
      }
      return false;
    } catch (e) {
      print('Error register: $e');
      return false;
    }
  }

  // Login
  static Future<bool> login(String username, String password, String role,
      {String? companyId}) async {
    final url = Uri.parse('$baseUrl/login');

    Map<String, dynamic> body = {
      'username': username,
      'password': password,
      'role': role,
    };

    if (role == 'company' && companyId != null) {
      body['company_id'] = companyId;
    }

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _saveToken(data['access_token']);
        return true;
      }
      return false;
    } catch (e) {
      print('Error login: $e');
      return false;
    }
  }

  // ===========================================================================
  // DASHBOARD & JOBS
  // ===========================================================================

  // Get Dashboard Data
  static Future<Map<String, dynamic>?> getDashboardData() async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/dashboard');
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      print('Error fetch dashboard: $e');
    }
    return null;
  }

  // Apply Job (Multipart Request)
  static Future<bool> applyJob({
    required String jobId,
    required String name,
    required String email,
    required String phone,
    File? resumeFile,
  }) async {
    final token = await _getToken();
    if (token == null) return false;

    final url = Uri.parse('$baseUrl/jobs/$jobId/apply');

    try {
      var request = http.MultipartRequest('POST', url);

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      request.fields['applicant_name'] = name;
      request.fields['email'] = email;
      request.fields['phone_number'] = phone;

      if (resumeFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'resume',
          resumeFile.path,
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      print('Error applying job: $e');
      return false;
    }
  }

  // ===========================================================================
  // PROFILE (GET, UPDATE, AVATAR, DELETE RESUME)
  // ===========================================================================

  // GET PROFILE
  static Future<Map<String, dynamic>?> getProfile() async {
    final token = await _getToken();
    if (token == null) return null;

    final url = Uri.parse('$baseUrl/profile');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body)['data'] ?? jsonDecode(response.body);
      } else {
        print("Get Profile Failed: ${response.body}");
      }
    } catch (e) {
      print("Error get profile: $e");
    }
    return null;
  }

  // UPDATE PROFILE (TEXT & UPLOAD RESUME)
  static Future<bool> updateProfile({
    String? jobTitle,
    String? location,
    File? resumeFile,
  }) async {
    final token = await _getToken();
    if (token == null) return false;

    final url = Uri.parse('$baseUrl/profile/update');

    try {
      var request = http.MultipartRequest('POST', url);
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      if (jobTitle != null) request.fields['job_title'] = jobTitle;
      if (location != null) request.fields['location'] = location;

      if (resumeFile != null) {
        request.files.add(await http.MultipartFile.fromPath(
          'resume',
          resumeFile.path,
        ));
      }

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error update profile: $e");
      return false;
    }
  }

  // --- [BARU] UPDATE FOTO PROFIL (AVATAR) ---
  static Future<bool> updateAvatar(File imageFile) async {
    final token = await _getToken();
    if (token == null) return false;

    try {
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl/profile/update'));

      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      });

      // Tambahkan file gambar dengan key 'avatar' (sesuai Laravel)
      request.files.add(await http.MultipartFile.fromPath(
        'avatar',
        imageFile.path,
      ));

      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Gagal upload avatar: ${response.body}");
        return false;
      }
    } catch (e) {
      print('Error upload avatar: $e');
      return false;
    }
  }

  // --- [BARU] DELETE RESUME ---
  static Future<bool> deleteResume() async {
    final token = await _getToken();
    if (token == null) return false;

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/profile/delete-resume'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print("Gagal delete resume: ${response.body}");
        return false;
      }
    } catch (e) {
      print('Error delete resume: $e');
      return false;
    }
  }

  // ===========================================================================
  // TOKEN MANAGEMENT
  // ===========================================================================
  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  static Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }
}
