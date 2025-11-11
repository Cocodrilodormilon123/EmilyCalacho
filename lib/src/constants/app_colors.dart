import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // --- Colores Principales ---
  static const Color primary = Color(0xFF003366);
  static const Color primary_admin = Color(0xFF000000); // Azul oscuro
  // Azul oscuro
  static const Color accent = Color(0xFFF8A900); // Amarillo/Naranja brillante

  // --- Colores de Branding (ajustados a la nueva combinación) ---
  /// Azul más claro derivado del primary (para detalles o hover).
  static const Color logoLightBlue = Color(0xFF336699);

  /// Amarillo más suave derivado del accent (para fondos o estados suaves).
  static const Color logoSoftYellow = Color(0xFFFFD54F);

  // --- Colores de UI Neutros ---
  static const Color background = Color(
    0xFFF9FAFB,
  ); // Blanco muy suave, casi gris
  static const Color textPrimary = Color(
    0xFF1C2A35,
  ); // Gris oscuro, buen contraste sobre fondo claro
  static const Color textSecondary = Color(0xFF607D8B); // Gris azulado suave
  static const Color inputBorder = Color(0xFFCFD8DC); // Gris claro neutro

  // --- Estados ---
  static const Color error = Color(
    0xFFD32F2F,
  ); // Rojo para errores (sin cambios)
  static const Color success = Color(0xFF2E7D32); // Verde oscuro más sobrio
}
