import 'package:flutter/material.dart';

// Model data Nutrisi - Dibuat mutable untuk demonstrasi
class NutritionData {
  final String dessert;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  bool isInStock;
  final String comments;

  NutritionData(
    this.dessert,
    this.calories,
    this.fat,
    this.carbs,
    this.protein, {
    this.isInStock = true,
    this.comments = 'N/A',
  });
}

// Data List
final List<NutritionData> dessertData = [
  NutritionData(
    'Frozen yogurt',
    159,
    6.0,
    24,
    4.0,
    comments: 'I like frozen yogurt',
  ),
  NutritionData(
    'Ice cream sandwich',
    237,
    9.0,
    37,
    4.4,
    isInStock: false,
    comments: 'But like ice cream more',
  ),
  NutritionData('Eclair', 262, 16.0, 24, 6.0, comments: 'Super tasty'),
  NutritionData('Cupcake', 305, 3.7, 67, 4.3, comments: "Don't like it"),
  NutritionData('Gingerbread', 356, 17.0, 49, 3.9),
  // ... data lainnya tetap
  NutritionData('Jelly bean', 375, 0.0, 94, 0.0, isInStock: false),
  NutritionData('Lollipop', 392, 0.2, 98, 0.0),
  NutritionData('Honeycomb', 408, 3.2, 87, 6.5),
  NutritionData('Donut', 452, 25.0, 51, 4.9),
  NutritionData('KitKat', 518, 26.0, 65, 7.0),
  NutritionData('Krusty Krab Pizza', 1500, 50.0, 200, 50.0),
];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Data Table Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF9147FF)),
        useMaterial3: true,
      ),
      home: const DataTablePage(),
    );
  }
}

class DataTablePage extends StatefulWidget {
  const DataTablePage({super.key});

  @override
  State<DataTablePage> createState() => _DataTablePageState();
}

class _DataTablePageState extends State<DataTablePage> {
  // State dan Konstanta
  int _rowsPerPage = 5;
  final List<int> _availableRowsPerPage = [5, 10, 25, 100];

  // State terpisah untuk isolasi seleksi
  final List<bool> _selectableRowsSelected = List.filled(4, false);
  final List<bool> _tabletOnlyRowsSelected = List.filled(4, false);
  final List<bool> _defaultStyleSelected = List.filled(4, false);
  final List<bool> _alternateHeaderSelected = List.filled(4, false);
  final List<bool> _sortableSelected = List.filled(4, false);
  final List<bool> _cardWithTitleSelected = List.filled(4, false);
  final List<bool> _cardPlainSelected = List.filled(4, false);

  // State untuk pengurutan (Sortable Columns)
  int? _sortColumnIndex;
  bool _sortAscending = true;

  final double _fixedColumnWidth = 150.0;
  final double _dataCellHeight = 48.0;
  final double _inStockColumnWidth = 120.0;
  final double _nutrientColWidth = 80.0;
  final Color framework7Purple = const Color(0xFF9147FF);

  // --- LOGIKA PENGURUTAN ---
  void _onSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;

      List<NutritionData> sortableData = dessertData.sublist(0, 4);

      sortableData.sort((a, b) {
        Comparable aValue;
        Comparable bValue;

        switch (columnIndex) {
          case 0: // Dessert
            aValue = a.dessert;
            bValue = b.dessert;
            break;
          case 1: // Calories
            aValue = a.calories;
            bValue = b.calories;
            break;
          case 2: // Fat
            aValue = a.fat;
            bValue = b.fat;
            break;
          case 3: // Carbs
            aValue = a.carbs;
            bValue = b.carbs;
            break;
          case 4: // Protein
            aValue = a.protein;
            bValue = b.protein;
            break;
          default:
            return 0;
        }

        final comparison = Comparable.compare(aValue, bValue);
        return ascending ? comparison : -comparison;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<NutritionData> dataForTables = dessertData.sublist(0, 4);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data Table',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // --- Bagian 1: Plain Table ---
            _buildSectionTitle('Plain table'),
            _buildNutritionTable(
              withCheckboxes: false,
              data: dataForTables,
              isPaginationTable: false,
            ),

            const SizedBox(height: 30),

            // --- Bagian 1.5: within card ---
            _buildSectionTitle('within card'),
            _buildNutritionTableInCard(
              withCheckboxes: true,
              data: dataForTables,
              selectedList: _cardPlainSelected,
            ),

            const SizedBox(height: 30),

            // --- Bagian 1.7: With Footer Pagination (Fixed Column) ---
            _buildSectionTitle('With Footer Pagination (Fixed Column)'),
            _buildCustomFixedColumnTable(data: dessertData),

            const SizedBox(height: 30),

            // --- Selectable rows (Custom Checkbox) ---
            _buildSectionTitle('Selectable rows'),
            _buildSelectableTable(
              data: dataForTables,
              isCustomSelectable: true,
              selectedList: _selectableRowsSelected,
            ),

            const SizedBox(height: 30),

            // --- Tablet-only columns (Custom Checkbox) ---
            _buildSectionTitle('Tablet-only columns'),
            const Text(
              '"Comments" column will be visible only on devices with screen width >= 768px (tablets)',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            _buildTabletOnlyTable(
              data: dataForTables,
              isCustomSelectable: true,
              selectedList: _tabletOnlyRowsSelected,
            ),

            const SizedBox(height: 30),

            // --- Bagian 3: With Inputs (Admin Table) ---
            _buildSectionTitle('With inputs'),
            const Text(
              'Such tables are widely used in admin interfaces for filtering or search data',
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
            const SizedBox(height: 10),
            _buildAdminTableWithFilters(),

            const SizedBox(height: 30),

            // --- Within card with title and actions ---
            _buildSectionTitle('Within card with title and actions'),
            _buildCardWithTitleAndActions(
              data: dataForTables,
              selectedList: _cardWithTitleSelected,
            ),

            const SizedBox(height: 30),

            // --- Sortable columns ---
            _buildSectionTitle('Sortable columns'),
            _buildNutritionTable(
              withCheckboxes: true,
              showTitle: true,
              data: dataForTables,
              isPaginationTable: false,
              onSort: _onSort,
              sortColumnIndex: _sortColumnIndex,
              sortAscending: _sortAscending,
              selectedList: _sortableSelected,
            ),

            const SizedBox(height: 30),

            // --- With title and different actions on select (Default Style) ---
            _buildSectionTitle(
              'With title and different actions on select (Default Style)',
            ),
            _buildNutritionTable(
              withCheckboxes: true,
              showTitle: true,
              data: dataForTables,
              isPaginationTable: false,
              selectedList: _defaultStyleSelected,
            ),

            const SizedBox(height: 30),

            // --- Alternate header with actions ---
            _buildSectionTitle('Alternate header with actions'),
            _buildAlternateHeaderTable(
              data: dataForTables,
              selectedList: _alternateHeaderSelected,
            ),

            const SizedBox(height: 30),

            // --- MODIFIKASI: Collapsible Table ---
            _buildSectionTitle('Collapsible'),
            const Text(
              'The following table will be collapsed to kind of List View on small screens:',
              style: TextStyle(color: Colors.black54, fontSize: 14),
            ),
            _buildNutritionTable(
              withCheckboxes: false,
              showTitle: true,
              data: dataForTables,
              isPaginationTable: false,
              // Tanpa sorting/seleksi khusus
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // WIDGET PEMBANTU UTAMA (MENGURUS SEMUA VARIASI DATATABLE STANDAR)
  // -------------------------------------------------------------------

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, top: 10.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: framework7Purple,
        ),
      ),
    );
  }

  Widget _buildNutritionTable({
    required List<NutritionData> data,
    List<bool>? selectedList,
    bool withCheckboxes = false,
    bool isCustomSelectable = false,
    bool showTitle = false,
    bool isPaginationTable = false,
    bool includeInStockColumn = false,
    bool showTabletOnlyColumn = false,
    bool includeActionsColumn = false,
    Function(int, bool)? onSort,
    int? sortColumnIndex,
    bool sortAscending = true,
  }) {
    final double screenWidth = MediaQuery.of(context).size.width;
    List<NutritionData> displayedData = data;

    // Cek status header In Stock
    bool? isAllInStock;
    if (includeInStockColumn && data.isNotEmpty) {
      bool allTrue = data.every((item) => item.isInStock);
      bool allFalse = data.every((item) => !item.isInStock);
      if (allTrue)
        isAllInStock = true;
      else if (allFalse)
        isAllInStock = false;
      else
        isAllInStock = null;
    }

    // --- 1. Definisi Kolom Header ---
    List<DataColumn> initialColumns = [];

    // 1. Tambahkan kolom Checkbox kustom (Header)
    if (isCustomSelectable && selectedList != null) {
      bool allCustomSelected = selectedList.every((selected) => selected);

      initialColumns.add(
        DataColumn(
          label: Checkbox(
            value: allCustomSelected,
            onChanged: (bool? newValue) {
              setState(() {
                bool setTo = newValue ?? false;
                for (int i = 0; i < selectedList.length; i++) {
                  selectedList[i] = setTo;
                }
              });
            },
          ),
        ),
      );
    }

    // 2. Kolom Dessert (Header)
    initialColumns.add(
      DataColumn(
        label: const Text('Dessert (100g serving)'),
        onSort: onSort != null
            ? (i, asc) => onSort(isCustomSelectable ? 1 : 0, asc)
            : null,
      ),
    );

    // 3. Kolom Nutrisi (Header)
    initialColumns.addAll([
      DataColumn(
        label: const Text('Calories'),
        onSort: onSort != null
            ? (i, asc) => onSort(isCustomSelectable ? 2 : 1, asc)
            : null,
      ),
      DataColumn(
        label: const Text('Fat (g)'),
        onSort: onSort != null
            ? (i, asc) => onSort(isCustomSelectable ? 3 : 2, asc)
            : null,
      ),
      DataColumn(
        label: const Text('Carbs'),
        onSort: onSort != null
            ? (i, asc) => onSort(isCustomSelectable ? 4 : 3, asc)
            : null,
      ),
      DataColumn(
        label: const Text('Protein (g)'),
        onSort: onSort != null
            ? (i, asc) => onSort(isCustomSelectable ? 5 : 4, asc)
            : null,
      ),
    ]);

    // 4. Kolom 'In Stock' (Header)
    if (includeInStockColumn) {
      initialColumns.add(
        DataColumn(
          label: Container(
            width: _inStockColumnWidth,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('In Stock'),
                Checkbox(
                  value: isAllInStock,
                  tristate: true,
                  onChanged: (bool? newValue) {
                    setState(() {
                      bool setTo = newValue ?? false;
                      for (var item in data.sublist(0, selectedList!.length)) {
                        item.isInStock = setTo;
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    // 5. Kolom 'Comments' (Responsif)
    if (showTabletOnlyColumn && screenWidth >= 768) {
      initialColumns.add(
        DataColumn(label: Container(width: 150, child: const Text('Comments'))),
      );
    }

    // 6. Kolom Comments (permanen) & Aksi
    if (includeActionsColumn) {
      initialColumns.add(const DataColumn(label: Text('Comments')));
      initialColumns.add(
        // Kolom aksi tanpa label header
        const DataColumn(label: Text('')),
      );
    }

    // --- 2. Definisi DataRow dan Cells ---
    List<DataRow> rows = displayedData.asMap().entries.map((entry) {
      int index = entry.key;
      NutritionData item = entry.value;

      // Ambil status seleksi dari list state yang dikirimkan
      bool isSelected = (isCustomSelectable || withCheckboxes) &&
              selectedList != null &&
              index < selectedList.length
          ? selectedList[index]
          : false;

      List<DataCell> cells = [];

      // 1. Sel Checkbox kustom
      if (isCustomSelectable && selectedList != null) {
        cells.add(
          DataCell(
            Checkbox(
              value: selectedList[index],
              onChanged: (bool? newValue) {
                setState(() {
                  selectedList[index] = newValue ?? false;
                });
              },
            ),
          ),
        );
      }

      // 2. Data Cell Dessert (Lebar 150)
      cells.add(
        DataCell(
          Container(
            width: 150,
            child: Text(
              item.dessert,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ),
      );

      // 3. Data Cells Nutrisi (Lebar _nutrientColWidth)
      cells.addAll([
        DataCell(
          Container(
            width: _nutrientColWidth,
            child: Text(item.calories.toString()),
          ),
        ),
        DataCell(
          Container(width: _nutrientColWidth, child: Text(item.fat.toString())),
        ),
        DataCell(
          Container(
            width: _nutrientColWidth,
            child: Text(item.carbs.toString()),
          ),
        ),
        DataCell(
          Container(
            width: _nutrientColWidth,
            child: Text(item.protein.toString()),
          ),
        ),
      ]);

      // 4. Tambah sel 'In Stock'
      if (includeInStockColumn) {
        cells.add(
          DataCell(
            SizedBox(
              width: _inStockColumnWidth,
              child: Align(
                alignment: Alignment.centerRight,
                child: Checkbox(
                  value: item.isInStock,
                  onChanged: (bool? newValue) {
                    if (newValue != null) {
                      setState(() {
                        item.isInStock = newValue;
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        );
      }

      // 5. Tambah sel 'Comments' (Responsif)
      if (showTabletOnlyColumn && screenWidth >= 768) {
        cells.add(DataCell(Container(width: 150, child: Text(item.comments))));
      }

      // 6. Comments & Actions (Permanen)
      if (includeActionsColumn) {
        cells.add(
          DataCell(Text(item.comments)), // Data Comments
        );
        cells.add(
          DataCell(
            Row(
              children: [
                Icon(Icons.edit_outlined, size: 18, color: framework7Purple),
                SizedBox(width: 8),
                Icon(Icons.delete_outline, size: 18, color: framework7Purple),
              ],
            ),
          ),
        );
      }

      return DataRow(
        cells: cells,
        selected: withCheckboxes && isSelected,
        onSelectChanged: isCustomSelectable
            ? null
            : withCheckboxes
                ? (selected) {
                    if (selectedList != null && index < selectedList.length) {
                      setState(() {
                        selectedList[index] = selected ?? false;
                      });
                    }
                  }
                : null,
        // Warna latar belakang baris di mode Custom Selectable
        color: (isCustomSelectable || withCheckboxes) && isSelected
            ? MaterialStateProperty.all(framework7Purple.withOpacity(0.1))
            : null,
      );
    }).toList();

    List<DataColumn> finalColumns = initialColumns;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showTitle)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Nutrition', style: TextStyle(fontSize: 18)),
              Row(
                children: [
                  IconButton(icon: const Icon(Icons.sort), onPressed: () {}),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            sortColumnIndex: sortColumnIndex,
            sortAscending: sortAscending,
            border: TableBorder(
              horizontalInside: BorderSide(
                color: Colors.grey.shade300,
                width: 1.0,
              ),
              bottom: isPaginationTable
                  ? BorderSide.none
                  : BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
            headingRowColor: MaterialStateProperty.all(Colors.white),
            dataRowMinHeight: 48,
            dataRowMaxHeight: 48,
            columns: finalColumns,
            rows: rows,
            showCheckboxColumn: !isCustomSelectable && withCheckboxes,
            dividerThickness: 0.0,
          ),
        ),
      ],
    );
  }

  // --- WIDGET BARU: Card with Title and Actions ---
  Widget _buildCardWithTitleAndActions({
    required List<NutritionData> data,
    required List<bool> selectedList,
  }) {
    // Membungkus tabel dengan Card
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildNutritionTable(
          data: data,
          withCheckboxes: true, // Checkbox bawaan
          showTitle: true, // Judul dan ikon (sort/more_vert)
          selectedList: selectedList, // State seleksi
        ),
      ),
    );
  }
  // -------------------------------------------------

  // --- WIDGET BARU: Alternate Header Table ---
  Widget _buildAlternateHeaderTable({
    required List<NutritionData> data,
    required List<bool> selectedList,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                TextButton(
                  onPressed: () {},
                  child: Text('Add', style: TextStyle(color: framework7Purple)),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Remove',
                    style: TextStyle(color: framework7Purple),
                  ),
                ),
              ],
            ),
            IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
          ],
        ),
        _buildNutritionTable(
          data: data,
          isCustomSelectable: true,
          selectedList: selectedList,
          includeActionsColumn: true, // Tambah Kolom Comments & Aksi
        ),
      ],
    );
  }
  // -------------------------------------------

  // WIDGET: Tablet-Only Table
  Widget _buildTabletOnlyTable({
    required List<NutritionData> data,
    required bool isCustomSelectable,
    required List<bool> selectedList,
  }) {
    return _buildNutritionTable(
      data: data,
      withCheckboxes: false,
      isCustomSelectable: isCustomSelectable,
      selectedList: selectedList,
      showTitle: false,
      includeInStockColumn: false,
      showTabletOnlyColumn: true,
    );
  }

  // WIDGET: Selectable Table
  Widget _buildSelectableTable({
    required List<NutritionData> data,
    required bool isCustomSelectable,
    required List<bool> selectedList,
  }) {
    return _buildNutritionTable(
      data: data,
      withCheckboxes: false,
      isCustomSelectable: isCustomSelectable,
      selectedList: selectedList,
      showTitle: false,
      includeInStockColumn: true,
    );
  }

  // WIDGET: Table di dalam Card (Plain)
  Widget _buildNutritionTableInCard({
    required bool withCheckboxes,
    required List<NutritionData> data,
    required List<bool> selectedList,
  }) {
    // Membungkus tabel dengan Card
    return Card(
      elevation: 2.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _buildNutritionTable(
          data: data,
          withCheckboxes: withCheckboxes,
          selectedList: selectedList, // Tautkan state untuk seleksi
          showTitle: false,
          isPaginationTable: false,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // WIDGET CUSTOM UNTUK FIXED COLUMN (TETAP)
  // -------------------------------------------------------------------

  Widget _buildCustomFixedColumnTable({required List<NutritionData> data}) {
    int maxRows = (_rowsPerPage == 100) ? data.length : _rowsPerPage;
    List<NutritionData> displayedData = data.take(maxRows).toList();

    int displayLength = (_rowsPerPage == 100)
        ? data.length
        : (maxRows > data.length ? data.length : maxRows);

    String rangeText = '1-$displayLength of ${data.length}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildCustomTableHeader(),
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildFixedColumn(displayedData),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: _buildScrollableColumns(displayedData),
                ),
              ),
            ],
          ),
        ),
        _buildPaginationFooter(rangeText),
      ],
    );
  }

  Widget _buildCustomTableHeader() {
    return Row(
      children: [
        Container(
          width: _fixedColumnWidth,
          height: _dataCellHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.centerLeft,
          child: const Text(
            'Dessert (100g serving)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildHeaderCell('Calories', 80.0),
                _buildHeaderCell('Fat (g)', 70.0),
                _buildHeaderCell('Carbs', 80.0),
                _buildHeaderCell('Protein (g)', 100.0),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeaderCell(String text, double width) {
    return Container(
      width: width,
      height: _dataCellHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
      ),
    );
  }

  Widget _buildFixedColumn(List<NutritionData> data) {
    return Column(
      children: data.map((item) {
        return Container(
          width: _fixedColumnWidth,
          height: _dataCellHeight,
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
          ),
          child: Text(
            item.dessert,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildScrollableColumns(List<NutritionData> data) {
    return Column(
      children: data.map((item) {
        return Container(
          height: _dataCellHeight,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
            ),
          ),
          child: Row(
            children: [
              _buildDataCell(item.calories.toString(), 80.0),
              _buildDataCell(item.fat.toString(), 70.0),
              _buildDataCell(item.carbs.toString(), 80.0),
              _buildDataCell(item.protein.toString(), 100.0),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildDataCell(String text, double width) {
    return Container(
      width: width,
      height: _dataCellHeight,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }

  // ===================================================================
  // FUNGSI YANG DIPERBAIKI
  // ===================================================================
  Widget _buildPaginationFooter(String rangeText) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        border: Border(
          top: BorderSide(color: Colors.grey.shade300, width: 1.0),
          bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        // Row dipertahankan karena layoutnya fix
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const Text(
            'Rows per page:',
            style: TextStyle(color: Colors.black54, fontSize: 13),
          ),
          const SizedBox(width: 8),

          SizedBox(
            height: 30,
            width: 75,
            child: DropdownButtonFormField<int>(
              value: _rowsPerPage,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              items: _availableRowsPerPage.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value == 100 ? 'All' : value.toString(),
                    style: const TextStyle(fontSize: 14),
                  ),
                );
              }).toList(),
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    _rowsPerPage = newValue;
                  });
                }
              },
            ),
          ),

          // 🚀 PERBAIKAN DI SINI:
          // Jarak dikurangi dari 16 menjadi 8 untuk menghemat ruang
          const SizedBox(width: 8),

          Text(
            rangeText,
            style: const TextStyle(color: Colors.black54, fontSize: 13),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.black54),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          IconButton(
            icon: const Icon(Icons.chevron_right, color: Colors.black87),
            onPressed: () {},
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }
  // ===================================================================

  // -------------------------------------------------------------------
  // ADMIN TABLE DENGAN INPUTS (TETAP)
  // -------------------------------------------------------------------

  Widget _buildAdminTableWithFilters() {
    List<DataColumn> columns = [
      _buildFilterColumn('ID', numeric: false),
      _buildFilterColumn('Name'),
      _buildFilterColumn('Email'),
      _buildFilterColumn('Gender', isDropdown: true),
    ];

    List<DataRow> rows = [
      _buildAdminDataRow('1', 'John Doe', 'john@doe.com', 'Male'),
      _buildAdminDataRow('2', 'Jane Doe', 'jane@doe.com', 'Female'),
      _buildAdminDataRow(
        '3',
        'Vladimir Khar...',
        'vladimir@google.com',
        'Male',
      ),
      _buildAdminDataRow('4', 'Jennifer Doe', 'jennifer@doe.com', 'Female'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        border: TableBorder(
          horizontalInside: BorderSide(color: Colors.grey.shade300, width: 1.0),
          bottom: BorderSide(color: Colors.grey.shade300, width: 1.0),
        ),
        headingRowHeight: 80,
        dataRowMinHeight: 48,
        dataRowMaxHeight: 48,
        columns: columns,
        rows: rows,
        dividerThickness: 0.0,
      ),
    );
  }

  DataColumn _buildFilterColumn(
    String label, {
    bool numeric = false,
    bool isDropdown = false,
  }) {
    return DataColumn(
      label: Container(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            if (!isDropdown)
              SizedBox(
                width: 100,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Filter',
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 0,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: framework7Purple, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: framework7Purple, width: 2),
                    ),
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
            if (isDropdown)
              SizedBox(
                width: 100,
                height: 24,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: framework7Purple, width: 2),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: framework7Purple, width: 2),
                    ),
                  ),
                  value: null,
                  hint: const Text('Filter', style: TextStyle(fontSize: 14)),
                  items: const ['Male', 'Female'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {},
                ),
              ),
          ],
        ),
      ),
      numeric: numeric,
    );
  }

  DataRow _buildAdminDataRow(
    String id,
    String name,
    String email,
    String gender,
  ) {
    return DataRow(
      cells: [
        DataCell(Text(id)),
        DataCell(Text(name)),
        DataCell(Text(email)),
        DataCell(Text(gender)),
      ],
    );
  }
}
