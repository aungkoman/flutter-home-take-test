import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../product/domain/entities/shop_entity.dart';

class HomeShopsSection extends StatefulWidget {
  const HomeShopsSection({super.key, required this.shops});

  final List<ShopEntity> shops;

  @override
  State<HomeShopsSection> createState() => _HomeShopsSectionState();
}

class _HomeShopsSectionState extends State<HomeShopsSection> {
  late List<ShopEntity> _shops;

  @override
  void initState() {
    super.initState();
    _pickShops();
  }

  @override
  void didUpdateWidget(HomeShopsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.shops != widget.shops) _pickShops();
  }

  void _pickShops() {
    _shops = (List<ShopEntity>.of(widget.shops)..shuffle()).take(4).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_shops.isEmpty) return const SizedBox.shrink();
    final colors = context.appColors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nearest shops', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 4),
          Text(
            'Discover a spot for your next treat.',
            style: TextStyle(color: colors.textSecondary),
          ),
          const SizedBox(height: 16),
          LayoutBuilder(
            builder: (context, constraints) {
              final cardWidth = (constraints.maxWidth * .85).clamp(
                240.0,
                320.0,
              );
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (final shop in _shops)
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: SizedBox(
                          width: cardWidth,
                          child: Card(
                            margin: EdgeInsets.zero,
                            clipBehavior: Clip.antiAlias,
                            child: InkWell(
                              onTap: () =>
                                  context.push('/home/shops/${shop.id}'),
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: colors.cyanSoft,
                                      foregroundColor: colors.textPrimary,
                                      child: const Icon(
                                        Icons.storefront_rounded,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      shop.name,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      shop.address,
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: colors.textSecondary,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    const Row(
                                      children: [
                                        Text('Shop details'),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.chevron_right_rounded,
                                          size: 18,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
