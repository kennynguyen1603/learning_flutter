import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum ColorLabel {
  blue('Blue', Colors.blue),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  bool isChecked = false;
  bool isSwitched = false;

  double _sliderValue = 0.0;
  double _currentVolume = 1;

  bool isTapped = false;

  ColorLabel? selectedColor;

  List<int> items = List<int>.generate(10, (int index) => index);

  @override
  void dispose() {
    _searchController.dispose(); // giải phóng bộ nhớ khi widget bị huỷ
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onEditingComplete: () {
                setState(() {});
              },
              decoration: const InputDecoration(
                labelText: 'Search',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Text('Searching for: ${_searchController.text}'),
          Divider(thickness: 5, color: Colors.grey.shade300, endIndent: 200),
          const SizedBox(height: 50, child: VerticalDivider()),
          Checkbox(
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false; // Cập nhật trạng thái checkbox
              });
            },
          ),
          CheckboxListTile(
            title: const Text('Check me'),
            value: isChecked,
            onChanged: (value) {
              setState(() {
                isChecked = value ?? false; // Cập nhật trạng thái checkbox
              });
            },
          ),
          Switch(
            value: isSwitched,
            activeColor: Colors.red,
            onChanged: (value) {
              setState(() {
                isSwitched = value; // Cập nhật trạng thái switch
              });
            },
          ),
          SwitchListTile(
            title: const Text('Switch me'),
            value: isSwitched,
            onChanged: (value) {
              setState(() {
                isSwitched = value; // Cập nhật trạng thái switch
              });
            },
          ),
          Column(
            children: [
              Text('Scroll me: ${_sliderValue.round()}'),
              Slider(
                value: _sliderValue,
                min: 0.0,
                max: 100.0,
                divisions: 100,
                label: _sliderValue.round().toString(),
                onChanged: (value) {
                  setState(() {
                    _sliderValue = value; // Cập nhật giá trị slider
                  });
                },
              ),
            ],
          ),
          Slider(
            value: _currentVolume,
            max: 5,
            divisions: 5,
            label: _currentVolume.toString(),
            onChanged: (double value) {
              setState(() {
                _currentVolume = value;
              });
            },
          ),
          InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () {
              setState(() {
                isTapped =
                    !isTapped; // Cập nhật trạng thái khi người dùng nhấn vào
              });
              if (kDebugMode) {
                print('Image tapped');
              }
            },
            child: isTapped
                ? Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.white12,
                  )
                : Image.asset(
                    'assets/images/bg.jpg',
                    width: double.infinity,
                    height: 200,
                    fit: BoxFit.cover,
                    // colorBlendMode: BlendMode.darken,
                  ),
          ),
          const SizedBox(height: 20),
          DropdownMenu<ColorLabel>(
            initialSelection: ColorLabel.green,
            // controller: colorController,
            width: 200,
            helperText: "Select a color", // optionally add a helper text
            requestFocusOnTap: true,
            label: const Text('Color'),
            onSelected: (ColorLabel? color) {
              setState(() {
                selectedColor = color;
              });
            },
            dropdownMenuEntries:
                ColorLabel.values.map<DropdownMenuEntry<ColorLabel>>((
              ColorLabel color,
            ) {
              return DropdownMenuEntry<ColorLabel>(
                value: color,
                label: color.label,
                enabled: color.label != 'Grey',
                style: MenuItemButton.styleFrom(
                  foregroundColor: color.color,
                ),
              );
            }).toList(),
          ),
          ListView.builder(
            shrinkWrap:
                true, // Cho phép ListView tính toán chiều cao dựa trên nội dung
            physics:
                const NeverScrollableScrollPhysics(), // Tắt scroll riêng của ListView
            padding: const EdgeInsets.symmetric(
              vertical: 16,
            ), // Thêm khoảng cách trên và dưới
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: ValueKey<int>(items[index]),
                background: Container(color: Colors.green),
                onDismissed: (DismissDirection direction) {
                  setState(() {
                    items.removeAt(index);
                  });
                },
                child: ListTile(title: Text('Item ${items[index]}')),
              );
            },
          ),
        ],
      ),
    );
  }
}
