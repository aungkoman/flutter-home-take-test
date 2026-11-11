import 'package:flutter/material.dart';

import '../../../home/presentation/widgets/tab_ui.dart';

class RewardPage extends StatefulWidget {
  const RewardPage({super.key});
  @override
  State<RewardPage> createState() => _RewardPageState();
}

class _RewardPageState extends State<RewardPage> {
  int _selected = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: tabGray,
    body: SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: const Color(0xFFFCF8FD),
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: SafeArea(
              bottom: false,
              child: Column(
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          "J’Donuts Rewards",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF58A38),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Text(
                          'Reward  0',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            _tier(
                              'Silver',
                              'Membership Required',
                              const Color(0xFFBAC0C7),
                            ),
                            _tier(
                              'Gold',
                              "You’ll be here soon",
                              const Color(0xFFE3C46D),
                            ),
                            _tier(
                              'Platinum',
                              "You’ll be here soon",
                              const Color(0xFF8BCDDD),
                              last: true,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Expanded(
                        child: Column(
                          children: [
                            Text(
                              'Point Balance',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: 12),
                            Divider(color: Colors.black87),
                            SizedBox(height: 12),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TabPills(
              labels: const ['Eat more Earn more', 'Gift'],
              selected: _selected,
              onSelected: (int value) => setState(() => _selected = value),
            ),
          ),
          const SizedBox(height: 48),
          Icon(
            _selected == 0
                ? Icons.receipt_long_outlined
                : Icons.card_giftcard_outlined,
            size: 112,
            color: const Color(0xFF83BFCF),
          ),
          const SizedBox(height: 32),
          Text(
            _selected == 0 ? 'No Promotion Found' : 'No Gifts Found',
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 160),
        ],
      ),
    ),
  );
  Widget _tier(
    String name,
    String subtitle,
    Color color, {
    bool last = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: 12),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.workspace_premium_outlined, size: 38, color: color),
            if (!last)
              Container(width: 4, height: 38, color: const Color(0xFFE8EBE7)),
          ],
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ),
      ],
    ),
  );
}
