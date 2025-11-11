import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/update/bloc/AdminReservaUpdateEvent.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/update/bloc/AdminReservaUpdateState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/ReservaUseCases.dart';
import 'package:examen_unidad2/src/domain/utils/Resource.dart';
import 'package:examen_unidad2/src/features/utils/BlocFormItem.dart';

class AdminReservaUpdateBloc
    extends Bloc<AdminReservaUpdateEvent, AdminReservaUpdateState> {
  final ReservaUseCases reservaUseCases;
  final formKey = GlobalKey<FormState>();

  AdminReservaUpdateBloc(this.reservaUseCases)
    : super(const AdminReservaUpdateState()) {
    on<AdminReservaUpdateInitEvent>(_onInitEvent);
    on<ClienteChanged>(_onClienteChanged);
    on<HabitacionNumeroChanged>(_onHabitacionNumeroChanged);
    on<TipoHabChanged>(_onTipoHabChanged);
    on<CostoNocheChanged>(_onCostoNocheChanged);
    on<FechaReservaChanged>(_onFechaReservaChanged);
    on<CostoTotalChanged>(_onCostoTotalChanged);
    on<FormSubmit>(_onFormSubmit);
    on<ResetForm>(_onResetForm);
  }

  // Inicializa el formulario con los datos de la reserva existente
  void _onInitEvent(AdminReservaUpdateInitEvent event, Emitter emit) {
    final reserva = event.reserva;

    // Formatear la fecha correctamente
    final fechaFormateada =
        '${reserva.fechaReserva.year}-${reserva.fechaReserva.month.toString().padLeft(2, '0')}-${reserva.fechaReserva.day.toString().padLeft(2, '0')}';

    emit(
      state.copyWith(
        formKey: formKey,
        id: reserva.idreserva,
        cliente: BlocFormItem(value: reserva.cliente, error: null),
        habitacionNumero: BlocFormItem(
          value: reserva.habitacionNumero,
          error: null,
        ),
        tipoHab: BlocFormItem(value: reserva.tipoHab, error: null),
        costoNoche: BlocFormItem(
          value: reserva.costoNoche.toString(),
          error: null,
        ),
        fechaReserva: BlocFormItem(value: fechaFormateada, error: null),
        costoTotal: BlocFormItem(
          value: reserva.costoTotal.toString(),
          error: null,
        ),
      ),
    );
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
    Resource response = await reservaUseCases.updateReserva.run(
      state.id!,
      state.toReserva(),
    );
    emit(state.copyWith(response: response));
  }

  void _onResetForm(ResetForm e, Emitter emit) =>
      emit(const AdminReservaUpdateState());
}
