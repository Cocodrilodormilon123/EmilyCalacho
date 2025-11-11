import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/list/bloc/AdminReservaCreateEvent.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/list/bloc/AdminReservaCreateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/ReservaUseCases.dart';
import 'package:examen_unidad2/src/domain/utils/Resource.dart';
import 'package:examen_unidad2/src/features/utils/BlocFormItem.dart';

class AdminReservaCreateBloc
    extends Bloc<AdminReservaCreateEvent, AdminReservaCreateState> {
  final ReservaUseCases reservaUseCases;
  final formKey = GlobalKey<FormState>();

  AdminReservaCreateBloc(this.reservaUseCases)
    : super(const AdminReservaCreateState()) {
    on<AdminReservaCreateInitEvent>(_onInitEvent);
    on<ClienteChanged>(_onClienteChanged);
    on<HabitacionNumeroChanged>(_onHabitacionNumeroChanged);
    on<TipoHabChanged>(_onTipoHabChanged);
    on<CostoNocheChanged>(_onCostoNocheChanged);
    on<FechaReservaChanged>(_onFechaReservaChanged);
    on<CostoTotalChanged>(_onCostoTotalChanged);
    on<FormSubmit>(_onFormSubmit);
    on<ResetForm>(_onResetForm);
  }

  void _onInitEvent(AdminReservaCreateInitEvent event, Emitter emit) {
    emit(state.copyWith(formKey: formKey));
  }

  void _onClienteChanged(ClienteChanged e, Emitter emit) => emit(
    state.copyWith(
      cliente: BlocFormItem(
        value: e.cliente.value,
        error: e.cliente.value.isNotEmpty ? null : 'Campo requerido',
      ),
    ),
  );

  void _onHabitacionNumeroChanged(HabitacionNumeroChanged e, Emitter emit) =>
      emit(state.copyWith(habitacionNumero: e.habitacionNumero));

  void _onTipoHabChanged(TipoHabChanged e, Emitter emit) =>
      emit(state.copyWith(tipoHab: e.tipoHab));

  void _onCostoNocheChanged(CostoNocheChanged e, Emitter emit) =>
      emit(state.copyWith(costoNoche: e.costoNoche));

  void _onFechaReservaChanged(FechaReservaChanged e, Emitter emit) =>
      emit(state.copyWith(fechaReserva: e.fechaReserva));

  void _onCostoTotalChanged(CostoTotalChanged e, Emitter emit) =>
      emit(state.copyWith(costoTotal: e.costoTotal));

  Future<void> _onFormSubmit(FormSubmit event, Emitter emit) async {
    emit(state.copyWith(response: Loading()));
    Resource response = await reservaUseCases.createReserva.run(
      state.toReserva(),
    );
    emit(state.copyWith(response: response));
  }

  void _onResetForm(ResetForm e, Emitter emit) => emit(state.resetForm());
}
