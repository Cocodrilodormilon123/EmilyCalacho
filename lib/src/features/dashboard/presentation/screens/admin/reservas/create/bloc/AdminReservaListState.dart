import 'package:equatable/equatable.dart';
import 'package:examen_unidad2/src/domain/utils/Resource.dart';

class AdminReservaListState extends Equatable {
  final Resource? response;

  const AdminReservaListState({this.response});

  AdminReservaListState copyWith({Resource? response}) {
    return AdminReservaListState(response: response ?? this.response);
  }

  @override
  List<Object?> get props => [response];
}
