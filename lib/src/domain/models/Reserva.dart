import 'dart:convert';

Reserva reservaFromJson(String str) => Reserva.fromJson(json.decode(str));

String reservaToJson(Reserva data) => json.encode(data.toJson());

class Reserva {
  int? idreserva;
  String cliente;
  String habitacionNumero;
  String tipoHab;
  double costoNoche;
  DateTime fechaReserva;
  double costoTotal;
  DateTime? createdAt;
  DateTime? updatedAt;

  Reserva({
    this.idreserva,
    required this.cliente,
    required this.habitacionNumero,
    required this.tipoHab,
    required this.costoNoche,
    required this.fechaReserva,
    required this.costoTotal,
    this.createdAt,
    this.updatedAt,
  });

  static List<Reserva> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => Reserva.fromJson(item)).toList();
  }

  factory Reserva.fromJson(Map<String, dynamic> json) => Reserva(
    idreserva: json["idreserva"] is String
        ? int.tryParse(json["idreserva"]) ?? 0
        : json["idreserva"] ?? 0,
    cliente: json["cliente"] ?? '',
    habitacionNumero: json["habitacion_numero"] ?? '',
    tipoHab: json["tipo_hab"] ?? '',
    costoNoche: json["costo_noche"] is String
        ? double.tryParse(json["costo_noche"]) ?? 0.0
        : (json["costo_noche"] ?? 0.0).toDouble(),
    fechaReserva:
        DateTime.tryParse(json["fecha_reserva"] ?? '') ?? DateTime.now(),
    costoTotal: json["costo_total"] is String
        ? double.tryParse(json["costo_total"]) ?? 0.0
        : (json["costo_total"] ?? 0.0).toDouble(),
    createdAt: json["created_at"] != null
        ? DateTime.tryParse(json["created_at"])
        : null,
    updatedAt: json["updated_at"] != null
        ? DateTime.tryParse(json["updated_at"])
        : null,
  );

  // Método para CREAR (sin id, created_at, updated_at)
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cliente'] = cliente;
    data['habitacion_numero'] = habitacionNumero;
    data['tipo_hab'] = tipoHab;
    data['costo_noche'] = costoNoche;
    data['fecha_reserva'] = fechaReserva.toIso8601String();
    data['costo_total'] = costoTotal;
    return data;
  }

  // Método para ACTUALIZAR (con id, sin created_at, updated_at)
  Map<String, dynamic> toJsonUpdate() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (idreserva != null) data['idreserva'] = idreserva;
    data['cliente'] = cliente;
    data['habitacion_numero'] = habitacionNumero;
    data['tipo_hab'] = tipoHab;
    data['costo_noche'] = costoNoche;
    data['fecha_reserva'] = fechaReserva.toIso8601String();
    data['costo_total'] = costoTotal;
    return data;
  }

  // Método completo con todos los campos (para debug o casos especiales)
  Map<String, dynamic> toJsonComplete() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (idreserva != null) data['idreserva'] = idreserva;
    data['cliente'] = cliente;
    data['habitacion_numero'] = habitacionNumero;
    data['tipo_hab'] = tipoHab;
    data['costo_noche'] = costoNoche;
    data['fecha_reserva'] = fechaReserva.toIso8601String();
    data['costo_total'] = costoTotal;
    if (createdAt != null) data['created_at'] = createdAt!.toIso8601String();
    if (updatedAt != null) data['updated_at'] = updatedAt!.toIso8601String();
    return data;
  }
}
