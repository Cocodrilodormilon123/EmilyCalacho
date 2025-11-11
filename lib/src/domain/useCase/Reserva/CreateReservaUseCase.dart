import 'package:examen_unidad2/src/domain/models/Reserva.dart';
import 'package:examen_unidad2/src/domain/repository/ReservaRepository.dart';

class CreateReservaUseCase {
  ReservaRepository reservaRepository;

  CreateReservaUseCase(this.reservaRepository);

  run(Reserva reserva) => reservaRepository.create(reserva);
}
