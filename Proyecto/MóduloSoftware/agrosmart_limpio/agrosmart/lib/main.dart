import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'dart:async';
import 'dart:math';
import 'recomendaciones_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ─────────────────────────────────────────────
//  FIREBASE OPTIONS  (reemplaza con los tuyos)
// ─────────────────────────────────────────────
const firebaseOptions = FirebaseOptions(
  apiKey: 'AlzaSyCr6fRjRGNi9TYRJMS5sKRAAJ5gkyLiA1I',
  appId: '1:458730288738:ios:ed86c8670b491ded24833b',
  messagingSenderId: '458730288738',
  projectId: 'agrosmart-33c0d',
  databaseURL: 'https://agrosmart-33c0d-default-rtdb.firebaseio.com',
  storageBucket: 'agrosmart-33c0d.firebasestorage.app',
);

// ─────────────────────────────────────────────
//  MODELOS DE DATOS
// ─────────────────────────────────────────────
class SensorData {
  final double humedadSuelo;
  final double temperatura;
  final double humedadAire;
  final double tds;
  final bool bombaActiva;
  final int timestamp;

  SensorData({
    required this.humedadSuelo,
    required this.temperatura,
    required this.humedadAire,
    required this.tds,
    required this.bombaActiva,
    required this.timestamp,
  });

  factory SensorData.fromMap(Map<dynamic, dynamic> map) {
    return SensorData(
      humedadSuelo: (map['humedad_suelo'] ?? 0).toDouble(),
      temperatura: (map['temperatura'] ?? 0).toDouble(),
      humedadAire: (map['humedad_aire'] ?? 0).toDouble(),
      tds: (map['tds'] ?? 0).toDouble(),
      bombaActiva: map['bomba_activa'] ?? false,
      timestamp: map['timestamp'] ?? 0,
    );
  }
}

class MLPrediction {
  final String estado; // "OPTIMO", "SECO", "EXCESO", "ALERTA_TDS"
  final double confianza; // 0.0 – 1.0
  final String recomendacion;
  final int timestamp;

  MLPrediction({
    required this.estado,
    required this.confianza,
    required this.recomendacion,
    required this.timestamp,
  });

  factory MLPrediction.fromMap(Map<dynamic, dynamic> map) {
    return MLPrediction(
      estado: map['estado'] ?? 'DESCONOCIDO',
      confianza: (map['confianza'] ?? 0).toDouble(),
      recomendacion: map['recomendacion'] ?? 'Sin datos',
      timestamp: map['timestamp'] ?? 0,
    );
  }
}

// ─────────────────────────────────────────────
//  MAIN
// ─────────────────────────────────────────────
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: firebaseOptions);
  runApp(const RiegoApp());
}

class RiegoApp extends StatelessWidget {
  const RiegoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AgroSmart',
      debugShowCheckedModeBanner: false,
      theme: _buildTheme(),
      home: const DashboardScreen(),
    );
  }

  ThemeData _buildTheme() {
    const seed = Color(0xFF2D6A4F); // verde bosque
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: seed,
        brightness: Brightness.dark,
        primary: const Color(0xFF52B788),
        secondary: const Color(0xFF95D5B2),
        surface: const Color(0xFF0D1B14),
        onSurface: const Color(0xFFD8F3DC),
      ),
      scaffoldBackgroundColor: const Color(0xFF0D1B14),
      fontFamily: 'monospace',
    );
  }
}

// ─────────────────────────────────────────────
//  DASHBOARD SCREEN
// ─────────────────────────────────────────────
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final _db = FirebaseDatabase.instance.ref();

  SensorData? _sensor;
  MLPrediction? _prediccion;
  List<SensorData> _historial = [];

  StreamSubscription? _sensorSub;
  StreamSubscription? _mlSub;
  StreamSubscription? _historialSub;

  late AnimationController _pulseCtrl;
  late Animation<double> _pulseAnim;

  bool _cargando = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );
    _iniciarStreams();
  }

  void _iniciarStreams() {
    // Stream datos en tiempo real del ESP32
    _sensorSub = _db.child('sensores/actual').onValue.listen(
      (event) {
        if (event.snapshot.value != null) {
          final map = event.snapshot.value as Map<dynamic, dynamic>;
          setState(() {
            _sensor = SensorData.fromMap(map);
            _cargando = false;
            _error = null;
          });
        }
      },
      onError: (e) => setState(() => _error = e.toString()),
    );

    // Stream predicción ML desde Colab
    _mlSub = _db.child('ml/prediccion_actual').onValue.listen(
      (event) {
        if (event.snapshot.value != null) {
          final map = event.snapshot.value as Map<dynamic, dynamic>;
          setState(() => _prediccion = MLPrediction.fromMap(map));
        }
      },
    );

    // Historial últimas 24 lecturas
    _historialSub = _db
        .child('sensores/historial')
        .orderByChild('timestamp')
        .limitToLast(24)
        .onValue
        .listen(
      (event) {
        if (event.snapshot.value != null) {
          final map = event.snapshot.value as Map<dynamic, dynamic>;
          final lista = map.values
              .map((v) => SensorData.fromMap(v as Map))
              .toList()
            ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
          setState(() => _historial = lista);
        }
      },
    );
  }

  @override
  void dispose() {
    _sensorSub?.cancel();
    _mlSub?.cancel();
    _historialSub?.cancel();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    if (_cargando) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _pulseAnim,
                builder: (_, __) => Opacity(
                  opacity: _pulseAnim.value,
                  child: SvgPicture.asset(
                    'assets/logo.svg',
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Conectando sensores…',
                style: TextStyle(color: cs.secondary, fontSize: 16),
              ),
            ],
          ),
        ),
      );
    }

    if (_error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.wifi_off, size: 64, color: Color(0xFFE63946)),
                const SizedBox(height: 16),
                Text(
                  'Error de conexión',
                  style: TextStyle(
                    color: cs.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  _error!,
                  style: TextStyle(color: cs.secondary, fontSize: 12),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    final s = _sensor!;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Header ──────────────────────────────
            SliverToBoxAdapter(child: _buildHeader(s, cs)),

            // ── Predicción ML ───────────────────────
            if (_prediccion != null)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: _MLCard(pred: _prediccion!),
                ),
              ),

            // ── Grid de sensores ────────────────────
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverGrid(
                delegate: SliverChildListDelegate([
                  _SensorCard(
                    titulo: 'Humedad Suelo',
                    valor: '${s.humedadSuelo.toStringAsFixed(1)}%',
                    icono: Icons.water_drop,
                    color: _colorHumedadSuelo(s.humedadSuelo),
                    sub: _labelHumedadSuelo(s.humedadSuelo),
                    progreso: s.humedadSuelo / 100,
                  ),
                  _SensorCard(
                    titulo: 'Temperatura',
                    valor: '${s.temperatura.toStringAsFixed(1)}°C',
                    icono: Icons.thermostat,
                    color: _colorTemp(s.temperatura),
                    sub: _labelTemp(s.temperatura),
                    progreso: (s.temperatura.clamp(0, 50)) / 50,
                  ),
                  _SensorCard(
                    titulo: 'Hum. Aire',
                    valor: '${s.humedadAire.toStringAsFixed(1)}%',
                    icono: Icons.air,
                    color: const Color(0xFF74B9FF),
                    sub: _labelHumAire(s.humedadAire),
                    progreso: s.humedadAire / 100,
                  ),
                  _SensorCard(
                    titulo: 'TDS Agua',
                    valor: '${s.tds.toStringAsFixed(0)} ppm',
                    icono: Icons.science,
                    color: _colorTDS(s.tds),
                    sub: _labelTDS(s.tds),
                    progreso: (s.tds.clamp(0, 1500)) / 1500,
                  ),
                ]),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.0,
                ),
              ),
            ),

            // ── Estado bomba ────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: _BombaCard(activa: s.bombaActiva, pulse: _pulseAnim),
              ),
            ),

            // ── Mini gráfico historial ───────────────
            if (_historial.isNotEmpty)
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                  child: _HistorialCard(historial: _historial),
                ),
              ),

            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }

  // ── Header con estado general ──────────────────────
  Widget _buildHeader(SensorData s, ColorScheme cs) {
    final ahora = DateTime.fromMillisecondsSinceEpoch(s.timestamp * 1000);
    final hora = '${ahora.hour.toString().padLeft(2, '0')}:'
        '${ahora.minute.toString().padLeft(2, '0')}';

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
      child: Row(
        children: [
          const _LeafIcon(size: 36),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'AgroSmart',
                  style: TextStyle(
                    color: cs.primary,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                  ),
                ),
                Text(
                  'ESP32-S3 • última lectura $hora',
                  style: TextStyle(
                    color: cs.secondary.withOpacity(0.7),
                    fontSize: 12,
                  ),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const RecomendacionesScreen(),
                    ),
                  ),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF74B9FF).withOpacity(0.15),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                          color: const Color(0xFF74B9FF).withOpacity(0.4)),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.psychology,
                            color: Color(0xFF74B9FF), size: 14),
                        SizedBox(width: 4),
                        Text('ML',
                            style: TextStyle(
                                color: Color(0xFF74B9FF),
                                fontSize: 11,
                                fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // indicador live
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: const Color(0xFF52B788).withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFF52B788).withOpacity(0.4),
              ),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _PulseDot(),
                SizedBox(width: 6),
                Text(
                  'LIVE',
                  style: TextStyle(
                    color: Color(0xFF52B788),
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Helpers de color y etiqueta ───────────────────
  Color _colorHumedadSuelo(double v) {
    if (v < 25) return const Color(0xFFE63946);
    if (v < 45) return const Color(0xFF52B788);
    if (v < 75) return const Color(0xFF74B9FF);
    return const Color(0xFFE63946);
  }

  String _labelHumedadSuelo(double v) {
    if (v < 25) return 'Suelo seco';
    if (v < 45) return 'Nivel ideal';
    if (v < 75) return 'Húmedo';
    return 'Saturado';
  }

  Color _colorTemp(double v) {
    if (v < 18) return const Color(0xFF74B9FF);
    if (v <= 28) return const Color(0xFF52B788);
    return const Color(0xFFFFB703);
  }

  String _labelTemp(double v) {
    if (v < 18) return 'Frío';
    if (v <= 28) return 'Óptimo';
    return 'Caluroso';
  }

  String _labelHumAire(double v) {
    if (v < 40) return 'Baja';
    if (v <= 70) return 'Normal';
    return 'Alta';
  }

  Color _colorTDS(double v) {
    if (v < 300) return const Color(0xFF74B9FF);
    if (v < 600) return const Color(0xFF52B788);
    if (v < 1000) return const Color(0xFFFFB703);
    return const Color(0xFFE63946);
  }

  String _labelTDS(double v) {
    if (v < 300) return 'Agua limpia';
    if (v < 600) return 'Normal';
    if (v < 1000) return 'Alta mineral';
    return 'Muy alta ⚠';
  }
}

// ─────────────────────────────────────────────
//  WIDGETS REUTILIZABLES
// ─────────────────────────────────────────────

class _LeafIcon extends StatelessWidget {
  final double size;
  const _LeafIcon({required this.size});

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.eco, size: size, color: const Color(0xFF52B788));
  }
}

class _PulseDot extends StatefulWidget {
  const _PulseDot();

  @override
  State<_PulseDot> createState() => _PulseDotState();
}

class _PulseDotState extends State<_PulseDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _c;

  @override
  void initState() {
    super.initState();
    _c = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __) => Container(
        width: 8,
        height: 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Color.lerp(
            const Color(0xFF52B788),
            const Color(0xFF95D5B2),
            _c.value,
          ),
        ),
      ),
    );
  }
}

// ── Tarjeta de sensor ─────────────────────────────
class _SensorCard extends StatelessWidget {
  final String titulo;
  final String valor;
  final IconData icono;
  final Color color;
  final String sub;
  final double progreso;

  const _SensorCard({
    required this.titulo,
    required this.valor,
    required this.icono,
    required this.color,
    required this.sub,
    required this.progreso,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2D22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withOpacity(0.25), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icono, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  titulo,
                  style: TextStyle(
                    color: color.withOpacity(0.8),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            valor,
            style: const TextStyle(
              color: Color(0xFFD8F3DC),
              fontSize: 26,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progreso.clamp(0.0, 1.0),
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            sub,
            style: TextStyle(
              color: color.withOpacity(0.7),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tarjeta predicción ML ─────────────────────────
class _MLCard extends StatelessWidget {
  final MLPrediction pred;
  const _MLCard({required this.pred});

  Color get _color {
    switch (pred.estado) {
      case 'OPTIMO':
        return const Color(0xFF52B788);
      case 'SECO':
        return const Color(0xFFFFB703);
      case 'EXCESO':
        return const Color(0xFF74B9FF);
      case 'ALERTA_TDS':
        return const Color(0xFFE63946);
      default:
        return const Color(0xFF95D5B2);
    }
  }

  IconData get _icono {
    switch (pred.estado) {
      case 'OPTIMO':
        return Icons.check_circle;
      case 'SECO':
        return Icons.wb_sunny;
      case 'EXCESO':
        return Icons.water;
      case 'ALERTA_TDS':
        return Icons.warning;
      default:
        return Icons.help_outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pct = (pred.confianza * 100).toStringAsFixed(0);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _color.withOpacity(0.35), width: 1.5),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(_icono, color: _color, size: 22),
              const SizedBox(width: 10),
              Text(
                'Diagnóstico ML',
                style: TextStyle(
                  color: _color.withOpacity(0.7),
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: _color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  '$pct% confianza',
                  style: TextStyle(
                    color: _color,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            pred.estado.replaceAll('_', ' '),
            style: TextStyle(
              color: _color,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            pred.recomendacion,
            style: const TextStyle(
              color: Color(0xFFB7D9C2),
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tarjeta bomba ────────────────────────────────
class _BombaCard extends StatelessWidget {
  final bool activa;
  final Animation<double> pulse;

  const _BombaCard({required this.activa, required this.pulse});

  @override
  Widget build(BuildContext context) {
    final color = activa ? const Color(0xFF74B9FF) : const Color(0xFF2D6A4F);
    final label = activa ? 'RIEGO ACTIVO' : 'BOMBA INACTIVA';
    final sub = activa
        ? 'El sistema está irrigando el cultivo'
        : 'El suelo no requiere riego en este momento';

    return AnimatedBuilder(
      animation: pulse,
      builder: (_, __) => Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: activa
              ? const Color(0xFF74B9FF).withOpacity(0.08 * pulse.value + 0.04)
              : const Color(0xFF1B2D22),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: color.withOpacity(activa ? 0.5 * pulse.value + 0.2 : 0.2),
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color.withOpacity(0.15),
              ),
              child: Icon(
                activa ? Icons.water_drop : Icons.water_drop_outlined,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      color: color,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    sub,
                    style: const TextStyle(
                      color: Color(0xFF7BAF8A),
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Historial mini-chart ─────────────────────────
class _HistorialCard extends StatelessWidget {
  final List<SensorData> historial;
  const _HistorialCard({required this.historial});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF1B2D22),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF52B788).withOpacity(0.2),
          width: 1.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Historial • últimas lecturas',
            style: TextStyle(
              color: Color(0xFF7BAF8A),
              fontSize: 12,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: CustomPaint(
              painter: _MiniChartPainter(
                datos: historial.map((s) => s.humedadSuelo).toList(),
                color: const Color(0xFF52B788),
              ),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'hace 48 min',
                style: TextStyle(color: Color(0xFF4A7C5A), fontSize: 10),
              ),
              Text(
                'Humedad del suelo (%)',
                style: TextStyle(color: Color(0xFF4A7C5A), fontSize: 10),
              ),
              Text(
                'ahora',
                style: TextStyle(color: Color(0xFF4A7C5A), fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniChartPainter extends CustomPainter {
  final List<double> datos;
  final Color color;

  _MiniChartPainter({required this.datos, required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    if (datos.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final fillPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [color.withOpacity(0.3), color.withOpacity(0.0)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    final minV = datos.reduce(min);
    final maxV = datos.reduce(max);
    final rango = (maxV - minV).abs().clamp(1.0, double.infinity);

    double xStep = size.width / (datos.length - 1);

    Path linePath = Path();
    Path fillPath = Path();

    for (int i = 0; i < datos.length; i++) {
      final x = i * xStep;
      final y = size.height - ((datos[i] - minV) / rango) * size.height;

      if (i == 0) {
        linePath.moveTo(x, y);
        fillPath.moveTo(x, size.height);
        fillPath.lineTo(x, y);
      } else {
        linePath.lineTo(x, y);
        fillPath.lineTo(x, y);
      }
    }

    fillPath.lineTo((datos.length - 1) * xStep, size.height);
    fillPath.close();

    canvas.drawPath(fillPath, fillPaint);
    canvas.drawPath(linePath, paint);

    // punto final destacado
    if (datos.isNotEmpty) {
      final lastX = (datos.length - 1) * xStep;
      final lastY = size.height - ((datos.last - minV) / rango) * size.height;
      canvas.drawCircle(
        Offset(lastX, lastY),
        4,
        Paint()..color = color,
      );
    }
  }

  @override
  bool shouldRepaint(_MiniChartPainter old) => old.datos != datos;
}
