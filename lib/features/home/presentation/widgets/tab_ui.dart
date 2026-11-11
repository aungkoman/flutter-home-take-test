import 'package:flutter/material.dart';

const Color tabBlue = Color(0xFF60C1DE);
const Color tabPink = Color(0xFFDC629F);
const Color tabGray = Color(0xFFF0F1F3);

class TabPills extends StatelessWidget {
  const TabPills({
    super.key,
    required this.labels,
    required this.selected,
    required this.onSelected,
  });
  final List<String> labels;
  final int selected;
  final ValueChanged<int> onSelected;
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: 8,
    runSpacing: 8,
    alignment: WrapAlignment.center,
    children: List<Widget>.generate(
      labels.length,
      (int index) => ChoiceChip(
        label: Text(labels[index]),
        selected: selected == index,
        onSelected: (_) => onSelected(index),
        showCheckmark: false,
        selectedColor: tabBlue,
        backgroundColor: tabGray,
        side: const BorderSide(color: Colors.white, width: 2),
        shape: const StadiumBorder(),
        labelStyle: TextStyle(
          color: selected == index ? Colors.white : const Color(0xFF7C848B),
          fontWeight: selected == index ? FontWeight.w700 : FontWeight.w400,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      ),
    ),
  );
}

void showTabSheet(BuildContext context, String title, String message) {
  showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    isScrollControlled: true,
    builder: (BuildContext context) => SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 8, 24, 28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(title, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            Text(message),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    ),
  );
}
