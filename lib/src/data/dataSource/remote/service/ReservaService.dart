import 'dart:convert';
import 'package:examen_unidad2/src/data/api/ApiConfig.dart';
import 'package:examen_unidad2/src/domain/models/Reserva.dart';
import 'package:examen_unidad2/src/domain/utils/ListToString.dart';
import 'package:examen_unidad2/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class ReservaService {
  ReservaService();

  // Obtener todas las reservas
  Future<Resource<List<Reserva>>> getReservas() async {
    try {
      Uri url = Uri.http(ApiConfig.API_URL, '/reservas');
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<Reserva> reservas = Reserva.fromJsonList(data);
        return Success(reservas);
      } else {
        return Error(ListToString(data['message']));
      }
    } catch (e) {
      print('Error en ReservaService.getReservas: $e');
      return Error(e.toString());
    }
  }

  // Obtener una reserva por ID
  Future<Resource<Reserva>> getById(int id) async {
    try {
      Uri url = Uri.http(ApiConfig.API_URL, '/reservas/$id');
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Reserva reserva = Reserva.fromJson(data);
        return Success(reserva);
      } else {
        return Error(ListToString(data['message']));
      }
    } catch (e) {
      print('Error en ReservaService.getById: $e');
      return Error(e.toString());
    }
  }

  // Crear una nueva reserva
  Future<Resource<Reserva>> create(Reserva reserva) async {
    try {
      Uri url = Uri.http(ApiConfig.API_URL, '/reservas');
      Map<String, String> headers = {"Content-Type": "application/json"};

      String body = json.encode(reserva.toJson());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Reserva reservaResponse = Reserva.fromJson(data);
        return Success(reservaResponse);
      } else {
        return Error(ListToString(data['message']));
      }
    } catch (e) {
      print('Error en ReservaService.create: $e');
      return Error(e.toString());
    }
  }

  // Actualizar una reserva
  Future<Resource<Reserva>> update(int id, Reserva reserva) async {
    try {
      Uri url = Uri.http(ApiConfig.API_URL, '/reservas/$id');
      Map<String, String> headers = {"Content-Type": "application/json"};

      String body = json.encode(reserva.toJson());
      final response = await http.put(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        Reserva reservaResponse = Reserva.fromJson(data);
        return Success(reservaResponse);
      } else {
        return Error(ListToString(data['message']));
      }
    } catch (e) {
      print('Error en ReservaService.update: $e');
      return Error(e.toString());
    }
  }

  // Eliminar una reserva
  Future<Resource<bool>> delete(int id) async {
    try {
      Uri url = Uri.http(ApiConfig.API_URL, '/reservas/$id');
      Map<String, String> headers = {"Content-Type": "application/json"};

      final response = await http.delete(url, headers: headers);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        final data = json.decode(response.body);
        return Error(ListToString(data['message']));
      }
    } catch (e) {
      print('Error en ReservaService.delete: $e');
      return Error(e.toString());
    }
  }
}
