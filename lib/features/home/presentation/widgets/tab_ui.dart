import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

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
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      alignment: WrapAlignment.center,
      children: List<Widget>.generate(
        labels.length,
        (int index) => ChoiceChip(
          label: Text(labels[index]),
          selected: selected == index,
          onSelected: (_) => onSelected(index),
          showCheckmark: false,
          selectedColor: colorScheme.primary,
          backgroundColor: appColors.pageBackground,
          side: BorderSide(color: colorScheme.surface, width: 2),
          shape: const StadiumBorder(),
          labelStyle: context.textTheme.bodyMedium?.copyWith(
            color: selected == index
                ? colorScheme.onPrimary
                : appColors.textMuted,
            fontWeight: selected == index ? FontWeight.w700 : FontWeight.w400,
          ),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: 10,
          ),
        ),
      ),
    );
  }
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
