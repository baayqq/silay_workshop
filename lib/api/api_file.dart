import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:silay_workshop/api/endpoint.dart';
import 'package:silay_workshop/database/sharedprefence.dart';
import 'package:silay_workshop/model/liatservice.dart';
import 'package:silay_workshop/model/login_error.dart';
import 'package:silay_workshop/model/login_model.dart';
import 'package:silay_workshop/model/login_null.dart';
import 'package:silay_workshop/model/regist_already.dart';
import 'package:silay_workshop/model/regist_error.dart';
import 'package:silay_workshop/model/regist_model.dart';
import 'package:silay_workshop/model/service_model.dart';
import 'package:silay_workshop/model/edit_model.dart';

class UserService {
  Future<Map<String, dynamic>> registUser(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(Endpoint.register),
      headers: {'Accept': 'application/json'},
      body: {'name': name, 'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return registmodelFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return registErrorFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return registAlreadyFromJson(response.body).toJson();
    } else {
      throw Exception('Gagal Mendaftar Akun ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> loginUser(
    String name,
    String email,
    String password,
  ) async {
    final response = await http.post(
      Uri.parse(Endpoint.login),
      headers: {'Accept': 'application/json'},
      body: {'name': name, 'email': email, 'password': password},
    );

    if (response.statusCode == 200) {
      return loginmodelFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return loginErrorFromJson(response.body).toJson();
    } else if (response.statusCode == 422) {
      return loginNullFromJson(response.body).toJson();
    } else {
      throw Exception('Gagal Menemukand Akun ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>> addService({
    // required String bookingDate,
    required String vehicleType,
    required String complaint,
  }) async {
    try {
      final token = await SharedPrefService.getToken();

      if (token == null) {
        throw Exception(
          'Token tidak ditemukan. Silakan login terlebih dahulu.',
        );
      }

      final response = await http.post(
        Uri.parse(Endpoint.liatservice),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
          // 'booking_date': bookingDate,
          'vehicle_type': vehicleType,
          'complaint': complaint,
        },
      );

      if (response.statusCode == 200) {
        // Parsing jika sukses
        return addserviceFromJson(response.body).toJson();
      } else {
        // Coba ambil pesan error dari API (kalau ada)
        final jsonBody = jsonDecode(response.body);
        final errorMessage = jsonBody['message'] ?? 'Gagal menambah layanan.';
        throw Exception('Error ${response.statusCode}: $errorMessage');
      }
    } catch (e) {
      // Tangani error lainnya (misalnya parsing atau tidak ada internet)
      throw Exception('Terjadi kesalahan saat menambah layanan: $e');
    }
  }

  Future<List<GetServ>> cstService() async {
    final token = await SharedPrefService.getToken();

    if (token == null) {
      throw Exception('Token tidak ditemukan. Silakan login terlebih dahulu.');
    }

    final response = await http.get(
      Uri.parse(Endpoint.liatservice),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);

      final liatservis = Liatserv.fromJson(jsonResponse);
      print("${liatservis}");
      print("${jsonResponse}");
      return liatservis.data ?? [];
    } else {
      throw Exception(
        'Gagal memuat data service. Status: ${response.statusCode}',
      );
    }
  }

  Future<List<ServiceData>> cstServiceWithServiceData() async {
    final token = await SharedPrefService.getToken();

    if (token == null) {
      throw Exception('Token tidak ditemukan. Silakan login terlebih dahulu.');
    }

    final response = await http.get(
      Uri.parse(Endpoint.liatservice),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> dataList = jsonResponse['data'];
      return dataList.map((json) => ServiceData.fromJson(json)).toList();
    } else {
      throw Exception(
        'Gagal memuat data service. Status: ${response.statusCode}',
      );
    }
  }

  Future<EditService> updateService({
    required int id,
    required String vehicleType,
    required String complaint,
  }) async {
    final token = await SharedPrefService.getToken();

    if (token == null) {
      throw Exception('Token tidak ditemukan. Silakan login terlebih dahulu.');
    }

    final response = await http.put(
      Uri.parse('${Endpoint.liatservice}/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {'vehicle_type': vehicleType, 'complaint': complaint},
    );

    if (response.statusCode == 200) {
      return editServiceFromJson(response.body);
    } else {
      throw Exception('Gagal mengupdate data. Status: ${response.statusCode}');
    }
  }

  Future<void> updateStatusService({
    required int id,
    required String status,
  }) async {
    final token = await SharedPrefService.getToken();
    final url = Uri.parse('${Endpoint.baseUrl}/api/servis/$id/status');

    final response = await http.put(
      url,
      headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'status': status}),
    );

    if (response.statusCode != 200) {
      throw Exception('Gagal update status. (${response.statusCode})');
    }
  }

  Future<bool> deleteService(int id) async {
    final token = await SharedPrefService.getToken();

    if (token == null) {
      throw Exception("Token tidak ditemukan.");
    }

    final response = await http.delete(
      Uri.parse('${Endpoint.baseUrl}/api/servis/$id'),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );

    print('Status code: ${response.statusCode}');
    print('Body: ${response.body}');

    return response.statusCode == 200;
  }
}
