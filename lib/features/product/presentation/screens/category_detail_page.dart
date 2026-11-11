import 'package:flutter/material.dart';

import '../widgets/product_collection_page.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({
    super.key,
    required this.id,
    this.name,
    this.imageUrl,
  });

  final String id;
  final String? name;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return ProductCollectionPage(
      id: id,
      kind: ProductCollectionKind.category,
      initialName: name,
      initialImageUrl: imageUrl,
    );
  }
}
