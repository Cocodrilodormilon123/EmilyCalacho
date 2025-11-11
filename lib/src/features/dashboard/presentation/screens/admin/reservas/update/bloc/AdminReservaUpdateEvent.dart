import 'package:equatable/equatable.dart';
import 'package:examen_unidad2/src/domain/models/Reserva.dart';
import 'package:examen_unidad2/src/features/utils/BlocFormItem.dart';

abstract class AdminReservaUpdateEvent extends Equatable {
  const AdminReservaUpdateEvent();
  @override
  List<Object?> get props => [];
}

// Nuevo: Inicializa con los datos de la reserva existente
class AdminReservaUpdateInitEvent extends AdminReservaUpdateEvent {
  final Reserva reserva;
  const AdminReservaUpdateInitEvent({required this.reserva});
  @override
  List<Object?> get props => [reserva];
}

class ClienteChanged extends AdminReservaUpdateEvent {
  final BlocFormItem cliente;
  const ClienteChanged({required this.cliente});
  @override
  List<Object?> get props => [cliente];
}

class HabitacionNumeroChanged extends AdminReservaUpdateEvent {
  final BlocFormItem habitacionNumero;
  const HabitacionNumeroChanged({required this.habitacionNumero});
  @override
  List<Object?> get props => [habitacionNumero];
}

class TipoHabChanged extends AdminReservaUpdateEvent {
  final BlocFormItem tipoHab;
  const TipoHabChanged({required this.tipoHab});
  @override
  List<Object?> get props => [tipoHab];
}

class CostoNocheChanged extends AdminReservaUpdateEvent {
  final BlocFormItem costoNoche;
  const CostoNocheChanged({required this.costoNoche});
  @override
  List<Object?> get props => [costoNoche];
}

class FechaReservaChanged extends AdminReservaUpdateEvent {
  final BlocFormItem fechaReserva;
  const FechaReservaChanged({required this.fechaReserva});
  @override
  List<Object?> get props => [fechaReserva];
}

class CostoTotalChanged extends AdminReservaUpdateEvent {
  final BlocFormItem costoTotal;
  const CostoTotalChanged({required this.costoTotal});
  @override
  List<Object?> get props => [costoTotal];
}

class FormSubmit extends AdminReservaUpdateEvent {}

class ResetForm extends AdminReservaUpdateEvent {}
