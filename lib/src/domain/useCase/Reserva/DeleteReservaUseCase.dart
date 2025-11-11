import 'package:examen_unidad2/src/domain/repository/ReservaRepository.dart';

class DeleteReservaUseCase {
  ReservaRepository reservaRepository;

  DeleteReservaUseCase(this.reservaRepository);

  run(int id) => reservaRepository.delete(id);
}
