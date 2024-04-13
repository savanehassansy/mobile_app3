import 'package:flutter/material.dart';
import 'package:jmoov/palette.dart';

class Selector extends StatelessWidget {
  final String label;
  final String value;
  final Function(String) onChanged;
  final List<SelectorItem> items;

  const Selector(
      {super.key,
      required this.label,
      required this.value,
      required this.onChanged,
      required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
          ),
        ),
        const SizedBox(height: 16),
        ..._buildSelectorItems(),
      ],
    );
  }

  List<_SelectorItem> _buildSelectorItems() {
    return items
        .map((item) => _SelectorItem(
              label: item.label,
              value: item.value,
              onTap: () => onChanged(item.value),
              selected: item.value == value,
            ))
        .toList();
  }
}

class _SelectorItem extends StatelessWidget {
  final String label;
  final String value;
  final Function() onTap;
  final bool selected;

  const _SelectorItem(
      {required this.label,
      required this.value,
      required this.onTap,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    final ThemeData t = Theme.of(context);
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      color: selected ? Palette.accentColor : Colors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Text(
                label,
                style: t.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w800,
                  color: selected ? Colors.white : Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SelectorItem {
  final String label;
  final String value;

  const SelectorItem({required this.label, required this.value});
}
