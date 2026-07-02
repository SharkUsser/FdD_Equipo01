import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';

// ─────────────────────────────────────────────
//  MODELO DE PREDICCIÓN ML
// ─────────────────────────────────────────────
class DetalleSensor {
  final String nivel;
  final String emoji;
  final double valor;

  DetalleSensor({
    required this.nivel,
    required this.emoji,
    required this.valor,
  });

  factory DetalleSensor.fromMap(Map<dynamic, dynamic> map) {
    return DetalleSensor(
      nivel: map['nivel'] ?? 'DESCONOCIDO',
      emoji: map['emoji'] ?? '⚪',
      valor: (map['valor'] ?? 0).toDouble(),
    );
  }
}

class PrediccionML {
  final String estado;
  final double confianza;
  final String recomendacion;
  final int saludGeneral;
  final Map<String, DetalleSensor> detalle;
  final int timestamp;
  final String cultivo;
  final String etapa;

  PrediccionML({
    required this.estado,
    required this.confianza,
    required this.recomendacion,
    required this.saludGeneral,
    required this.detalle,
    required this.timestamp,
    required this.cultivo,
    required this.etapa,
  });

  factory PrediccionML.fromMap(Map<dynamic, dynamic> map) {
    final detalleMap = <String, DetalleSensor>{};

    if (map['detalle'] != null) {
      final d = map['detalle'] as Map<dynamic, dynamic>;
      d.forEach((key, value) {
        detalleMap[key.toString()] =
            DetalleSensor.fromMap(value as Map<dynamic, dynamic>);
      });
    }

    return PrediccionML(
      estado: map['estado'] ?? 'DESCONOCIDO',
      confianza: (map['confianza'] ?? 0).toDouble(),
      recomendacion: map['recomendacion'] ?? 'Sin datos del modelo ML',
      saludGeneral: (map['salud_general'] ?? 0).toInt(),
      detalle: detalleMap,
      timestamp: map['timestamp'] ?? 0,
      cultivo: map['cultivo'] ?? 'Arándano',
      etapa: map['etapa'] ?? 'Germinación',
    );
  }
}

// ─────────────────────────────────────────────
//  PANTALLA DE RECOMENDACIONES
// ─────────────────────────────────────────────
class RecomendacionesScreen extends StatefulWidget {
  const RecomendacionesScreen({super.key});

  @override
  State<RecomendacionesScreen> createState() => _RecomendacionesScreenState();
}

class _RecomendacionesScreenState extends State<RecomendacionesScreen>
    with SingleTickerProviderStateMixin {
  final _db = FirebaseDatabase.instance.ref();

  PrediccionML? _prediccion;
  StreamSubscription? _sub;
  bool _cargando = true;

  late AnimationController _animCtrl;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animCtrl,
      curve: Curves.easeOut,
    );
    _iniciarStream();
  }

  void _iniciarStream() {
    _sub = _db.child('ml/prediccion_actual').onValue.listen((event) {
      if (event.snapshot.value != null) {
        final map = event.snapshot.value as Map<dynamic, dynamic>;
        setState(() {
          _prediccion = PrediccionML.fromMap(map);
          _cargando = false;
        });
        _animCtrl.forward(from: 0);
      }
    });
  }

  @override
  void dispose() {
    _sub?.cancel();
    _animCtrl.dispose();
    super.dispose();
  }

  // ── Colores por estado ────────────────────
  Color _colorEstado(String estado) {
    switch (estado) {
      case 'OPTIMO':
        return const Color(0xFF52B788);
      case 'SEQUIA':
        return const Color(0xFFFFB703);
      case 'EXCESO_AGUA':
        return const Color(0xFF74B9FF);
      case 'FRIO_CRITICO':
        return const Color(0xFF90CAF9);
      case 'CALOR_CRITICO':
        return const Color(0xFFE63946);
      case 'AGUA_SALINA':
        return const Color(0xFFFFD166);
      case 'HUMEDAD_BAJA':
        return const Color(0xFFFFB703);
      case 'CONDICION_MIXTA':
        return const Color(0xFFE63946);
      default:
        return const Color(0xFF95D5B2);
    }
  }

  IconData _iconoEstado(String estado) {
    switch (estado) {
      case 'OPTIMO':
        return Icons.check_circle;
      case 'SEQUIA':
        return Icons.wb_sunny;
      case 'EXCESO_AGUA':
        return Icons.water;
      case 'FRIO_CRITICO':
        return Icons.ac_unit;
      case 'CALOR_CRITICO':
        return Icons.local_fire_department;
      case 'AGUA_SALINA':
        return Icons.science;
      case 'HUMEDAD_BAJA':
        return Icons.air;
      case 'CONDICION_MIXTA':
        return Icons.warning;
      default:
        return Icons.help_outline;
    }
  }

  Color _colorNivel(String nivel) {
    switch (nivel) {
      case 'OPTIMO':
        return const Color(0xFF52B788);
      case 'BAJO':
      case 'ALTO':
        return const Color(0xFFFFB703);
      case 'CRITICO':
        return const Color(0xFFE63946);
      default:
        return const Color(0xFF95D5B2);
    }
  }

  String _labelSensor(String key) {
    switch (key) {
      case 'humedad_suelo':
        return 'Humedad Suelo';
      case 'temperatura':
        return 'Temperatura';
      case 'humedad_aire':
        return 'Humedad Aire';
      case 'tds':
        return 'TDS Agua';
      default:
        return key;
    }
  }

  String _unidadSensor(String key) {
    switch (key) {
      case 'humedad_suelo':
      case 'humedad_aire':
        return '%';
      case 'temperatura':
        return '°C';
      case 'tds':
        return ' ppm';
      default:
        return '';
    }
  }

  IconData _iconoSensor(String key) {
    switch (key) {
      case 'humedad_suelo':
        return Icons.water_drop;
      case 'temperatura':
        return Icons.thermostat;
      case 'humedad_aire':
        return Icons.air;
      case 'tds':
        return Icons.science;
      default:
        return Icons.sensors;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: const Color(0xFF0D1B14),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1B14),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF52B788)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Diagnóstico ML',
          style: TextStyle(
            color: Color(0xFF52B788),
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: _cargando ? _buildCargando(cs) : _buildContenido(cs),
      ),
    );
  }

  Widget _buildCargando(ColorScheme cs) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            color: Color(0xFF52B788),
          ),
          const SizedBox(height: 20),
          Text(
            'Esperando análisis ML…',
            style: TextStyle(
              color: cs.secondary,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Asegúrate de que Colab esté corriendo',
            style: TextStyle(
              color: cs.secondary.withOpacity(0.5),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContenido(ColorScheme cs) {
    final p = _prediccion!;
    final color = _colorEstado(p.estado);
    final ahora = DateTime.fromMillisecondsSinceEpoch(
      p.timestamp * 1000,
    );
    final hora =
        '${ahora.hour.toString().padLeft(2, '0')}:${ahora.minute.toString().padLeft(2, '0')}';

    return FadeTransition(
      opacity: _fadeAnim,
      child: CustomScrollView(
        slivers: [
          // ── Header ────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Row(
                children: [
                  Icon(Icons.eco, color: color, size: 28),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Diagnóstico del Cultivo',
                          style: TextStyle(
                            color: cs.onSurface,
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Text(
                          '${p.cultivo} • ${p.etapa} • $hora',
                          style: TextStyle(
                            color: cs.secondary.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Salud general ─────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: _SaludCard(
                salud: p.saludGeneral,
                estado: p.estado,
                color: color,
                icono: _iconoEstado(p.estado),
                confianza: p.confianza,
              ),
            ),
          ),

          // ── Recomendación principal ────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: _RecomendacionCard(
                recomendacion: p.recomendacion,
                color: color,
              ),
            ),
          ),

          // ── Detalle por sensor ─────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 8),
              child: Text(
                'Estado por sensor',
                style: TextStyle(
                  color: cs.secondary.withOpacity(0.6),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final entry = p.detalle.entries.toList()[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: _SensorDetalleCard(
                      nombre: _labelSensor(entry.key),
                      valor: entry.value.valor,
                      unidad: _unidadSensor(entry.key),
                      nivel: entry.value.nivel,
                      emoji: entry.value.emoji,
                      icono: _iconoSensor(entry.key),
                      colorNivel: _colorNivel(entry.value.nivel),
                    ),
                  );
                },
                childCount: p.detalle.length,
              ),
            ),
          ),

          // ── Rangos óptimos ────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
              child: _RangosCard(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
//  WIDGETS
// ─────────────────────────────────────────────

class _SaludCard extends StatelessWidget {
  final int salud;
  final String estado;
  final Color color;
  final IconData icono;
  final double confianza;

  const _SaludCard({
    required this.salud,
    required this.estado,
    required this.color,
    required this.icono,
    required this.confianza,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: color.withOpacity(0.15),
                ),
                child: Icon(icono, color: color, size: 30),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      estado.replaceAll('_', ' '),
                      style: TextStyle(
                        color: color,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Text(
                      'Confianza: ${(confianza * 100).toStringAsFixed(0)}%',
                      style: TextStyle(
                        color: color.withOpacity(0.7),
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Text(
                    '$salud%',
                    style: TextStyle(
                      color: color,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                  Text(
                    'salud',
                    style: TextStyle(
                      color: color.withOpacity(0.6),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              value: salud / 100,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}

class _RecomendacionCard extends StatelessWidget {
  final String recomendacion;
  final Color color;

  const _RecomendacionCard({
    required this.recomendacion,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2D22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.tips_and_updates,
                color: color,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                'Recomendación',
                style: TextStyle(
                  color: color.withOpacity(0.8),
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            recomendacion,
            style: const TextStyle(
              color: Color(0xFFB7D9C2),
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

class _SensorDetalleCard extends StatelessWidget {
  final String nombre;
  final double valor;
  final String unidad;
  final String nivel;
  final String emoji;
  final IconData icono;
  final Color colorNivel;

  const _SensorDetalleCard({
    required this.nombre,
    required this.valor,
    required this.unidad,
    required this.nivel,
    required this.emoji,
    required this.icono,
    required this.colorNivel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2D22),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: colorNivel.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(icono, color: colorNivel, size: 22),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              nombre,
              style: const TextStyle(
                color: Color(0xFFB7D9C2),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Text(
            '${valor.toStringAsFixed(1)}$unidad',
            style: const TextStyle(
              color: Color(0xFFD8F3DC),
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: colorNivel.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '$emoji $nivel',
              style: TextStyle(
                color: colorNivel,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RangosCard extends StatelessWidget {
  const _RangosCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2D22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF52B788).withOpacity(0.15),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(
                Icons.info_outline,
                color: Color(0xFF52B788),
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                'Rangos óptimos • Arándano en germinación',
                style: TextStyle(
                  color: Color(0xFF52B788),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _filaRango('Humedad suelo', '60 – 80%'),
          _filaRango('Temperatura', '15 – 24°C'),
          _filaRango('Humedad aire', '55 – 80%'),
          _filaRango('TDS agua', '100 – 400 ppm'),
        ],
      ),
    );
  }

  Widget _filaRango(String label, String rango) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: Color(0xFF7BAF8A),
              fontSize: 13,
            ),
          ),
          Text(
            rango,
            style: const TextStyle(
              color: Color(0xFFD8F3DC),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
