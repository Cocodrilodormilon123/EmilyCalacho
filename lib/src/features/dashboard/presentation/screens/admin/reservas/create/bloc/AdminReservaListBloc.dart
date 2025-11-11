import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/create/bloc/AdminReservaListEvent.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/create/bloc/AdminReservaListState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/ReservaUseCases.dart';
import 'package:examen_unidad2/src/domain/utils/Resource.dart';

class AdminReservaListBloc
    extends Bloc<AdminReservaListEvent, AdminReservaListState> {
  final ReservaUseCases reservaUseCases;

  AdminReservaListBloc(this.reservaUseCases)
    : super(const AdminReservaListState()) {
    on<GetReservas>(_onGetReservas);
    on<DeleteReserva>(_onDeleteReserva);
  }

  Future<void> _onGetReservas(
    GetReservas event,
    Emitter<AdminReservaListState> emit,
  ) async {
    emit(state.copyWith(response: Loading()));

    Resource response = await reservaUseCases.getReservas.run();
    emit(state.copyWith(response: response));
  }

  Future<void> _onDeleteReserva(
    DeleteReserva event,
    Emitter<AdminReservaListState> emit,
  ) async {
    emit(state.copyWith(response: Loading()));

    Resource response = await reservaUseCases.deleteReserva.run(event.id);
    emit(state.copyWith(response: response));
  }
}
