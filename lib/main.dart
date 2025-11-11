import 'package:examen_unidad2/src/constants/app_colors.dart';
import 'package:examen_unidad2/injection.dart';
import 'package:examen_unidad2/src/routing/app_router.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies(); // Inicializa GetIt
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gestión de Reservas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: 'SansSerif',
      ),
      initialRoute: AppRoutes.adminReservaList,
      onGenerateRoute: AppRouter.generateRoute,
    );
  }
}
