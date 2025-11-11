import 'package:examen_unidad2/src/domain/repository/ReservaRepository.dart';

class GetReservasUseCase {
  ReservaRepository reservaRepository;

  GetReservasUseCase(this.reservaRepository);

  run() => reservaRepository.getReservas();
}
