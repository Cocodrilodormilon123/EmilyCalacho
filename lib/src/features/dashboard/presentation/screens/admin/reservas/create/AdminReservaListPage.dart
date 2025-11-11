import 'package:examen_unidad2/src/domain/utils/Resource.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/create/AdminReservaListContent.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/create/bloc/AdminReservaListBloc.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/create/bloc/AdminReservaListEvent.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/create/bloc/AdminReservaListState.dart';
import 'package:examen_unidad2/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AdminReservaListPage extends StatefulWidget {
  const AdminReservaListPage({super.key});

  @override
  State<AdminReservaListPage> createState() => _AdminReservaListPageState();
}

class _AdminReservaListPageState extends State<AdminReservaListPage> {
  AdminReservaListBloc? _bloc;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _bloc?.add(const GetReservas());
    });
  }

  @override
  Widget build(BuildContext context) {
    _bloc = BlocProvider.of<AdminReservaListBloc>(context);

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Reservas del Hotel',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.grey[200], height: 1),
        ),
        actions: [
          IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.refresh, color: Colors.black87, size: 20),
            ),
            onPressed: () {
              _bloc?.add(const GetReservas());
              Fluttertoast.showToast(
                msg: 'Actualizando lista...',
                toastLength: Toast.LENGTH_SHORT,
              );
            },
            tooltip: 'Actualizar',
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.black,
        onPressed: () async {
          // Navega a la pantalla de crear reserva
          final result = await Navigator.pushNamed(
            context,
            AppRoutes.adminReservaCreate,
          );

          // Si se creó exitosamente, recarga la lista
          if (result == true) {
            _bloc?.add(const GetReservas());
          }
        },
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text(
          'Nueva Reserva',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<AdminReservaListBloc, AdminReservaListState>(
        listener: (context, state) {
          final response = state.response;
          if (response is Success && response.data is bool) {
            Fluttertoast.showToast(
              msg: 'Reserva eliminada correctamente',
              toastLength: Toast.LENGTH_SHORT,
              backgroundColor: Colors.green[700],
            );
            _bloc?.add(const GetReservas());
          }
          if (response is Error) {
            Fluttertoast.showToast(
              msg: response.message,
              toastLength: Toast.LENGTH_LONG,
              backgroundColor: Colors.red[700],
            );
          }
        },
        child: AdminReservaListContent(bloc: _bloc!),
      ),
    );
  }
}
