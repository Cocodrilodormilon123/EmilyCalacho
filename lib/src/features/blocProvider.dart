import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/create/bloc/AdminReservaListBloc.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/list/bloc/AdminReservaCreateBloc.dart';
import 'package:examen_unidad2/injection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/ReservaUseCases.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<AdminReservaListBloc>(
    create: (context) => AdminReservaListBloc(locator<ReservaUseCases>()),
  ),
  BlocProvider<AdminReservaCreateBloc>(
    create: (context) => AdminReservaCreateBloc(locator<ReservaUseCases>()),
  ),
];
