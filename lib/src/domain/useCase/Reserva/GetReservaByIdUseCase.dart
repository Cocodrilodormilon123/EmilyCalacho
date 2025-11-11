import 'package:examen_unidad2/src/domain/repository/ReservaRepository.dart';

class GetReservaByIdUseCase {
  ReservaRepository reservaRepository;

  GetReservaByIdUseCase(this.reservaRepository);

  run(int id) => reservaRepository.getById(id);
}
