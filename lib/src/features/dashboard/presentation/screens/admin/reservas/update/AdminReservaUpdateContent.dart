import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/update/bloc/AdminReservaUpdateBloc.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/update/bloc/AdminReservaUpdateEvent.dart';
import 'package:examen_unidad2/src/features/dashboard/presentation/screens/admin/reservas/update/bloc/AdminReservaUpdateState.dart';
import 'package:flutter/material.dart';
import 'package:examen_unidad2/src/features/utils/BlocFormItem.dart';

class AdminReservaUpdateContent extends StatefulWidget {
  final AdminReservaUpdateBloc? bloc;
  final AdminReservaUpdateState state;

  const AdminReservaUpdateContent(this.bloc, this.state, {super.key});

  @override
  State<AdminReservaUpdateContent> createState() =>
      _AdminReservaUpdateContentState();
}

class _AdminReservaUpdateContentState extends State<AdminReservaUpdateContent> {
  final TextEditingController _fechaController = TextEditingController();
  final TextEditingController _nochesController = TextEditingController();
  String _selectedTipoHab = 'Simple';
  final List<String> _tiposHabitacion = ['Simple', 'Doble', 'Suite', 'Deluxe'];

  final Map<String, double> _preciosPorTipo = {
    'Simple': 80.0,
    'Doble': 120.0,
    'Suite': 200.0,
    'Deluxe': 300.0,
  };

  @override
  void initState() {
    super.initState();
    _initializeFromState();
  }

  @override
  void didUpdateWidget(AdminReservaUpdateContent oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Si el state cambia, reinicializar los valores
    if (oldWidget.state != widget.state) {
      _initializeFromState();
    }
  }

  void _initializeFromState() {
    // Inicializar fecha
    if (widget.state.fechaReserva.value.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _fechaController.text = widget.state.fechaReserva.value;
          });
        }
      });
    }

    // Inicializar tipo de habitación
    if (widget.state.tipoHab.value.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            _selectedTipoHab = widget.state.tipoHab.value;
          });
        }
      });
    }

    // Calcular las noches basándose en el costo total y costo por noche
    if (widget.state.costoTotal.value.isNotEmpty &&
        widget.state.costoNoche.value.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          final total = double.tryParse(widget.state.costoTotal.value) ?? 0.0;
          final noche = double.tryParse(widget.state.costoNoche.value) ?? 0.0;
          if (noche > 0) {
            final noches = (total / noche).round();
            setState(() {
              _nochesController.text = noches.toString();
            });
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _fechaController.dispose();
    _nochesController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime initialDate;
    try {
      initialDate = DateTime.parse(widget.state.fechaReserva.value);
    } catch (e) {
      initialDate = DateTime.now();
    }

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _fechaController.text =
            '${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}';
      });
      widget.bloc?.add(
        FechaReservaChanged(
          fechaReserva: BlocFormItem(value: _fechaController.text),
        ),
      );
    }
  }

  void _calcularTotal(String noches) {
    if (noches.isNotEmpty) {
      final numNoches = int.tryParse(noches) ?? 0;
      final precioNoche = _preciosPorTipo[_selectedTipoHab] ?? 0.0;
      final total = numNoches * precioNoche;
      widget.bloc?.add(
        CostoTotalChanged(costoTotal: BlocFormItem(value: total.toString())),
      );
    }
  }

  Color _getTipoHabitacionColor(String tipo) {
    switch (tipo) {
      case 'Suite':
        return Colors.purple;
      case 'Doble':
        return Colors.blue;
      case 'Simple':
        return Colors.green;
      case 'Deluxe':
        return Colors.amber;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.state.formKey,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.grey[50]!, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header decorativo
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 32,
                  horizontal: 24,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(32),
                    bottomRight: Radius.circular(32),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.edit_document,
                        size: 48,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Editar Reserva',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Actualiza los datos de la reserva',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Formulario
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Sección: Información del Cliente
                    _buildSectionTitle(
                      'Información del Cliente',
                      Icons.person_outline,
                    ),
                    const SizedBox(height: 16),

                    _buildModernTextField(
                      label: 'Nombre del Cliente',
                      hint: 'Ej: Juan Pérez',
                      icon: Icons.person,
                      initialValue: widget.state.cliente.value,
                      onChanged: (text) => widget.bloc?.add(
                        ClienteChanged(cliente: BlocFormItem(value: text)),
                      ),
                      validator: (_) => widget.state.cliente.error,
                    ),

                    const SizedBox(height: 32),

                    // Sección: Detalles de Habitación
                    _buildSectionTitle(
                      'Detalles de Habitación',
                      Icons.meeting_room_outlined,
                    ),
                    const SizedBox(height: 16),

                    _buildModernTextField(
                      label: 'Número de Habitación',
                      hint: 'Ej: 101',
                      icon: Icons.door_front_door_outlined,
                      keyboardType: TextInputType.number,
                      initialValue: widget.state.habitacionNumero.value,
                      onChanged: (text) => widget.bloc?.add(
                        HabitacionNumeroChanged(
                          habitacionNumero: BlocFormItem(value: text),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Selector de tipo de habitación
                    Text(
                      'Tipo de Habitación',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[700],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: _tiposHabitacion.map((tipo) {
                        final isSelected = _selectedTipoHab == tipo;
                        final color = _getTipoHabitacionColor(tipo);

                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTipoHab = tipo;
                            });
                            widget.bloc?.add(
                              TipoHabChanged(
                                tipoHab: BlocFormItem(value: tipo),
                              ),
                            );
                            widget.bloc?.add(
                              CostoNocheChanged(
                                costoNoche: BlocFormItem(
                                  value: _preciosPorTipo[tipo].toString(),
                                ),
                              ),
                            );
                            // Recalcular el total con el nuevo precio
                            if (_nochesController.text.isNotEmpty) {
                              _calcularTotal(_nochesController.text);
                            }
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 14,
                            ),
                            decoration: BoxDecoration(
                              color: isSelected ? color : Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: isSelected ? color : Colors.grey[300]!,
                                width: 2,
                              ),
                              boxShadow: isSelected
                                  ? [
                                      BoxShadow(
                                        color: color.withOpacity(0.3),
                                        blurRadius: 8,
                                        offset: const Offset(0, 4),
                                      ),
                                    ]
                                  : [],
                            ),
                            child: Column(
                              children: [
                                Text(
                                  tipo,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'S/.${_preciosPorTipo[tipo]!.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: isSelected
                                        ? Colors.white.withOpacity(0.9)
                                        : Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),

                    const SizedBox(height: 32),

                    // Sección: Fechas y Costos
                    _buildSectionTitle(
                      'Fechas y Costos',
                      Icons.calendar_today_outlined,
                    ),
                    const SizedBox(height: 16),

                    // Campo de fecha con DatePicker
                    GestureDetector(
                      onTap: () => _selectDate(context),
                      child: AbsorbPointer(
                        child: _buildModernTextField(
                          label: 'Fecha de Reserva',
                          hint: 'Selecciona una fecha',
                          icon: Icons.calendar_month,
                          controller: _fechaController,
                          onChanged: (_) {},
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    Row(
                      children: [
                        Expanded(
                          child: _buildModernTextField(
                            label: 'Noches',
                            hint: '1',
                            icon: Icons.nightlight_outlined,
                            keyboardType: TextInputType.number,
                            controller: _nochesController,
                            onChanged: (text) {
                              _calcularTotal(text);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildInfoBox(
                            'Precio/Noche',
                            'S/.${_preciosPorTipo[_selectedTipoHab]!.toStringAsFixed(0)}',
                            _getTipoHabitacionColor(_selectedTipoHab),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Total destacado
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.black, Colors.grey[800]!],
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Total a Pagar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            widget.state.costoTotal.value.isNotEmpty
                                ? 'S/.${double.tryParse(widget.state.costoTotal.value)?.toStringAsFixed(2) ?? '0.00'}'
                                : 'S/.0.00',
                            style: const TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Botón de guardar
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: () {
                          if (widget.state.formKey!.currentState!.validate()) {
                            widget.bloc?.add(FormSubmit());
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 0,
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.check_circle_outline),
                            SizedBox(width: 8),
                            Text(
                              'Actualizar Reserva',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, size: 20, color: Colors.black87),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildModernTextField({
    required String label,
    required String hint,
    required IconData icon,
    String? initialValue,
    TextEditingController? controller,
    TextInputType? keyboardType,
    required Function(String) onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            initialValue: controller == null ? initialValue : null,
            controller: controller,
            keyboardType: keyboardType,
            onChanged: onChanged,
            validator: validator,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.grey[400]),
              prefixIcon: Icon(icon, color: Colors.grey[600]),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Colors.grey[200]!),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.black, width: 2),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(color: Colors.red, width: 1),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[700])),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
