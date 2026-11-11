import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../../product/presentation/widgets/product_hero_tags.dart';

class HomeProductSection extends StatelessWidget {
  const HomeProductSection({
    super.key,
    required this.title,
    required this.products,
    required this.onViewAll,
    this.collectionKind,
    this.collectionId,
    this.imageUrl,
    required this.heroScope,
  });

  final String title;
  final List<ProductEntity> products;
  final VoidCallback onViewAll;
  final String? collectionKind;
  final int? collectionId;
  final String? imageUrl;
  final String heroScope;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    final bool isPopular = title.toLowerCase().contains('popular');
    final bool isSeasonal = title.toLowerCase().contains('season');
    final double cardWidth =
        (MediaQuery.sizeOf(context).width * (isSeasonal ? 0.57 : 0.40))
            .clamp(136.0, 240.0)
            .toDouble();
    final double imageHeight =
        cardWidth * (isSeasonal ? 0.67 : (isPopular ? 1.4 : 1.05));
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.sm, bottom: AppSpacing.sm),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      if (imageUrl != null &&
                          imageUrl!.isNotEmpty &&
                          collectionKind != null &&
                          collectionId != null) ...[
                        Hero(
                          tag: ProductHeroTags.collectionImage(
                            collectionKind!,
                            collectionId!,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              imageUrl!,
                              width: 36,
                              height: 36,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  const SizedBox(
                                    width: 36,
                                    height: 36,
                                    child: Icon(Icons.image_outlined, size: 20),
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                      ],
                      Flexible(
                        child: collectionKind != null && collectionId != null
                            ? Hero(
                                tag: ProductHeroTags.collectionTitle(
                                  collectionKind!,
                                  collectionId!,
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: Text(
                                    title,
                                    style: textTheme.headlineSmall,
                                  ),
                                ),
                              )
                            : Text(title, style: textTheme.headlineSmall),
                      ),
                      if (isPopular || isSeasonal) ...[
                        const SizedBox(width: 7),
                        Icon(
                          isPopular
                              ? Icons.local_fire_department_rounded
                              : Icons.favorite_rounded,
                          color: isPopular
                              ? appColors.orangeBadge
                              : colorScheme.secondary,
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
                    backgroundColor: colorScheme.surface,
                    foregroundColor: colorScheme.onSurface,
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
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              separatorBuilder: (context, index) => const SizedBox(width: 14),
              itemBuilder: (context, index) {
                final ProductEntity product = products[index];
                final String productScope = '$heroScope-$index';
                return SizedBox(
                  width: cardWidth,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadii.cardLg),
                    onTap: () => context.push(
                      '/home/products/${product.id}',
                      extra: ProductHeroRouteData(
                        product: product,
                        scope: productScope,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: imageHeight,
                          width: cardWidth,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: colorScheme.surface,
                            borderRadius: BorderRadius.circular(
                              AppRadii.cardXl,
                            ),
                          ),
                          child: Hero(
                            tag: ProductHeroTags.image(
                              product.id,
                              productScope,
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
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3),
                          child: Hero(
                            tag: ProductHeroTags.name(product.id, productScope),
                            child: Material(
                              color: Colors.transparent,
                              child: Text(
                                product.name,
                                maxLines: isSeasonal ? 1 : 2,
                                overflow: TextOverflow.ellipsis,
                                style: textTheme.titleSmall,
                              ),
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
