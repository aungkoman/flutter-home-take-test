import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: tabGray,
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          alignment: WrapAlignment.spaceBetween,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            const Text(
                              'Wallet Balance (Ks)',
                              style: TextStyle(fontSize: 15),
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
                              child: const Text(
                                'HISTORY',
                                style: TextStyle(
                                  color: tabPink,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          _visible ? '0 Ks' : '****',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          style: FilledButton.styleFrom(
                            backgroundColor: tabBlue,
                            foregroundColor: Colors.white,
                          ),
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
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Gifts bring people together',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            Icon(Icons.card_giftcard, color: tabPink),
                          ],
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Select an amount and send out to your loved ones',
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 16),
                        TextButton.icon(
                          onPressed: () => showTabSheet(
                            context,
                            'Send Gift Card',
                            'No gift cards available.',
                          ),
                          icon: const Icon(Icons.north_east, color: tabPink),
                          label: const Text(
                            'SEND GIFT CARD',
                            style: TextStyle(
                              color: tabPink,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Gift cards you received',
                    style: TextStyle(fontSize: 16),
                  ),
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
            style: const TextStyle(fontSize: 17),
          ),
          const SizedBox(height: 170),
        ],
      ),
    ),
  );
}
