import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/widgets/tab_ui.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});
  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String _city = 'Minhla';
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    return Scaffold(
      backgroundColor: appColors.pageBackground,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: constraints.maxHeight * 0.53,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ColoredBox(
                            color: appColors.mapBackground,
                            child: Center(
                              child: Icon(
                                Icons.map_outlined,
                                size: 160,
                                color: appColors.mapIcon,
                              ),
                            ),
                          ),
                        ),
                        SafeArea(
                          bottom: false,
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.xl),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Shop at',
                                  style: textTheme.bodyMedium?.copyWith(
                                    fontSize: 15,
                                    color: appColors.textMuted,
                                  ),
                                ),
                                DropdownButton<String>(
                                  isExpanded: true,
                                  value: _city,
                                  underline: const SizedBox.shrink(),
                                  style: textTheme.headlineMedium,
                                  items: const ['Minhla', 'Yangon', 'Mandalay']
                                      .map(
                                        (String city) =>
                                            DropdownMenuItem<String>(
                                              value: city,
                                              child: Text(city),
                                            ),
                                      )
                                      .toList(),
                                  onChanged: (String? city) {
                                    if (city != null) {
                                      setState(() => _city = city);
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight * 0.47,
                    ),
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 140),
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadii.sheet),
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          width: 36,
                          height: 4,
                          decoration: BoxDecoration(
                            color: appColors.dragHandle,
                            borderRadius: BorderRadius.circular(AppRadii.sm),
                          ),
                        ),
                        const SizedBox(height: 14),
                        TabPills(
                          labels: const ['Nearby', 'Favourites'],
                          selected: _selected,
                          onSelected: (int value) =>
                              setState(() => _selected = value),
                        ),
                        const SizedBox(height: 80),
                        Text(
                          _selected == 0
                              ? 'No J’Donuts Shop Near by ($_city)'
                              : 'No Favourite Shops',
                          textAlign: TextAlign.center,
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }
}
