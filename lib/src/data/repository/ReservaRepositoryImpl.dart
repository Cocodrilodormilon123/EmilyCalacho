import 'package:examen_unidad2/src/data/dataSource/remote/service/ReservaService.dart';
import 'package:examen_unidad2/src/domain/models/Reserva.dart';
import 'package:examen_unidad2/src/domain/repository/ReservaRepository.dart';
import 'package:examen_unidad2/src/domain/utils/Resource.dart';

class ReservaRepositoryImpl implements ReservaRepository {
  final ReservaService reservaService;

  ReservaRepositoryImpl(this.reservaService);

  @override
  Future<Resource<Reserva>> create(Reserva reserva) {
    return reservaService.create(reserva);
  }

  @override
  Future<Resource<bool>> delete(int id) {
    return reservaService.delete(id);
  }

  @override
  Future<Resource<List<Reserva>>> getReservas() {
    return reservaService.getReservas();
  }

  @override
  Future<Resource<Reserva>> update(int id, Reserva reserva) {
    return reservaService.update(id, reserva);
  }

  @override
  Future<Resource<Reserva>> getById(int id) {
    return reservaService.getById(id);
  }
}
