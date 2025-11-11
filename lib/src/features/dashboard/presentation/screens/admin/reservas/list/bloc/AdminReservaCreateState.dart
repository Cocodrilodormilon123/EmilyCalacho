import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:examen_unidad2/src/domain/models/Reserva.dart';
import 'package:examen_unidad2/src/domain/utils/Resource.dart';
import 'package:examen_unidad2/src/features/utils/BlocFormItem.dart';

class AdminReservaCreateState extends Equatable {
  final BlocFormItem cliente;
  final BlocFormItem habitacionNumero;
  final BlocFormItem tipoHab;
  final BlocFormItem costoNoche;
  final BlocFormItem fechaReserva;
  final BlocFormItem costoTotal;
  final GlobalKey<FormState>? formKey;
  final Resource? response;

  const AdminReservaCreateState({
    this.cliente = const BlocFormItem(error: 'Ingrese el nombre del cliente'),
    this.habitacionNumero = const BlocFormItem(
      error: 'Ingrese el número de habitación',
    ),
    this.tipoHab = const BlocFormItem(error: 'Ingrese el tipo de habitación'),
    this.costoNoche = const BlocFormItem(error: 'Ingrese el costo por noche'),
    this.fechaReserva = const BlocFormItem(error: 'Seleccione una fecha'),
    this.costoTotal = const BlocFormItem(error: 'Ingrese el costo total'),
    this.formKey,
    this.response,
  });

  // CORREGIDO: No envía idreserva, createdAt, updatedAt
  Reserva toReserva() => Reserva(
    cliente: cliente.value,
    habitacionNumero: habitacionNumero.value,
    tipoHab: tipoHab.value,
    costoNoche: double.tryParse(costoNoche.value) ?? 0.0,
    fechaReserva: DateTime.tryParse(fechaReserva.value) ?? DateTime.now(),
    costoTotal: double.tryParse(costoTotal.value) ?? 0.0,
    // NO incluimos: idreserva, createdAt, updatedAt
  );

  AdminReservaCreateState resetForm() => const AdminReservaCreateState();

  AdminReservaCreateState copyWith({
    BlocFormItem? cliente,
    BlocFormItem? habitacionNumero,
    BlocFormItem? tipoHab,
    BlocFormItem? costoNoche,
    BlocFormItem? fechaReserva,
    BlocFormItem? costoTotal,
    GlobalKey<FormState>? formKey,
    Resource? response,
  }) {
    return AdminReservaCreateState(
      cliente: cliente ?? this.cliente,
      habitacionNumero: habitacionNumero ?? this.habitacionNumero,
      tipoHab: tipoHab ?? this.tipoHab,
      costoNoche: costoNoche ?? this.costoNoche,
      fechaReserva: fechaReserva ?? this.fechaReserva,
      costoTotal: costoTotal ?? this.costoTotal,
      formKey: formKey ?? this.formKey,
      response: response,
    );
  }

  @override
  List<Object?> get props => [
    cliente,
    habitacionNumero,
    tipoHab,
    costoNoche,
    fechaReserva,
    costoTotal,
    response,
  ];
}
