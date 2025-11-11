import 'package:examen_unidad2/src/domain/useCase/Reserva/CreateReservaUseCase.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/DeleteReservaUseCase.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/GetReservaByIdUseCase.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/GetReservasUseCase.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/UpdateReservaUseCase.dart';

class ReservaUseCases {
  GetReservasUseCase getReservas;
  GetReservaByIdUseCase getReservaById;
  DeleteReservaUseCase deleteReserva;
  CreateReservaUseCase createReserva;
  UpdateReservaUseCase updateReserva;

  ReservaUseCases({
    required this.getReservas,
    required this.getReservaById,
    required this.deleteReserva,
    required this.createReserva,
    required this.updateReserva,
  });
}
