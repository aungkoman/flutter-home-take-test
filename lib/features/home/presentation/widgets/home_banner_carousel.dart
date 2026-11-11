import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../product/domain/entities/banner_entity.dart';

class HomeBannerCarousel extends StatefulWidget {
  const HomeBannerCarousel({super.key, required this.banners});

  final List<BannerEntity> banners;

  @override
  State<HomeBannerCarousel> createState() => _HomeBannerCarouselState();
}

class _HomeBannerCarouselState extends State<HomeBannerCarousel> {
  final PageController _controller = PageController(viewportFraction: 0.88);
  Timer? _timer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    if (widget.banners.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!mounted ||
            !_controller.hasClients ||
            _controller.position.isScrollingNotifier.value ||
            !TickerMode.valuesOf(context).enabled ||
            ModalRoute.of(context)?.isCurrent != true) {
          return;
        }
        _controller.animateToPage(
          (_page + 1) % widget.banners.length,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.banners.isEmpty) return const SizedBox.shrink();
    final ColorScheme colorScheme = context.colorScheme;
    final AppColors appColors = context.appColors;
    final TextTheme textTheme = context.textTheme;
    final double textScaleExtra =
        (MediaQuery.textScalerOf(context).scale(24) - 24)
            .clamp(0.0, 48.0)
            .toDouble();
    final List<Color> colors = appColors.bannerPalette;
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          SizedBox(
            height: 176 + textScaleExtra * 3,
            child: PageView.builder(
              controller: _controller,
              itemCount: widget.banners.length,
              onPageChanged: (int page) => setState(() => _page = page),
              itemBuilder: (context, index) {
                final BannerEntity banner = widget.banners[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Material(
                    color: colors[index % colors.length],
                    borderRadius: BorderRadius.circular(AppRadii.cardXl),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => context.push('/home/catalog'),
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "J' DONUTS",
                                    style: textTheme.labelSmall?.copyWith(
                                      fontSize: 10,
                                      letterSpacing: 1.5,
                                      fontWeight: FontWeight.w800,
                                      color: appColors.pinkDeep,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    banner.name,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.headlineMedium?.copyWith(
                                      height: 1.05,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          'Explore treats',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: textTheme.labelSmall?.copyWith(
                                            fontWeight: FontWeight.w600,
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: AppSpacing.xs),
                                      const Icon(
                                        Icons.arrow_forward_rounded,
                                        size: 15,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Image.asset(
                                banner.imageUrl,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(
                                      Icons.bakery_dining_outlined,
                                      size: 64,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (widget.banners.length > 1) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(widget.banners.length, (index) {
                return Semantics(
                  label: 'Banner ${index + 1} of ${widget.banners.length}',
                  selected: index == _page,
                  button: true,
                  child: GestureDetector(
                    onTap: () => _controller.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOutCubic,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.sm),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: index == _page ? 20 : 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: index == _page
                              ? colorScheme.secondary
                              : colorScheme.surface,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ],
      ),
    );
  }
}
