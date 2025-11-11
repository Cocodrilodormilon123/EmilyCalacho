import 'package:equatable/equatable.dart';

abstract class AdminReservaListEvent extends Equatable {
  const AdminReservaListEvent();

  @override
  List<Object?> get props => [];
}

// Obtener todas las reservas
class GetReservas extends AdminReservaListEvent {
  const GetReservas();
}

// Eliminar una reserva
class DeleteReserva extends AdminReservaListEvent {
  final int id;
  const DeleteReserva({required this.id});

  @override
  List<Object?> get props => [id];
}
