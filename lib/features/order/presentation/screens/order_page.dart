import 'package:flutter/material.dart';

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
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: tabGray,
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
                      const Positioned.fill(
                        child: ColoredBox(
                          color: Color(0xFFF4F5F3),
                          child: Center(
                            child: Icon(
                              Icons.map_outlined,
                              size: 160,
                              color: Color(0xFFDCE3DC),
                            ),
                          ),
                        ),
                      ),
                      SafeArea(
                        bottom: false,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Shop at',
                                style: TextStyle(
                                  color: Color(0xFF858D91),
                                  fontSize: 15,
                                ),
                              ),
                              DropdownButton<String>(
                                isExpanded: true,
                                value: _city,
                                underline: const SizedBox.shrink(),
                                style: TextStyle(
                                  fontFamily: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.fontFamily,
                                  color: Color(0xFF292E33),
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                ),
                                items: const ['Minhla', 'Yangon', 'Mandalay']
                                    .map(
                                      (String city) => DropdownMenuItem<String>(
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
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: 36,
                        height: 4,
                        decoration: BoxDecoration(
                          color: const Color(0xFFDEDEDE),
                          borderRadius: BorderRadius.circular(4),
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
                        style: TextStyle(
                          fontFamily: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.fontFamily,
                          fontSize: 16,
                        ),
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
