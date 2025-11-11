import 'package:examen_unidad2/src/domain/models/Reserva.dart';
import 'package:examen_unidad2/src/domain/repository/ReservaRepository.dart';

class UpdateReservaUseCase {
  ReservaRepository reservaRepository;

  UpdateReservaUseCase(this.reservaRepository);

  run(int id, Reserva reserva) => reservaRepository.update(id, reserva);
}
