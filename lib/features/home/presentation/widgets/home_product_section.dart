import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../product/domain/entities/product_entity.dart';

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({
    super.key,
    required this.title,
    required this.products,
    required this.onViewAll,
  });

  final String title;
  final List<ProductEntity> products;
  final VoidCallback onViewAll;

  @override
  Widget build(BuildContext context) {
    final bool isPopular = title.toLowerCase().contains('popular');
    final bool isSeasonal = title.toLowerCase().contains('season');
    final double cardWidth =
        (MediaQuery.sizeOf(context).width * (isSeasonal ? 0.57 : 0.40))
            .clamp(136.0, 240.0)
            .toDouble();
    final double imageHeight =
        cardWidth * (isSeasonal ? 0.67 : (isPopular ? 1.4 : 1.05));
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF292F33),
                          ),
                        ),
                      ),
                      if (isPopular || isSeasonal) ...[
                        const SizedBox(width: 7),
                        Icon(
                          isPopular
                              ? Icons.local_fire_department_rounded
                              : Icons.favorite_rounded,
                          color: isPopular
                              ? const Color(0xFFF6A44D)
                              : const Color(0xFFDC629F),
                          size: 24,
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton.filled(
                  tooltip: 'View all $title',
                  onPressed: onViewAll,
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF292F33),
                  ),
                  icon: const Icon(Icons.chevron_right_rounded),
                ),
              ],
            ),
          ),
          SizedBox(
            height:
                imageHeight +
                MediaQuery.textScalerOf(context).scale(14) *
                    (isSeasonal ? 1.25 : 2.5) +
                20,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final ProductEntity product = products[index];
                return SizedBox(
                  width: cardWidth,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(22),
                    onTap: () => context.push('/products/${product.id}'),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: imageHeight,
                          width: cardWidth,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.contain,
                            semanticLabel: product.name,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.bakery_dining_outlined,
                                  size: 48,
                                ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Text(
                            product.name,
                            maxLines: isSeasonal ? 1 : 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              height: 1.25,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF202529),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
