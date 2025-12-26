import 'package:flutter/material.dart';

class CheckboxPage extends StatefulWidget {
  const CheckboxPage({super.key});

  @override
  State<CheckboxPage> createState() => _CheckboxPageState();
}

class _CheckboxPageState extends State<CheckboxPage> {
  // Definisi Warna yang Konsisten
  static const Color framework7Purple = Color(0xFF9147FF);
  static const Color dividerColor = Color(0xFFEFEFF4);

  // --- 1. State untuk Inline Checkboxes ---
  bool isInlineCheckbox1Checked = false;
  bool isInlineCheckbox2Checked = true;

  // --- 2. State untuk Checkbox Group (Standard) ---
  Map<String, bool> checkboxGroup = {
    'Books': true,
    'Movies': true,
    'Food': false,
    'Drinks': false,
  };

  // --- 3. State untuk Indeterminate State ---
  bool? moviesParentChecked = false;
  bool movie1Checked = false;
  bool movie2Checked = false;

  // Data untuk Media List
  final List<Map<String, dynamic>> mediaListItems = [
    {
      'title': 'Facebook',
      'via': '',
      'time': '17:14',
      'subtitle': 'New messages from John Doe',
      'checked': false,
    },
    {
      'title': 'John Doe',
      'via': ' (via Twitter)',
      'time': '17:11',
      'subtitle': 'John Doe (@_johndoe) mentioned you on Twitter!',
      'checked': false,
    },
    {
      'title': 'Facebook',
      'via': '',
      'time': '16:48',
      'subtitle': 'New messages from John Doe',
      'checked': false,
    },
    {
      'title': 'John Doe',
      'via': ' (via Twitter)',
      'time': '15:32',
      'subtitle': 'John Doe (@_johndoe) mentioned you on Twitter!',
      'checked': false,
    },
  ];

  // =========================================================
  // LOGIC
  // =========================================================

  void _updateMoviesParent() {
    int checkedCount = 0;
    if (movie1Checked) checkedCount++;
    if (movie2Checked) checkedCount++;

    if (checkedCount == 2) {
      moviesParentChecked = true;
    } else if (checkedCount == 1) {
      moviesParentChecked = null;
    } else {
      moviesParentChecked = false;
    }
  }

  void _onMovieParentChange(bool? newValue) {
    final bool isChecking = newValue ?? false;
    setState(() {
      moviesParentChecked = isChecking;
      movie1Checked = isChecking;
      movie2Checked = isChecking;
    });
  }

  void _onMovieChildChange(int movieNumber, bool newValue) {
    setState(() {
      if (movieNumber == 1) {
        movie1Checked = newValue;
      } else {
        movie2Checked = newValue;
      }
      _updateMoviesParent();
    });
  }

  // =========================================================
  // WIDGET PEMBANTU
  // =========================================================

  /// Judul Bagian
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

  /// Checkbox yang dikustomisasi untuk penggunaan inline (lebih kompak)
  Widget _buildInlineCheckbox({
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
  }) {
    return Transform.scale(
      scale: 0.9,
      child: Checkbox(
        visualDensity: VisualDensity.compact,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        value: isChecked,
        onChanged: onChanged,
        activeColor: framework7Purple,
      ),
    );
  }

  /// Item daftar dengan checkbox (Media List)
  Widget _buildMediaListItem(int index, Map<String, dynamic> item) {
    final String longSubtitleText =
        item['subtitle'] +
        '\n' +
        'Lorem ipsum dolor sit amet, consectetur adipisicing elit. Nulla sagittis tellus ut turpis condimentum, ut dignissim lacus...';

    return Column(
      children: [
        ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Checkbox(
            value: mediaListItems[index]['checked'],
            onChanged: (newValue) {
              setState(() {
                mediaListItems[index]['checked'] = newValue!;
              });
            },
            activeColor: framework7Purple,
          ),

          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(
                    style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: 16,
                      height: 1.4,
                      color: Colors.black87,
                    ),
                    children: [
                      TextSpan(
                        text: item['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      TextSpan(
                        text: item['via'],
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),

                Text(
                  item['time'],
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          subtitle: Text(
            longSubtitleText,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black54,
              height: 1.3,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        if (index < mediaListItems.length - 1)
          const Divider(
            height: 1,
            thickness: 1,
            indent: 16.0,
            endIndent: 0,
            color: dividerColor,
          ),
      ],
    );
  }

  // =========================================================
  // BUILD METHOD
  // =========================================================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // --- AppBar (Header Halaman) ---
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Checkbox',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: false,
      ),

      // --- Body Halaman ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ----------------------------------------------------
            // 1. Inline (Dua Checkbox Interaktif)
            // ----------------------------------------------------
            _buildSectionTitle('Inline'),
            Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.4,
                    color: Colors.black87,
                  ),
                  children: [
                    const TextSpan(text: 'Lorem '),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: _buildInlineCheckbox(
                        isChecked: isInlineCheckbox1Checked,
                        onChanged: (newValue) {
                          setState(() {
                            isInlineCheckbox1Checked = newValue ?? false;
                          });
                        },
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' ipsum dolor sit amet, consectetur adipisicing elit. Alias beatae illo nihil aut eius commodi sint eveniet aliquid eligendi',
                    ),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: _buildInlineCheckbox(
                        isChecked: isInlineCheckbox2Checked,
                        onChanged: (newValue) {
                          setState(() {
                            isInlineCheckbox2Checked = newValue ?? false;
                          });
                        },
                      ),
                    ),
                    const TextSpan(
                      text:
                          ' ad delectus impedit tempore nemo, enim vel praesentium consequatur nulla mollitia!',
                    ),
                  ],
                ),
              ),
            ),

            // ----------------------------------------------------
            // 2. Checkbox Group (Checkbox di Kiri)
            // ----------------------------------------------------
            _buildSectionTitle('Checkbox Group 1'), // Nama diubah menjadi 1
            Column(
              children: checkboxGroup.keys.map((key) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Checkbox(
                    value: checkboxGroup[key],
                    onChanged: (newValue) {
                      setState(() {
                        checkboxGroup[key] = newValue!;
                      });
                    },
                    activeColor: framework7Purple,
                  ),
                  title: Text(
                    key,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------
            // 3. Checkbox Group (Checkbox di Kanan)
            // ----------------------------------------------------
            _buildSectionTitle('Checkbox Group 2'), // Nama diubah menjadi 2
            Column(
              children: checkboxGroup.keys.map((key) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    key,
                    style: const TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  trailing: Checkbox(
                    value: checkboxGroup[key],
                    onChanged: (newValue) {
                      setState(() {
                        checkboxGroup[key] = newValue!;
                      });
                    },
                    activeColor: framework7Purple,
                  ),
                );
              }).toList(),
            ),

            // ----------------------------------------------------
            // 4. Indeterminate State
            // ----------------------------------------------------
            _buildSectionTitle('Indeterminate State'),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text(
                    'Movies',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  leading: Checkbox(
                    tristate: true,
                    value: moviesParentChecked,
                    onChanged: _onMovieParentChange,
                    activeColor: framework7Purple,
                  ),
                ),
                const Divider(height: 1, thickness: 1, color: dividerColor),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Movie 1',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    leading: Checkbox(
                      value: movie1Checked,
                      onChanged: (newValue) =>
                          _onMovieChildChange(1, newValue ?? false),
                      activeColor: framework7Purple,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 32.0),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text(
                      'Movie 2',
                      style: TextStyle(fontSize: 16, color: Colors.black87),
                    ),
                    leading: Checkbox(
                      value: movie2Checked,
                      onChanged: (newValue) =>
                          _onMovieChildChange(2, newValue ?? false),
                      activeColor: framework7Purple,
                    ),
                  ),
                ),
              ],
            ),

            // ----------------------------------------------------
            // 5. With Media Lists
            // ----------------------------------------------------
            _buildSectionTitle('With Media Lists'),
            Column(
              children: mediaListItems.asMap().entries.map((entry) {
                return _buildMediaListItem(entry.key, entry.value);
              }).toList(),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
