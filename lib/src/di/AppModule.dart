import 'package:examen_unidad2/src/data/dataSource/local/SharedPref.dart';
import 'package:examen_unidad2/src/data/dataSource/remote/service/ReservaService.dart';
import 'package:examen_unidad2/src/data/repository/ReservaRepositoryImpl.dart';
import 'package:examen_unidad2/src/domain/repository/ReservaRepository.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/CreateReservaUseCase.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/DeleteReservaUseCase.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/GetReservaByIdUseCase.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/GetReservasUseCase.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/ReservaUseCases.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/UpdateReservaUseCase.dart';
import 'package:injectable/injectable.dart';

@module
abstract class AppModule {
  // Shared Preferences
  @injectable
  SharedPref get sharedPref => SharedPref();

  // Services
  @injectable
  ReservaService get reservaService => ReservaService();

  // Repositories
  @injectable
  ReservaRepository get reservaRepository =>
      ReservaRepositoryImpl(reservaService);

  // UseCases
  @injectable
  ReservaUseCases get reservaUseCases => ReservaUseCases(
    getReservas: GetReservasUseCase(reservaRepository),
    getReservaById: GetReservaByIdUseCase(reservaRepository),
    deleteReserva: DeleteReservaUseCase(reservaRepository),
    createReserva: CreateReservaUseCase(reservaRepository),
    updateReserva: UpdateReservaUseCase(reservaRepository),
  );
}
