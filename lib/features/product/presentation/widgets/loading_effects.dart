import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import 'product_hero_tags.dart';

class StaggeredEntrance extends StatefulWidget {
  const StaggeredEntrance({
    super.key,
    required this.child,
    this.index = 0,
    this.delay,
  });

  final Widget child;
  final int index;
  final Duration? delay;

  @override
  State<StaggeredEntrance> createState() => _StaggeredEntranceState();
}

class _StaggeredEntranceState extends State<StaggeredEntrance>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _position;
  bool _animationConfigured = false;

  @override
  void initState() {
    super.initState();
    final Duration delay =
        widget.delay ?? Duration(milliseconds: widget.index.clamp(0, 8) * 65);
    const Duration duration = Duration(milliseconds: 420);
    _controller = AnimationController(vsync: this, duration: delay + duration);
    final double start =
        delay.inMicroseconds / (delay + duration).inMicroseconds;
    final Animation<double> entrance = CurvedAnimation(
      parent: _controller,
      curve: Interval(start, 1, curve: Curves.easeOutCubic),
    );
    _opacity = entrance;
    _position = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(entrance);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_animationConfigured) return;
    _animationConfigured = true;
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller.value = 1;
    } else {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => FadeTransition(
    opacity: _opacity,
    child: SlideTransition(position: _position, child: widget.child),
  );
}

class SkeletonBlock extends StatefulWidget {
  const SkeletonBlock({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppRadii.md,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<SkeletonBlock> createState() => _SkeletonBlockState();
}

class _SkeletonBlockState extends State<SkeletonBlock>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _animationConfigured = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1150),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_animationConfigured) return;
    _animationConfigured = true;
    if (!MediaQuery.disableAnimationsOf(context)) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AppColors appColors = context.appColors;
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double shift = _controller.value * 2 - 1;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            gradient: LinearGradient(
              begin: Alignment(-1.5 + shift, -0.2),
              end: Alignment(1.5 + shift, 0.2),
              colors: [
                appColors.shimmerBase,
                appColors.shimmerHighlight,
                appColors.shimmerBase,
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeCatalogSkeleton extends StatelessWidget {
  const HomeCatalogSkeleton({super.key});

  @override
  Widget build(BuildContext context) => SliverList(
    delegate: SliverChildListDelegate([
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: SkeletonBlock(
          width: double.infinity,
          height: 176,
          borderRadius: AppRadii.cardXl,
        ),
      ),
      for (int section = 0; section < 3; section++)
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(24, 0, 24, 14),
                child: SkeletonBlock(width: 142, height: 25),
              ),
              SizedBox(
                height: 200,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  separatorBuilder: (context, index) =>
                      const SizedBox(width: 14),
                  itemBuilder: (context, index) => const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SkeletonBlock(
                        width: 152,
                        height: 152,
                        borderRadius: AppRadii.cardLg,
                      ),
                      SizedBox(height: 10),
                      SkeletonBlock(width: 120, height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    ]),
  );
}

class ProductCollectionSkeleton extends StatelessWidget {
  const ProductCollectionSkeleton({
    super.key,
    required this.title,
    required this.kind,
    required this.id,
    this.imageUrl,
  });

  final String title;
  final String kind;
  final int id;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 180,
            backgroundColor: appColors.categoryAppBar,
            foregroundColor: colorScheme.onPrimary,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.fromLTRB(24, 0, 20, 18),
              title: Hero(
                tag: ProductHeroTags.collectionTitle(kind, id),
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: context.textTheme.headlineSmall?.copyWith(
                      color: colorScheme.onPrimary,
                    ),
                  ),
                ),
              ),
              background: ColoredBox(
                color: kind == 'category'
                    ? appColors.categoryHeader
                    : appColors.productTypeHeader,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: FractionallySizedBox(
                    widthFactor: 0.58,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(12, 32, 20, 20),
                      child: imageUrl == null || imageUrl!.isEmpty
                          ? const SkeletonBlock(
                              width: 130,
                              height: 120,
                              borderRadius: 18,
                            )
                          : Hero(
                              tag: ProductHeroTags.collectionImage(kind, id),
                              child: Image.asset(
                                imageUrl!,
                                fit: BoxFit.contain,
                                excludeFromSemantics: true,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      Icons.bakery_dining_outlined,
                                      size: 72,
                                      color: colorScheme.onPrimary,
                                    ),
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 16, 24, 24),
              child: SkeletonBlock(
                width: double.infinity,
                height: 54,
                borderRadius: AppRadii.input,
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(AppSpacing.xl),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 14,
                mainAxisSpacing: 20,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) => const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: SkeletonBlock(
                        width: double.infinity,
                        height: double.infinity,
                        borderRadius: AppRadii.card,
                      ),
                    ),
                    SizedBox(height: 10),
                    SkeletonBlock(width: 130, height: 14),
                    SizedBox(height: 8),
                    SkeletonBlock(width: 75, height: 14),
                  ],
                ),
                childCount: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductDetailSkeleton extends StatelessWidget {
  const ProductDetailSkeleton({
    super.key,
    this.productId,
    this.productName,
    this.imageUrl,
    this.heroScope,
  });

  final int? productId;
  final String? productName;
  final String? imageUrl;
  final String? heroScope;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Expanded(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 30, 20, 16),
          child: Column(
            children: [
              Container(
                height: 400,
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadii.detailCard),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SkeletonBlock(width: 100, height: 14),
                    const SizedBox(height: 10),
                    if (productId != null &&
                        productName != null &&
                        heroScope != null)
                      Hero(
                        tag: ProductHeroTags.name(productId!, heroScope!),
                        child: Material(
                          color: Colors.transparent,
                          child: Text(
                            productName!,
                            style: context.textTheme.headlineSmall,
                          ),
                        ),
                      )
                    else
                      const SkeletonBlock(width: 220, height: 30),
                    const SizedBox(height: 10),
                    const SkeletonBlock(width: 105, height: 16),
                    Expanded(
                      child: Center(
                        child:
                            productId != null &&
                                imageUrl != null &&
                                imageUrl!.isNotEmpty &&
                                heroScope != null
                            ? Hero(
                                tag: ProductHeroTags.image(
                                  productId!,
                                  heroScope!,
                                ),
                                child: Image.asset(
                                  imageUrl!,
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const SkeletonBlock(
                                        width: 240,
                                        height: 240,
                                        borderRadius: AppRadii.cardXl,
                                      ),
                                ),
                              )
                            : const SkeletonBlock(
                                width: 240,
                                height: 240,
                                borderRadius: AppRadii.cardXl,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 28),
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SkeletonBlock(width: 66, height: 54),
                  SizedBox(width: 12),
                  SkeletonBlock(width: 1, height: 88),
                  SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SkeletonBlock(width: double.infinity, height: 15),
                        SizedBox(height: 9),
                        SkeletonBlock(width: double.infinity, height: 15),
                        SizedBox(height: 9),
                        SkeletonBlock(width: 180, height: 15),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
        child: SkeletonBlock(
          width: double.infinity,
          height: 56,
          borderRadius: AppRadii.pill,
        ),
      ),
    ],
  );
}
