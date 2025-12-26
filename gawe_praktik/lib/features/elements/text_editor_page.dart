import 'package:flutter/material.dart';
// Note: removed direct flutter_quill usage to avoid analyzer issues with
// package API mismatches in this workspace. RealTextEditor now uses a
// simple TextField-based implementation that is analyzer-friendly.

// Definisi Warna yang Konsisten
const Color framework7Purple = Color(0xFF9147FF);
const Color lightPurpleBackground = Color(0xFFF7F2FF);
const Color dividerColor = Color(0xFFEFEFF4);
const Color inputBorderColor = Color(0xFFDCDCDC);
const Color inputFillColor = Color(0xFFF7F7F7);
const Color inputTextColor = Colors.black87;
const Color placeholderColor = Colors.grey;

// ----------------------------------------------------
// 1. Widget Text Editor NYATA (SUDAH DIPERBAIKI SEMUA)
// ----------------------------------------------------

class RealTextEditor extends StatefulWidget {
  final bool showPlaceholder;
  final bool hasDefaultValue;

  const RealTextEditor({
    super.key,
    this.showPlaceholder = false,
    this.hasDefaultValue = false,
  });

  @override
  State<RealTextEditor> createState() => _RealTextEditorState();
}

class _RealTextEditorState extends State<RealTextEditor> {
  late TextEditingController _controller;

  // simple formatting state (visual only)
  bool _bold = false;
  bool _italic = false;
  bool _underline = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: widget.hasDefaultValue
            ? 'Lorem ipsum dolor sit amet, consectetur adipisicing elit.\n\nProvident reiciendis exercitationem reprehenderit amet repellat.'
            : '');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextStyle get _currentStyle => TextStyle(
        fontWeight: _bold ? FontWeight.bold : FontWeight.normal,
        fontStyle: _italic ? FontStyle.italic : FontStyle.normal,
        decoration: _underline ? TextDecoration.underline : TextDecoration.none,
        color: inputTextColor,
        fontSize: 16,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: inputBorderColor, width: 1.0),
      ),
      child: Column(
        children: [
          // Minimal toolbar
          Container(
            color: lightPurpleBackground,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(Icons.format_bold,
                      color: _bold ? framework7Purple : Colors.black54),
                  onPressed: () => setState(() => _bold = !_bold),
                ),
                IconButton(
                  icon: Icon(Icons.format_italic,
                      color: _italic ? framework7Purple : Colors.black54),
                  onPressed: () => setState(() => _italic = !_italic),
                ),
                IconButton(
                  icon: Icon(Icons.format_underline,
                      color: _underline ? framework7Purple : Colors.black54),
                  onPressed: () => setState(() => _underline = !_underline),
                ),
                const Spacer(),
                // simple placeholder action
                IconButton(
                  icon: const Icon(Icons.clear, color: Colors.black54),
                  onPressed: () => _controller.clear(),
                ),
              ],
            ),
          ),

          const Divider(height: 1, thickness: 1, color: inputBorderColor),

          // Editor area
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 150, maxHeight: 400),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller: _controller,
                style: _currentStyle,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                decoration: InputDecoration(
                  hintText: widget.showPlaceholder ? 'Enter text...' : null,
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// 2. Widget Text Editor SIMULASI (Tidak Berubah)
// ----------------------------------------------------

class TextEditorSimulator extends StatefulWidget {
  final List<IconData> toolbarIcons;
  final String? placeholder;
  final double minHeight;
  final bool resizable;

  const TextEditorSimulator({
    super.key,
    required this.toolbarIcons,
    this.placeholder,
    this.minHeight = 150,
    this.resizable = false,
  });

  @override
  State<TextEditorSimulator> createState() => _TextEditorSimulatorState();
}

class _TextEditorSimulatorState extends State<TextEditorSimulator> {
  // State untuk pemformatan global
  bool isBold = false;
  bool isItalic = false;
  bool isUnderline = false;

  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TextStyle get _currentStyle {
    return TextStyle(
      fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
      fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      decoration: isUnderline ? TextDecoration.underline : TextDecoration.none,
      color: inputTextColor,
      fontSize: 16,
    );
  }

  Widget _buildToolbar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: lightPurpleBackground,
        border: Border(bottom: BorderSide(color: inputBorderColor, width: 1.0)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: widget.toolbarIcons.map((icon) {
            bool isActive = false;
            if (icon == Icons.format_bold) isActive = isBold;
            if (icon == Icons.format_italic) isActive = isItalic;
            if (icon == Icons.format_underline) isActive = isUnderline;

            if (icon == Icons.horizontal_rule) {
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: Text('<hr>',
                    style: TextStyle(color: Colors.black87, fontSize: 14)),
              );
            }

            return IconButton(
              icon: Icon(icon,
                  size: 18,
                  color: isActive ? framework7Purple : Colors.black54),
              onPressed: () {
                setState(() {
                  if (icon == Icons.format_bold)
                    isBold = !isBold;
                  else if (icon == Icons.format_italic)
                    isItalic = !isItalic;
                  else if (icon == Icons.format_underline)
                    isUnderline = !isUnderline;
                  else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('Clicked: ${icon.toString().split('.').last}'),
                      ),
                    );
                  }
                });
              },
            );
          }).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: inputBorderColor, width: 1.0),
      ),
      child: Column(
        children: [
          _buildToolbar(context),
          ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: widget.minHeight,
              maxHeight: widget.resizable ? double.infinity : widget.minHeight,
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: TextField(
                controller: _controller,
                style: _currentStyle,
                keyboardType: TextInputType.multiline,
                maxLines: widget.resizable ? null : (widget.minHeight ~/ 20),
                minLines: 1,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  hintStyle:
                      TextStyle(color: placeholderColor).merge(_currentStyle),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// 3. Widget List Input Simulasikan (As List Input)
// ----------------------------------------------------
class ListInputSimulator extends StatelessWidget {
  final String label;
  final String placeholder;
  final bool isEditor; // true untuk About

  const ListInputSimulator({
    super.key,
    required this.label,
    required this.placeholder,
    this.isEditor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: isEditor ? 100 : 50,
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      decoration: BoxDecoration(
        color: lightPurpleBackground.withOpacity(0.8),
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: dividerColor, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: placeholderColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            placeholder,
            style: TextStyle(
              fontSize: 16,
              color: placeholderColor.withOpacity(0.6),
            ),
            maxLines: isEditor ? 2 : 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// 4. Text Editor Page Utama (Menggabungkan Semua)
// ----------------------------------------------------

class TextEditorPage extends StatelessWidget {
  const TextEditorPage({super.key});

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
              'Text Editor',
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
            const Text(
              'Framework7 comes with a touch-friendly Rich Text Editor component. It is based on modern "contenteditable" API so it should work everywhere as is.\n\nIt comes with the basic set of formatting features. But its functionality can be easily extended and customized to fit any requirements.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),

            // 1. Default Setup (Fungsional "Seperti Word")
            _buildSectionTitle('Default Setup'),
            const RealTextEditor(
                showPlaceholder: false, hasDefaultValue: false),

            // 2. With Placeholder (Fungsional "Seperti Word")
            _buildSectionTitle('With Placeholder'),
            const RealTextEditor(showPlaceholder: true, hasDefaultValue: false),

            // 3. With Default Value (Fungsional "Seperti Word")
            _buildSectionTitle('With Default Value'),
            const RealTextEditor(showPlaceholder: false, hasDefaultValue: true),

            // 4. Specific Buttons (Simulasi Sederhana)
            _buildSectionTitle('Specific Buttons'),
            const Text(
              'It is possible to customize which buttons (commands) to show.',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 12),
            const TextEditorSimulator(
              toolbarIcons: [
                Icons.format_bold,
                Icons.format_italic,
                Icons.format_underline,
                Icons.format_align_left,
              ],
              placeholder: 'Enter text...',
              minHeight: 80,
            ),

            // 5. Custom Button (Simulasi Sederhana)
            _buildSectionTitle('Custom Button'),
            const Text(
              'It is possible to create custom editor buttons. Here is the custom "hr" button that adds horizontal rule:',
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 12),
            const TextEditorSimulator(
              toolbarIcons: [
                Icons.format_bold,
                Icons.format_italic,
                Icons.horizontal_rule, // Ini adalah tombol custom 'hr'
                Icons.format_align_left,
              ],
              minHeight: 80,
            ),

            // 6. As List Input
            _buildSectionTitle('As List Input (Simulated)'),
            const ListInputSimulator(
              label: 'Name',
              placeholder: 'Your name',
            ),
            const ListInputSimulator(
              label: 'About',
              placeholder: 'About yourself',
              isEditor: true, // Ini membuatnya lebih tinggi
            ),
          ],
        ),
      ),
    );
  }
}
