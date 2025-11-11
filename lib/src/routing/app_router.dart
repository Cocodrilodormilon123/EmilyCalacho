import 'package:examen_unidad2/src/domain/models/Reserva.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/create/AdminReservaListPage.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/create/bloc/AdminReservaListBloc.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/list/AdminReservaCreatePage.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/list/bloc/AdminReservaCreateBloc.dart';
import 'package:examen_unidad2/src/domain/useCase/Reserva/ReservaUseCases.dart';
import 'package:examen_unidad2/injection.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/update/AdminReservaUpdatePage.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/update/bloc/AdminReservaUpdateBloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRoutes {
  static const String adminReservaList = '/admin/reservas/list';
  static const String adminReservaCreate = '/admin/reservas/create';
  static const String adminReservaUpdate = '/admin/reservas/update';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.adminReservaList:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AdminReservaListBloc(locator<ReservaUseCases>()),
            child: const AdminReservaListPage(),
          ),
        );

      case AppRoutes.adminReservaCreate:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AdminReservaCreateBloc(locator<ReservaUseCases>()),
            child: const AdminReservaCreatePage(),
          ),
        );
      case AppRoutes.adminReservaUpdate:
        final reserva = settings.arguments as Reserva;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                AdminReservaUpdateBloc(locator<ReservaUseCases>()),
            child: AdminReservaUpdatePage(reserva: reserva),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            appBar: AppBar(title: const Text('Error')),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Ruta no definida: ${settings.name}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        );
    }
  }
}
