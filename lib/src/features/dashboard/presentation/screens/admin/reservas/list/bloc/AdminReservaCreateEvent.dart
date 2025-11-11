import 'package:equatable/equatable.dart';
import 'package:examen_unidad2/src/features/utils/BlocFormItem.dart';

abstract class AdminReservaCreateEvent extends Equatable {
  const AdminReservaCreateEvent();
  @override
  List<Object?> get props => [];
}

class AdminReservaCreateInitEvent extends AdminReservaCreateEvent {}

class ClienteChanged extends AdminReservaCreateEvent {
  final BlocFormItem cliente;
  const ClienteChanged({required this.cliente});
  @override
  List<Object?> get props => [cliente];
}

class HabitacionNumeroChanged extends AdminReservaCreateEvent {
  final BlocFormItem habitacionNumero;
  const HabitacionNumeroChanged({required this.habitacionNumero});
  @override
  List<Object?> get props => [habitacionNumero];
}

class TipoHabChanged extends AdminReservaCreateEvent {
  final BlocFormItem tipoHab;
  const TipoHabChanged({required this.tipoHab});
  @override
  List<Object?> get props => [tipoHab];
}

class CostoNocheChanged extends AdminReservaCreateEvent {
  final BlocFormItem costoNoche;
  const CostoNocheChanged({required this.costoNoche});
  @override
  List<Object?> get props => [costoNoche];
}

class FechaReservaChanged extends AdminReservaCreateEvent {
  final BlocFormItem fechaReserva;
  const FechaReservaChanged({required this.fechaReserva});
  @override
  List<Object?> get props => [fechaReserva];
}

class CostoTotalChanged extends AdminReservaCreateEvent {
  final BlocFormItem costoTotal;
  const CostoTotalChanged({required this.costoTotal});
  @override
  List<Object?> get props => [costoTotal];
}

class FormSubmit extends AdminReservaCreateEvent {}

class ResetForm extends AdminReservaCreateEvent {}
