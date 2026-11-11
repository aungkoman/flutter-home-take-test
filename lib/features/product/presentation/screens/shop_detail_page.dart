import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../cart/presentation/providers/selected_shop_provider.dart';
import '../providers/catalog_provider.dart';

class ShopDetailPage extends ConsumerStatefulWidget {
  const ShopDetailPage({super.key, required this.id});

  final String id;

  @override
  ConsumerState<ShopDetailPage> createState() => _ShopDetailPageState();
}

class _ShopDetailPageState extends ConsumerState<ShopDetailPage> {
  bool _selecting = false;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Scaffold(
      backgroundColor: colors.pageBackground,
      appBar: AppBar(title: const Text('Shop details')),
      body: ref
          .watch(catalogProvider)
          .when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) => Center(
              child: TextButton(
                onPressed: () => ref.invalidate(catalogProvider),
                child: const Text('Could not load this shop. Try again'),
              ),
            ),
            data: (catalog) {
              final matches = catalog.shops.where(
                (shop) => shop.id.toString() == widget.id,
              );
              if (matches.isEmpty) {
                return const Center(child: Text('Shop not found.'));
              }
              final shop = matches.first;
              return ListView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 140),
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      color: colors.cyanSoft,
                      borderRadius: BorderRadius.circular(AppRadii.cardXl),
                    ),
                    child: Icon(
                      Icons.storefront_rounded,
                      size: 88,
                      color: colors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    shop.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 20),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.location_on_outlined),
                    title: const Text('Address'),
                    subtitle: SelectableText(shop.address),
                  ),
                  if (shop.description.trim().isNotEmpty) ...[
                    const SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: const Icon(Icons.info_outline_rounded),
                      title: const Text('Shop information'),
                      subtitle: SelectableText(shop.description),
                    ),
                  ],
                  const SizedBox(height: 12),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.map_outlined),
                    title: const Text('Location coordinates'),
                    subtitle: SelectableText(
                      '${shop.lat.toStringAsFixed(6)}, ${shop.lng.toStringAsFixed(6)}',
                    ),
                  ),
                  const SizedBox(height: 28),
                  FilledButton.icon(
                    onPressed: _selecting
                        ? null
                        : () async {
                            setState(() => _selecting = true);
                            try {
                              await ref
                                  .read(selectedShopProvider.notifier)
                                  .selectShop(shop);
                              if (context.mounted) {
                                context.push('/home/catalog');
                              }
                            } catch (_) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Could not select this shop. Try again.',
                                    ),
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) setState(() => _selecting = false);
                            }
                          },
                    icon: const Icon(Icons.shopping_bag_outlined),
                    label: Text(_selecting ? 'Selecting shop…' : 'Shop here'),
                  ),
                ],
              );
            },
          ),
    );
  }
}
