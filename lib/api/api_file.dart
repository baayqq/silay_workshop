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
    required String bookingDate,
    required String vehicleType,
    required String description,
  }) async {
    final token = await SharedPrefService.getToken();

    if (token == null) {
      throw Exception('Token tidak ditemukan. Silakan login terlebih dahulu.');
    }

    final response = await http.post(
      Uri.parse(Endpoint.tambahserv),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
      body: {
        'booking_date': bookingDate,
        'vehicle_type': vehicleType,
        'description': description,
      },
    );

    if (response.statusCode == 200) {
      return tambahserviceFromJson(response.body).toJson();
    } else {
      throw Exception('Gagal menambah layanan. Status: ${response.statusCode}');
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
    return liatservis.data ?? []; 
  } else {
    throw Exception('Gagal memuat data service. Status: ${response.statusCode}');
  }
}

}
