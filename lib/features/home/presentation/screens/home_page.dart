import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../auth/presentation/providers/login_provider.dart';
import '../../../auth/presentation/providers/otp_verify_provider.dart';
import '../../../auth/presentation/providers/register_provider.dart';
import '../../../product/presentation/providers/catalog_provider.dart';
import '../../../product/presentation/widgets/loading_effects.dart';
import '../widgets/home_account_header.dart';
import '../widgets/home_banner_carousel.dart';
import '../widgets/home_product_section.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<ProductCatalog> catalog = ref.watch(catalogProvider);
    final UserEntity? loginUser = ref.watch(loginProvider).value;
    final UserEntity? verifiedUser = ref.watch(otpVerifyProvider).value;
    final UserEntity? registeredUser = ref.watch(registerProvider).value;
    final UserEntity? user =
        (registeredUser?.id == verifiedUser?.id ? registeredUser : null) ??
        verifiedUser ??
        loginUser;

    return Scaffold(
      backgroundColor: const Color(0xFFF0F1F3),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(catalogProvider);
          await ref.read(catalogProvider.future);
        },
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: ColoredBox(
                color: const Color(0xFFC7E7EF),
                child: HomeAccountHeader(user: user),
              ),
            ),
            ...catalog.when<List<Widget>>(
              loading: () => const [HomeCatalogSkeleton()],
              error: (error, stackTrace) => [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Could not load your treats.'),
                        TextButton(
                          onPressed: () => ref.invalidate(catalogProvider),
                          child: const Text('Try again'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              data: (ProductCatalog data) {
                final Set<String> typeNames = data.productTypes
                    .map((type) => type.name.toLowerCase())
                    .toSet();
                final List<CategoryEntity> featured = data.categories
                    .where(
                      (category) =>
                          category.isActive &&
                          category.categoryProducts.isNotEmpty &&
                          category.name.toLowerCase() != 'all' &&
                          !typeNames.contains(category.name.toLowerCase()),
                    )
                    .toList();
                final List<Widget> sections = [];
                for (final (int index, CategoryEntity category)
                    in featured.indexed) {
                  sections.add(
                    StaggeredEntrance(
                      index: index,
                      child: HomeProductSection(
                        title: category.name,
                        products: category.categoryProducts
                            .map((link) => link.product)
                            .toList(),
                        collectionKind: 'category',
                        collectionId: category.id,
                        imageUrl: category.imageUrl,
                        onViewAll: () => context.push(
                          '/categories/${category.id}',
                          extra: category,
                        ),
                      ),
                    ),
                  );
                }
                for (final (int index, ProductTypeEntity type)
                    in data.productTypes.indexed) {
                  if (type.products.isNotEmpty) {
                    sections.add(
                      StaggeredEntrance(
                        index: featured.length + index,
                        child: HomeProductSection(
                          title: type.name,
                          products: type.products,
                          collectionKind: 'product-type',
                          collectionId: type.id,
                          imageUrl: type.imageUrl,
                          onViewAll: () => context.push(
                            '/product-types/${type.id}',
                            extra: type,
                          ),
                        ),
                      ),
                    );
                  }
                }
                sections.add(
                  StaggeredEntrance(
                    index: sections.length,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 140),
                      child: OutlinedButton.icon(
                        onPressed: () => context.push('/catalog'),
                        icon: const Icon(Icons.grid_view_rounded),
                        label: const Text('View full catalog'),
                      ),
                    ),
                  ),
                );
                return [
                  SliverToBoxAdapter(
                    child: StaggeredEntrance(
                      child: Container(
                        decoration: const BoxDecoration(
                          color: Color(0xFFC7E7EF),
                          borderRadius: BorderRadius.vertical(
                            bottom: Radius.circular(30),
                          ),
                        ),
                        child: HomeBannerCarousel(
                          key: ValueKey(
                            data.banners.map((banner) => banner.id).join(','),
                          ),
                          banners: data.banners,
                        ),
                      ),
                    ),
                  ),
                  SliverList(delegate: SliverChildListDelegate(sections)),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
