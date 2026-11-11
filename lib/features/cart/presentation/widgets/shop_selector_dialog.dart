import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../product/presentation/providers/catalog_provider.dart';
import '../providers/selected_shop_provider.dart';

Future<ShopEntity?> showShopSelector(
  BuildContext context,
  WidgetRef ref,
) async {
  final ProductCatalog catalog = await ref.read(catalogProvider.future);
  if (!context.mounted) return null;

  final ShopEntity? shop = await showDialog<ShopEntity>(
    context: context,
    builder: (BuildContext dialogContext) => AlertDialog(
      title: const Text('Choose a shop'),
      content: SizedBox(
        width: double.maxFinite,
        child: catalog.shops.isEmpty
            ? const Text('No shops are available right now.')
            : ListView(
                shrinkWrap: true,
                children: [
                  for (final ShopEntity option in catalog.shops)
                    ListTile(
                      leading: const Icon(Icons.storefront_outlined),
                      title: Text(option.name),
                      subtitle: Text(option.address),
                      onTap: () => Navigator.of(dialogContext).pop(option),
                    ),
                ],
              ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: const Text('CANCEL'),
        ),
      ],
    ),
  );
  if (shop == null) return null;

  await ref.read(selectedShopProvider.notifier).selectShop(shop);
  return shop;
}
