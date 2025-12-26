import 'package:flutter/material.dart';
import 'dart:math';

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);

// Warna Kustom
const Color gaugeBlue = Color(0xFF1976D2);
const Color gaugeOrange = Color(0xFFFF9800);
const Color gaugeGreen = Color(0xFF4CAF50);
const Color gaugeRed = Color(0xFFD32F2F);
const Color gaugePink = Color(0xFFC2185B);
const Color gaugeYellow = Color(0xFFFFEB3B);

// ----------------------------------------------------
// 1. Gauge Painter (Untuk menggambar busur)
// ----------------------------------------------------

class GaugePainter extends CustomPainter {
  final double value; // Nilai 0.0 sampai 1.0
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final bool isSemicircle;

  GaugePainter({
    required this.value,
    required this.color,
    this.backgroundColor = const Color(0xFFE0E0E0),
    this.strokeWidth = 10.0,
    this.isSemicircle = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, radius);

    // Sudut awal dan akhir
    final double startAngle = isSemicircle ? pi : -pi / 2;
    final double sweepAngle = isSemicircle ? pi * value : 2 * pi * value;

    // 1. Busur Belakang (Background)
    final Paint backgroundPaint = Paint()
      ..color = backgroundColor.withOpacity(isSemicircle ? 0.3 : 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    double backgroundSweep = isSemicircle ? pi : 2 * pi;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      backgroundSweep,
      false,
      backgroundPaint,
    );

    // 2. Busur Nilai (Value)
    final Paint valuePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - strokeWidth / 2),
      startAngle,
      sweepAngle,
      false,
      valuePaint,
    );
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) {
    return oldDelegate.value != value || oldDelegate.color != color;
  }
}

// ----------------------------------------------------
// 2. Widget Gauge Dasar (Diperbarui untuk Animasi)
// ----------------------------------------------------

class GaugeWidget extends StatelessWidget {
  // Menerima nilai animasi
  final Animation<double> valueAnimation;
  final Color color;
  final Widget? centerContent;
  final double size;
  final double strokeWidth;
  final bool isSemicircle;
  final Color? backgroundColor;

  const GaugeWidget({
    super.key,
    required this.valueAnimation,
    required this.color,
    this.centerContent,
    this.size = 150,
    this.strokeWidth = 12,
    this.isSemicircle = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext buildContext) {
    return AnimatedBuilder(
      // Menggambar ulang setiap kali nilai animasi berubah
      animation: valueAnimation,
      builder: (context, child) {
        final currentValue = valueAnimation.value;

        // Tentukan konten default jika centerContent tidak disediakan
        final defaultCenterContent = Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${(currentValue * 100).toInt()}%', // Nilai persentase yang dianimasikan
              style: TextStyle(
                fontSize: isSemicircle ? 24 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            if (!isSemicircle)
              const Text(
                'amount of something',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
          ],
        );

        return Container(
          width: size,
          height: isSemicircle ? size / 2 : size,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Custom Painter (Menggunakan nilai animasi)
              SizedBox(
                width: size,
                height: isSemicircle ? size : size,
                child: CustomPaint(
                  painter: GaugePainter(
                    value: currentValue,
                    color: color,
                    backgroundColor: backgroundColor ?? Colors.grey.shade200,
                    strokeWidth: strokeWidth,
                    isSemicircle: isSemicircle,
                  ),
                ),
              ),

              // Konten Tengah
              // Jika centerContent diset, tampilkan, jika tidak, tampilkan default
              centerContent ?? defaultCenterContent,
            ],
          ),
        );
      },
    );
  }
}

// ----------------------------------------------------
// 3. Gauge Page (Halaman Utama)
// ----------------------------------------------------

class GaugePage extends StatefulWidget {
  const GaugePage({super.key});

  @override
  State<GaugePage> createState() => _GaugePageState();
}

class _GaugePageState extends State<GaugePage> {
  // Target nilai yang di-animasikan
  double _mainGaugeTargetValue = 0.0;

  // Widget Pembantu: Judul Bagian Ungu
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 12.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: framework7Purple,
        ),
      ),
    );
  }

  // Widget Pembantu: Tombol Persentase Interaktif
  Widget _buildPercentButton(String label, double value) {
    final bool isSelected =
        (_mainGaugeTargetValue * 100).toInt() == (value * 100).toInt();

    return Expanded(
      child: Container(
        height: 40,
        margin: EdgeInsets.only(right: label != '100%' ? 4.0 : 0),
        child: ElevatedButton(
          onPressed: () {
            setState(() {
              _mainGaugeTargetValue =
                  value; // Mengatur nilai target animasi baru
            });
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? framework7Purple : Colors.white,
            foregroundColor: isSelected ? Colors.white : framework7Purple,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
              side: BorderSide(
                color: isSelected ? framework7Purple : Colors.grey.shade400,
                width: 1.0,
              ),
            ),
            elevation: 0,
            padding: EdgeInsets.zero,
          ),
          child: Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight + 1.0),
        child: Container(
          decoration: const BoxDecoration(
            color: lightPurpleBackground,
            border: Border(bottom: BorderSide(color: dividerColor, width: 1.0)),
          ),
          child: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Gauge',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Teks Pengantar
            const Padding(
              padding: EdgeInsets.only(bottom: 24.0),
              child: Text(
                'Framework7 comes with Gauge component. It produces nice looking fully responsive SVG gauges.',
                style: TextStyle(fontSize: 16, height: 1.4),
              ),
            ),

            // ----------------------------------------------------
            // GAUGE UTAMA INTERAKTIF (DENGAN ANIMASI SMOOTH)
            // ----------------------------------------------------
            Center(
              child: TweenAnimationBuilder<double>(
                // Widget yang menangani animasi
                tween: Tween<double>(begin: 0, end: _mainGaugeTargetValue),
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                builder: (BuildContext context, double value, Widget? child) {
                  return GaugeWidget(
                    valueAnimation: AlwaysStoppedAnimation(
                      value,
                    ), // Memberikan nilai animasi
                    color: gaugeBlue,
                    size: 200,
                    strokeWidth: 15,
                    centerContent: Column(
                      // Konten Tengah dianimasikan berdasarkan 'value'
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '${(value * 100).toInt()}%',
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: gaugeBlue,
                          ),
                        ),
                        const Text(
                          'amount of something',
                          style: TextStyle(fontSize: 14, color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),

            // Tombol Persentase
            Row(
              children: [
                _buildPercentButton('0%', 0.0),
                _buildPercentButton('25%', 0.25),
                _buildPercentButton('50%', 0.50),
                _buildPercentButton('75%', 0.75),
                _buildPercentButton('100%', 1.0),
              ],
            ),
            const SizedBox(height: 30),

            // ----------------------------------------------------
            // 1. Circle Gauges (Nilai Tetap)
            // ----------------------------------------------------
            _buildSectionTitle('Circle Gauges'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Gauge 1: Orange 44%
                GaugeWidget(
                  valueAnimation: AlwaysStoppedAnimation(0.44),
                  color: gaugeOrange,
                  size: 140,
                  centerContent: Text(
                    '44%',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: gaugeOrange,
                    ),
                  ),
                ),
                // Gauge 2: Green Budget
                GaugeWidget(
                  valueAnimation: AlwaysStoppedAnimation(0.12),
                  color: gaugeGreen,
                  size: 140,
                  centerContent: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$120',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: gaugeGreen,
                        ),
                      ),
                      Text(
                        'of \$1000 budget',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ----------------------------------------------------
            // 2. Semicircle Gauges (Nilai Tetap)
            // ----------------------------------------------------
            _buildSectionTitle('Semicircle Gauges'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Gauge 1: Red 30%
                GaugeWidget(
                  valueAnimation: AlwaysStoppedAnimation(0.30),
                  color: gaugeRed,
                  size: 140,
                  isSemicircle: true,
                  strokeWidth: 8,
                ),
                // Gauge 2: Pink 30kg
                GaugeWidget(
                  valueAnimation: AlwaysStoppedAnimation(
                    0.5,
                  ), // 30kg dari 60kg = 50%
                  color: gaugePink,
                  size: 140,
                  isSemicircle: true,
                  strokeWidth: 8,
                  centerContent: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '30kg',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: gaugePink,
                        ),
                      ),
                      Text(
                        'of 60kg total',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            // ----------------------------------------------------
            // 3. Customization (Nilai Tetap)
            // ----------------------------------------------------
            _buildSectionTitle('Customization'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Gauge 1: Yellow/Green (Custom Colors)
                GaugeWidget(
                  valueAnimation: AlwaysStoppedAnimation(0.35),
                  color: gaugeGreen,
                  size: 140,
                  strokeWidth: 20,
                  backgroundColor: gaugeYellow.withOpacity(0.5),
                  centerContent: Text(
                    '35%',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: gaugeYellow,
                    ),
                  ),
                ),
                // Gauge 2: Orange Budget Spent
                GaugeWidget(
                  valueAnimation: AlwaysStoppedAnimation(0.67),
                  color: gaugeOrange,
                  size: 140,
                  strokeWidth: 20,
                  centerContent: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$670',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: gaugeOrange,
                        ),
                      ),
                      Text(
                        'of \$1000 spent',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Gauge 3: Semicircle Custom Yellow
                GaugeWidget(
                  valueAnimation: AlwaysStoppedAnimation(0.50),
                  color: gaugeYellow,
                  size: 140,
                  isSemicircle: true,
                  strokeWidth: 15,
                  centerContent: Text(
                    '50%',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: gaugeYellow,
                    ),
                  ),
                ),
                // Gauge 4: Semicircle Custom Orange Text
                GaugeWidget(
                  valueAnimation: AlwaysStoppedAnimation(0.77),
                  color: gaugeOrange,
                  size: 140,
                  isSemicircle: true,
                  strokeWidth: 15,
                  centerContent: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$770',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: gaugeOrange,
                        ),
                      ),
                      Text(
                        'spent so far',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
