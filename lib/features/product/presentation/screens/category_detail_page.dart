import 'package:flutter/material.dart';

import '../widgets/product_collection_page.dart';

class CategoryDetailPage extends StatelessWidget {
  const CategoryDetailPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return ProductCollectionPage(id: id, kind: ProductCollectionKind.category);
  }
}
