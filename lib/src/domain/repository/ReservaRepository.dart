import 'package:examen_unidad2/src/domain/models/Reserva.dart';
import 'package:examen_unidad2/src/domain/utils/Resource.dart';

abstract class ReservaRepository {
  Future<Resource<Reserva>> create(Reserva reserva);
  Future<Resource<Reserva>> update(int id, Reserva reserva);
  Future<Resource<List<Reserva>>> getReservas();
  Future<Resource<Reserva>> getById(int id);
  Future<Resource<bool>> delete(int id);
}
