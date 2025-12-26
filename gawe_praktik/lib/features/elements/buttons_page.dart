import 'package:flutter/material.dart';

class ButtonsPage extends StatefulWidget {
  const ButtonsPage({super.key});

  @override
  State<ButtonsPage> createState() => _ButtonsPageState();
}

class _ButtonsPageState extends State<ButtonsPage> {
  // Definisi Warna Framework7
  static const Color framework7Purple = Color(0xFF9147FF);
  static const Color lightPurpleBackground = Color(0xFFF7F2FF);
  static const Color dividerColor = Color(0xFFEFEFF4);
  static const Color veryLightPurple = Color(0xFFF3E5F5);

  // Gaya untuk Content Block (Kotak Samar)
  static const Color contentBlockColor = lightPurpleBackground;
  static const Color contentBlockBorderColor = Color(0xFFEFEFF4);

  // --- State untuk Preloader Buttons (No. 9) ---
  bool _isLoading1 = false;
  bool _isLoading2 = false;

  // --- FUNGSI KLIK & SIMULASI LOADING ---
  void _onLoadButtonPressed(int buttonIndex) async {
    if ((buttonIndex == 1 && _isLoading1) ||
        (buttonIndex == 2 && _isLoading2)) {
      return;
    }

    setState(() {
      if (buttonIndex == 1) {
        _isLoading1 = true;
      } else {
        _isLoading2 = true;
      }
    });

    // Simulasi proses asinkron selama 3 detik
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      if (buttonIndex == 1) {
        _isLoading1 = false;
      } else {
        _isLoading2 = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // --- AppBar (Header Halaman) ---
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
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text(
              'Buttons',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            centerTitle: false,
          ),
        ),
      ),

      // --- Body Halaman ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ----------------------------------------------------
            // 1. Usual Buttons
            // ----------------------------------------------------
            _buildSectionTitle('Usual Buttons'),
            _buildContentBlock(
              children: [
                _buildButtonRow(
                  context,
                  style: ButtonStyle.usual,
                  fillColor: Colors.transparent,
                  textColor: framework7Purple,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 2. Tonal Buttons
            // ----------------------------------------------------
            _buildSectionTitle('Tonal Buttons'),
            _buildContentBlock(
              children: [
                _buildButtonRow(
                  context,
                  style: ButtonStyle.tonal,
                  fillColor: veryLightPurple,
                  textColor: framework7Purple,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 3. Fill Buttons
            // ----------------------------------------------------
            _buildSectionTitle('Fill Buttons'),
            _buildContentBlock(
              children: [
                _buildButtonRow(
                  context,
                  style: ButtonStyle.fill,
                  fillColor: framework7Purple,
                  textColor: Colors.white,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 4. Outline Buttons
            // ----------------------------------------------------
            _buildSectionTitle('Outline Buttons'),
            _buildContentBlock(
              children: [
                _buildButtonRow(
                  context,
                  style: ButtonStyle.outline,
                  fillColor: Colors.transparent,
                  textColor: framework7Purple,
                  borderColor: framework7Purple,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 5. Raised Buttons
            // ----------------------------------------------------
            _buildSectionTitle('Raised Buttons'),
            _buildContentBlock(children: [_buildRaisedButtonSection(context)]),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 6. Large Buttons
            // ----------------------------------------------------
            _buildSectionTitle('Large Buttons'),
            _buildContentBlock(children: [_buildLargeButtonSection(context)]),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 7. Small Buttons (Diperbesar)
            // ----------------------------------------------------
            _buildSectionTitle('Small Buttons'),
            _buildContentBlock(
              children: [
                _buildSmallButtonSection(context, overrideSmall: true),
              ],
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 8. Color Buttons
            // ----------------------------------------------------
            _buildSectionTitle('Color Buttons'),
            _buildContentBlock(children: [_buildColorButtonSection(context)]),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 9. Preloader Buttons
            // ----------------------------------------------------
            _buildSectionTitle('Preloader Buttons'),
            _buildContentBlock(
              children: [_buildPreloaderButtonSection(context)],
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 10. Color Fill Buttons (DIKOREKSI)
            // ----------------------------------------------------
            _buildSectionTitle('Color Fill Buttons'),
            _buildContentBlock(
              children: [_buildColorFillButtonSection(context)],
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // --- WIDGET PEMBANTU: Content Block (Kotak Samar) ---
  Widget _buildContentBlock({required List<Widget> children}) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      decoration: BoxDecoration(
        color: contentBlockColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: contentBlockBorderColor, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.15),
            blurRadius: 4,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  // --- UTILITIES (Tidak diubah) ---
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
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

  // 5. Raised Buttons Section
  Widget _buildRaisedButtonSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: <Widget>[
            _buildButtonExpanded(
              'Button',
              ButtonStyle.raised,
              fillColor: Colors.white,
              textColor: Colors.black87,
              isRaised: true,
            ),
            _buildButtonExpanded(
              'Fill',
              ButtonStyle.fill,
              fillColor: framework7Purple,
              textColor: Colors.white,
              isRaised: true,
            ),
            _buildButtonExpanded(
              'Outline',
              ButtonStyle.outline,
              fillColor: Colors.white,
              textColor: framework7Purple,
              borderColor: framework7Purple,
              isRaised: true,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: <Widget>[
            _buildButtonExpanded(
              'Round',
              ButtonStyle.raised,
              fillColor: Colors.white,
              textColor: Colors.black87,
              isRound: false,
              isRaised: true,
            ),
            _buildButtonExpanded(
              'Fill',
              ButtonStyle.fill,
              fillColor: framework7Purple,
              textColor: Colors.white,
              isRaised: true,
              isRound: false,
            ),
            _buildButtonExpanded(
              'Outline',
              ButtonStyle.outline,
              fillColor: Colors.white,
              textColor: framework7Purple,
              borderColor: framework7Purple,
              isRaised: true,
              isRound: false,
            ),
          ],
        ),
      ],
    );
  }

  // 6. Large Buttons Section
  Widget _buildLargeButtonSection(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            _buildButtonExpanded(
              'BUTTON',
              ButtonStyle.usual,
              textColor: framework7Purple,
              height: 48,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            _buildButtonExpanded(
              'FILL',
              ButtonStyle.fill,
              fillColor: framework7Purple,
              textColor: Colors.white,
              height: 48,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildButtonExpanded(
              'RAISED',
              ButtonStyle.raised,
              textColor: framework7Purple,
              isRaised: true,
              height: 48,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            _buildButtonExpanded(
              'RAISED FILL',
              ButtonStyle.fill,
              fillColor: framework7Purple,
              textColor: Colors.white,
              isRaised: true,
              height: 48,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildButtonExpanded(
              'ROUND',
              ButtonStyle.usual,
              textColor: framework7Purple,
              isRound: false,
              height: 48,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
            _buildButtonExpanded(
              'ROUND FILL',
              ButtonStyle.fill,
              fillColor: framework7Purple,
              textColor: Colors.white,
              isRound: false,
              height: 48,
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ],
        ),
      ],
    );
  }

  // Button Row Standard (Usual, Tonal, Fill, Outline)
  Widget _buildButtonRow(
    BuildContext context, {
    required ButtonStyle style,
    required Color fillColor,
    required Color textColor,
    Color borderColor = Colors.transparent,
    double height = 40.0,
  }) {
    final buttonLabels = ['Button', 'Button', 'Round'];

    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: buttonLabels.map((label) {
          const bool isRoundShape = false;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: _buildCustomButton(
                label,
                style: style,
                fillColor: fillColor,
                textColor: textColor,
                borderColor: borderColor,
                isRound: isRoundShape,
                height: height,
                onPressed: () {
                  print('$label (${style.name}) clicked!');
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  // 7. Small Buttons Section
  Widget _buildSmallButtonSection(
    BuildContext context, {
    bool overrideSmall = false,
  }) {
    final bool smallFlag = !overrideSmall;
    const double defaultHeight = 40.0;

    return Column(
      children: [
        Row(
          children: [
            _buildButtonExpanded(
              'Button',
              ButtonStyle.usual,
              textColor: Colors.black87,
              isSmall: smallFlag,
              height: defaultHeight,
            ),
            _buildButtonExpanded(
              'Outline',
              ButtonStyle.outline,
              textColor: framework7Purple,
              borderColor: framework7Purple,
              isSmall: smallFlag,
              height: defaultHeight,
            ),
            _buildButtonExpanded(
              'Fill',
              ButtonStyle.fill,
              fillColor: framework7Purple,
              textColor: Colors.white,
              isSmall: smallFlag,
              height: defaultHeight,
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildButtonExpanded(
              'Button',
              ButtonStyle.usual,
              textColor: Colors.black87,
              isSmall: smallFlag,
              height: defaultHeight,
            ),
            _buildButtonExpanded(
              'Outline',
              ButtonStyle.outline,
              textColor: framework7Purple,
              borderColor: framework7Purple,
              isSmall: smallFlag,
              height: defaultHeight,
            ),
            _buildButtonExpanded(
              'Fill',
              ButtonStyle.fill,
              fillColor: framework7Purple,
              textColor: Colors.white,
              isSmall: smallFlag,
              height: defaultHeight,
            ),
          ],
        ),
      ],
    );
  }

  // 8. Color Buttons Section
  Widget _buildColorButtonSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: _buildColorButtonRow(['Red', 'Green', 'Blue']),
    );
  }

  Widget _buildColorButtonRow(List<String> colors) {
    final colorMap = {
      'Red': Colors.red,
      'Green': Colors.green[800]!,
      'Blue': Colors.blue,
    };

    return Row(
      children: colors.map((colorName) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: _buildCustomButton(
              colorName,
              style: ButtonStyle.usual,
              fillColor: Colors.transparent,
              textColor: colorMap[colorName]!,
              onPressed: () {
                print('$colorName clicked!');
              },
            ),
          ),
        );
      }).toList(),
    );
  }

  // 9. Preloader Buttons Section
  Widget _buildPreloaderButtonSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 0),
            child: _buildCustomButton(
              'LOAD',
              style: ButtonStyle.usual,
              textColor: framework7Purple,
              borderColor: Colors.transparent,
              height: 48.0,
              isPreloading: _isLoading1,
              onPressed: () => _onLoadButtonPressed(1),
            ),
          ),
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8.0, bottom: 0),
            child: _buildCustomButton(
              'LOAD',
              style: ButtonStyle.fill,
              fillColor: framework7Purple,
              textColor: Colors.white,
              isRaised: true,
              height: 48.0,
              isPreloading: _isLoading2,
              onPressed: () => _onLoadButtonPressed(2),
            ),
          ),
        ),
      ],
    );
  }

  // 10. Color Fill Buttons Section (DIKOREKSI)
  Widget _buildColorFillButtonSection(BuildContext context) {
    final colorData = {
      'Red': Colors.red[800]!,
      'Green': Colors.green[700]!,
      'Blue': Colors.blue[800]!,
      'Pink': Colors.pink,
      'Yellow': Colors.yellow[800]!,
      'Orange': Colors.orange,
      'Black': Colors.black,
      'White': Colors.white,
    };
    final colorNames = colorData.keys.toList();

    return Column(
      children: [
        Row(
          children: colorNames
              .sublist(0, 3)
              .map(
                (name) => _buildColorFillButtonExpanded(name, colorData[name]!),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        Row(
          children: colorNames
              .sublist(3, 6)
              .map(
                (name) => _buildColorFillButtonExpanded(name, colorData[name]!),
              )
              .toList(),
        ),
        const SizedBox(height: 8),
        Row(
          // Baris terakhir hanya untuk Black dan White
          children: [
            _buildColorFillButtonExpanded(
              colorNames[6],
              colorData[colorNames[6]]!,
            ), // Black
            _buildColorFillButtonExpanded(
              colorNames[7],
              colorData[colorNames[7]]!,
            ), // White
            const Spacer(), // Spacer untuk mengisi ruang kosong di sisi kanan
          ],
        ),
      ],
    );
  }

  // Helper untuk Color Fill Buttons (Tidak diubah)
  Widget _buildColorFillButtonExpanded(String text, Color color) {
    final textColor = color == Colors.white ? Colors.black87 : Colors.white;
    final borderColor = color == Colors.white
        ? Colors.grey
        : Colors.transparent;

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0),
        child: _buildCustomButton(
          text,
          style: ButtonStyle.fill,
          fillColor: color,
          textColor: textColor,
          height: 40,
          borderColor: borderColor,
          onPressed: () {
            print('$text clicked!');
          },
        ),
      ),
    );
  }

  // Helper untuk Tombol yang Diperluas dengan Padding (Tidak diubah)
  Widget _buildButtonExpanded(
    String text,
    ButtonStyle style, {
    Color fillColor = Colors.transparent,
    Color textColor = Colors.black87,
    Color borderColor = Colors.transparent,
    bool isRound = false,
    bool isRaised = false,
    double height = 40.0,
    FontWeight fontWeight = FontWeight.normal,
    bool isSmall = false,
    double fontSize = 16.0,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(right: 8.0, bottom: 0),
        child: _buildCustomButton(
          text,
          style: style,
          fillColor: fillColor,
          textColor: textColor,
          borderColor: borderColor,
          isRound: isRound,
          isRaised: isRaised,
          height: height,
          fontWeight: fontWeight,
          isSmall: isSmall,
          fontSize: fontSize,
          onPressed: () {
            print('$text (${style.name}) clicked!');
          },
        ),
      ),
    );
  }

  // --- Widget Pembantu: Pembuat Tombol Kustom Utama (Tidak diubah, sudah sesuai) ---
  Widget _buildCustomButton(
    String text, {
    required ButtonStyle style,
    Color fillColor = Colors.transparent,
    Color textColor = Colors.black87,
    Color borderColor = Colors.transparent,
    bool isRound = false,
    bool isRaised = false,
    double height = 40.0,
    FontWeight fontWeight = FontWeight.normal,
    bool isSmall = false,
    double fontSize = 16.0,
    bool isPreloading = false,
    VoidCallback? onPressed,
  }) {
    double finalHeight = isSmall ? 30.0 : height;
    double borderRadius = isSmall ? 4.0 : 6.0;

    double finalElevation = 0.0;
    Color finalShadowColor = Colors.transparent;

    if (isRaised) {
      finalElevation = 2.0;
      finalShadowColor = Colors.black.withOpacity(0.1);
    }

    Color indicatorColor =
        (style == ButtonStyle.fill || style == ButtonStyle.raised)
        ? Colors.white
        : textColor;

    Widget buttonChild;
    if (isPreloading) {
      buttonChild = SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(
          strokeWidth: 3.0,
          valueColor: AlwaysStoppedAnimation<Color>(indicatorColor),
        ),
      );
    } else {
      buttonChild = Text(
        text,
        style: TextStyle(
          color: textColor,
          fontWeight: fontWeight,
          fontSize: fontSize,
        ),
      );
    }

    final buttonStyle = TextButton.styleFrom(
      backgroundColor: Colors.transparent,
      foregroundColor: textColor,
      minimumSize: Size.fromHeight(finalHeight),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
        side: BorderSide.none,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 8,
        vertical: isSmall ? 4.0 : 10.0,
      ),
      elevation: 0,
    );

    return Material(
      color: (style == ButtonStyle.tonal ? veryLightPurple : fillColor),
      borderRadius: BorderRadius.circular(borderRadius),
      elevation: finalElevation,
      shadowColor: finalShadowColor,
      type: MaterialType.button,

      child: InkWell(
        onTap: isPreloading ? null : onPressed,
        borderRadius: BorderRadius.circular(borderRadius),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: style == ButtonStyle.outline
                  ? borderColor
                  : Colors.transparent,
              width: style == ButtonStyle.outline ? 1.5 : 0,
            ),
          ),
          child: TextButton(
            onPressed: isPreloading ? null : onPressed,
            style: buttonStyle,
            child: buttonChild,
          ),
        ),
      ),
    );
  }
}

// Enum untuk memudahkan identifikasi gaya tombol
enum ButtonStyle { usual, tonal, fill, outline, raised }
