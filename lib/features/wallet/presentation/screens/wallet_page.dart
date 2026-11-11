import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../home/presentation/widgets/tab_ui.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  bool _visible = false;
  int _selected = 0;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: appColors.pageBackground,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppRadii.cardXl),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Wrap(
                            alignment: WrapAlignment.spaceBetween,
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              Text(
                                'Wallet Balance (Ks)',
                                style: textTheme.bodyLarge?.copyWith(
                                  fontSize: 15,
                                ),
                              ),
                              IconButton(
                                tooltip: _visible
                                    ? 'Hide balance'
                                    : 'Show balance',
                                onPressed: () =>
                                    setState(() => _visible = !_visible),
                                icon: Icon(
                                  _visible
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                ),
                              ),
                              TextButton(
                                onPressed: () => showTabSheet(
                                  context,
                                  'Wallet History',
                                  'No transactions yet.',
                                ),
                                child: const Text('HISTORY'),
                              ),
                            ],
                          ),
                          Text(
                            _visible ? '0 Ks' : '****',
                            style: textTheme.headlineLarge,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          FilledButton.icon(
                            onPressed: () => showTabSheet(
                              context,
                              'Top Up',
                              'No top-up methods available.',
                            ),
                            icon: const Icon(Icons.edit_outlined),
                            label: const Text('Top Up'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppRadii.cardXl),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Gifts bring people together',
                                  style: textTheme.titleLarge,
                                ),
                              ),
                              Icon(
                                Icons.card_giftcard,
                                color: colorScheme.secondary,
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'Select an amount and send out to your loved ones',
                            style: textTheme.bodyLarge,
                          ),
                          const SizedBox(height: AppSpacing.lg),
                          TextButton.icon(
                            onPressed: () => showTabSheet(
                              context,
                              'Send Gift Card',
                              'No gift cards available.',
                            ),
                            icon: Icon(
                              Icons.north_east,
                              color: colorScheme.secondary,
                            ),
                            label: const Text('SEND GIFT CARD'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Gift cards you received', style: textTheme.bodyLarge),
                    const SizedBox(height: 10),
                    TabPills(
                      labels: const ['All', 'Unused', 'Used', 'Expired'],
                      selected: _selected,
                      onSelected: (int value) =>
                          setState(() => _selected = value),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 110),
            Text(
              _selected == 0
                  ? 'No Gift Card'
                  : 'No ${['', 'Unused', 'Used', 'Expired'][_selected]} Gift Cards',
              style: textTheme.bodyLarge?.copyWith(fontSize: 17),
            ),
            const SizedBox(height: 170),
          ],
        ),
      ),
    );
  }
}
