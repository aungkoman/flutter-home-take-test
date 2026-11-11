import 'package:flutter/material.dart';

/// Design spacing tokens used across the J'Donuts application.
abstract final class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double xxl = 32;
}

/// Design corner-radius tokens used across cards, inputs, sheets, and pills.
abstract final class AppRadii {
  static const double sm = 8;
  static const double md = 12;
  static const double input = 14;
  static const double card = 16;
  static const double detailCard = 17;
  static const double cardLg = 22;
  static const double cardXl = 24;
  static const double sheet = 28;
  static const double pill = 30;
}

/// Brand and surface colors beyond standard [ColorScheme] slots.
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.pageBackground,
    required this.headerCyan,
    required this.blushBackground,
    required this.blushHeader,
    required this.blushGradientStart,
    required this.blushGradientMiddle,
    required this.blushGradientEnd,
    required this.pinkSoft,
    required this.pinkDisabled,
    required this.pinkDeep,
    required this.cyanLight,
    required this.cyanSoft,
    required this.surfaceMuted,
    required this.categoryAppBar,
    required this.categoryHeader,
    required this.productTypeHeader,
    required this.orangeBadge,
    required this.infoGreen,
    required this.textPrimary,
    required this.textSecondary,
    required this.textMuted,
    required this.border,
    required this.divider,
    required this.progressTrack,
    required this.dragHandle,
    required this.mapBackground,
    required this.mapIcon,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.shadow,
    required this.bannerPalette,
    required this.socialGoogle,
    required this.socialApple,
    required this.socialFacebook,
    required this.placeholderSky,
    required this.placeholderPeach,
    required this.placeholderCocoa,
  });

  final Color pageBackground;
  final Color headerCyan;
  final Color blushBackground;
  final Color blushHeader;
  final Color blushGradientStart;
  final Color blushGradientMiddle;
  final Color blushGradientEnd;
  final Color pinkSoft;
  final Color pinkDisabled;
  final Color pinkDeep;
  final Color cyanLight;
  final Color cyanSoft;
  final Color surfaceMuted;
  final Color categoryAppBar;
  final Color categoryHeader;
  final Color productTypeHeader;
  final Color orangeBadge;
  final Color infoGreen;
  final Color textPrimary;
  final Color textSecondary;
  final Color textMuted;
  final Color border;
  final Color divider;
  final Color progressTrack;
  final Color dragHandle;
  final Color mapBackground;
  final Color mapIcon;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color shadow;
  final List<Color> bannerPalette;
  final Color socialGoogle;
  final Color socialApple;
  final Color socialFacebook;
  final Color placeholderSky;
  final Color placeholderPeach;
  final Color placeholderCocoa;

  static const AppColors light = AppColors(
    pageBackground: Color(0xFFF0F1F3),
    headerCyan: Color(0xFFC7E7EF),
    blushBackground: Color(0xFFFDF4F6),
    blushHeader: Color(0xFFFCF8FD),
    blushGradientStart: Color(0xFFFCECF2),
    blushGradientMiddle: Color(0xFFFFFAFC),
    blushGradientEnd: Color(0xFFFFF5F8),
    pinkSoft: Color(0xFFF6D6E7),
    pinkDisabled: Color(0xFFF8B7D8),
    pinkDeep: Color(0xFF9F3D6C),
    cyanLight: Color(0xFF91DDF6),
    cyanSoft: Color(0xFFE9F8FB),
    surfaceMuted: Color(0xFFF6F7F7),
    categoryAppBar: Color(0xFFC7703D),
    categoryHeader: Color(0xFFDB8C4B),
    productTypeHeader: Color(0xFF72BFD2),
    orangeBadge: Color(0xFFF58A38),
    infoGreen: Color(0xFF83C341),
    textPrimary: Color(0xFF24292D),
    textSecondary: Color(0xFF50545D),
    textMuted: Color(0xFF858D91),
    border: Color(0xFFDFE2E2),
    divider: Color(0xFFCED3D4),
    progressTrack: Color(0xFFECEEF0),
    dragHandle: Color(0xFFDEDEDE),
    mapBackground: Color(0xFFF4F5F3),
    mapIcon: Color(0xFFDCE3DC),
    shimmerBase: Color(0xFFE6E8E9),
    shimmerHighlight: Color(0xFFF5F6F6),
    shadow: Color(0x1F000000),
    bannerPalette: [
      Color(0xFFFFF0DE),
      Color(0xFFF7DEEA),
      Color(0xFFE6EFF9),
    ],
    socialGoogle: Color(0xFFE53935),
    socialApple: Color(0xFF000000),
    socialFacebook: Color(0xFF1976D2),
    placeholderSky: Color(0xFFB3E5FC),
    placeholderPeach: Color(0xFFFFCC80),
    placeholderCocoa: Color(0xFF795548),
  );

  List<Color> get blushGradient => [
    blushGradientStart,
    blushGradientMiddle,
    blushGradientEnd,
  ];

  @override
  AppColors copyWith({
    Color? pageBackground,
    Color? headerCyan,
    Color? blushBackground,
    Color? blushHeader,
    Color? blushGradientStart,
    Color? blushGradientMiddle,
    Color? blushGradientEnd,
    Color? pinkSoft,
    Color? pinkDisabled,
    Color? pinkDeep,
    Color? cyanLight,
    Color? cyanSoft,
    Color? surfaceMuted,
    Color? categoryAppBar,
    Color? categoryHeader,
    Color? productTypeHeader,
    Color? orangeBadge,
    Color? infoGreen,
    Color? textPrimary,
    Color? textSecondary,
    Color? textMuted,
    Color? border,
    Color? divider,
    Color? progressTrack,
    Color? dragHandle,
    Color? mapBackground,
    Color? mapIcon,
    Color? shimmerBase,
    Color? shimmerHighlight,
    Color? shadow,
    List<Color>? bannerPalette,
    Color? socialGoogle,
    Color? socialApple,
    Color? socialFacebook,
    Color? placeholderSky,
    Color? placeholderPeach,
    Color? placeholderCocoa,
  }) {
    return AppColors(
      pageBackground: pageBackground ?? this.pageBackground,
      headerCyan: headerCyan ?? this.headerCyan,
      blushBackground: blushBackground ?? this.blushBackground,
      blushHeader: blushHeader ?? this.blushHeader,
      blushGradientStart: blushGradientStart ?? this.blushGradientStart,
      blushGradientMiddle: blushGradientMiddle ?? this.blushGradientMiddle,
      blushGradientEnd: blushGradientEnd ?? this.blushGradientEnd,
      pinkSoft: pinkSoft ?? this.pinkSoft,
      pinkDisabled: pinkDisabled ?? this.pinkDisabled,
      pinkDeep: pinkDeep ?? this.pinkDeep,
      cyanLight: cyanLight ?? this.cyanLight,
      cyanSoft: cyanSoft ?? this.cyanSoft,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      categoryAppBar: categoryAppBar ?? this.categoryAppBar,
      categoryHeader: categoryHeader ?? this.categoryHeader,
      productTypeHeader: productTypeHeader ?? this.productTypeHeader,
      orangeBadge: orangeBadge ?? this.orangeBadge,
      infoGreen: infoGreen ?? this.infoGreen,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textMuted: textMuted ?? this.textMuted,
      border: border ?? this.border,
      divider: divider ?? this.divider,
      progressTrack: progressTrack ?? this.progressTrack,
      dragHandle: dragHandle ?? this.dragHandle,
      mapBackground: mapBackground ?? this.mapBackground,
      mapIcon: mapIcon ?? this.mapIcon,
      shimmerBase: shimmerBase ?? this.shimmerBase,
      shimmerHighlight: shimmerHighlight ?? this.shimmerHighlight,
      shadow: shadow ?? this.shadow,
      bannerPalette: bannerPalette ?? this.bannerPalette,
      socialGoogle: socialGoogle ?? this.socialGoogle,
      socialApple: socialApple ?? this.socialApple,
      socialFacebook: socialFacebook ?? this.socialFacebook,
      placeholderSky: placeholderSky ?? this.placeholderSky,
      placeholderPeach: placeholderPeach ?? this.placeholderPeach,
      placeholderCocoa: placeholderCocoa ?? this.placeholderCocoa,
    );
  }

  @override
  AppColors lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    final int count = bannerPalette.length < other.bannerPalette.length
        ? bannerPalette.length
        : other.bannerPalette.length;
    return AppColors(
      pageBackground: Color.lerp(pageBackground, other.pageBackground, t)!,
      headerCyan: Color.lerp(headerCyan, other.headerCyan, t)!,
      blushBackground: Color.lerp(blushBackground, other.blushBackground, t)!,
      blushHeader: Color.lerp(blushHeader, other.blushHeader, t)!,
      blushGradientStart: Color.lerp(
        blushGradientStart,
        other.blushGradientStart,
        t,
      )!,
      blushGradientMiddle: Color.lerp(
        blushGradientMiddle,
        other.blushGradientMiddle,
        t,
      )!,
      blushGradientEnd: Color.lerp(
        blushGradientEnd,
        other.blushGradientEnd,
        t,
      )!,
      pinkSoft: Color.lerp(pinkSoft, other.pinkSoft, t)!,
      pinkDisabled: Color.lerp(pinkDisabled, other.pinkDisabled, t)!,
      pinkDeep: Color.lerp(pinkDeep, other.pinkDeep, t)!,
      cyanLight: Color.lerp(cyanLight, other.cyanLight, t)!,
      cyanSoft: Color.lerp(cyanSoft, other.cyanSoft, t)!,
      surfaceMuted: Color.lerp(surfaceMuted, other.surfaceMuted, t)!,
      categoryAppBar: Color.lerp(categoryAppBar, other.categoryAppBar, t)!,
      categoryHeader: Color.lerp(categoryHeader, other.categoryHeader, t)!,
      productTypeHeader: Color.lerp(
        productTypeHeader,
        other.productTypeHeader,
        t,
      )!,
      orangeBadge: Color.lerp(orangeBadge, other.orangeBadge, t)!,
      infoGreen: Color.lerp(infoGreen, other.infoGreen, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textMuted: Color.lerp(textMuted, other.textMuted, t)!,
      border: Color.lerp(border, other.border, t)!,
      divider: Color.lerp(divider, other.divider, t)!,
      progressTrack: Color.lerp(progressTrack, other.progressTrack, t)!,
      dragHandle: Color.lerp(dragHandle, other.dragHandle, t)!,
      mapBackground: Color.lerp(mapBackground, other.mapBackground, t)!,
      mapIcon: Color.lerp(mapIcon, other.mapIcon, t)!,
      shimmerBase: Color.lerp(shimmerBase, other.shimmerBase, t)!,
      shimmerHighlight: Color.lerp(
        shimmerHighlight,
        other.shimmerHighlight,
        t,
      )!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      bannerPalette: [
        for (int i = 0; i < count; i++)
          Color.lerp(bannerPalette[i], other.bannerPalette[i], t)!,
      ],
      socialGoogle: Color.lerp(socialGoogle, other.socialGoogle, t)!,
      socialApple: Color.lerp(socialApple, other.socialApple, t)!,
      socialFacebook: Color.lerp(socialFacebook, other.socialFacebook, t)!,
      placeholderSky: Color.lerp(placeholderSky, other.placeholderSky, t)!,
      placeholderPeach: Color.lerp(
        placeholderPeach,
        other.placeholderPeach,
        t,
      )!,
      placeholderCocoa: Color.lerp(
        placeholderCocoa,
        other.placeholderCocoa,
        t,
      )!,
    );
  }
}

/// Centralized Material 3 theme configuration for J'Donuts.
abstract final class AppTheme {
  static const Color _brandCyan = Color(0xFF60C1DE);
  static const Color _brandPink = Color(0xFFDC629F);

  static ThemeData get light {
    const AppColors colors = AppColors.light;

    final ColorScheme colorScheme = ColorScheme.light(
      primary: _brandCyan,
      onPrimary: Colors.white,
      primaryContainer: colors.headerCyan,
      onPrimaryContainer: colors.textPrimary,
      secondary: _brandPink,
      onSecondary: Colors.white,
      secondaryContainer: colors.pinkSoft,
      onSecondaryContainer: colors.pinkDeep,
      tertiary: colors.orangeBadge,
      onTertiary: Colors.white,
      surface: Colors.white,
      onSurface: colors.textPrimary,
      onSurfaceVariant: colors.textSecondary,
      surfaceContainerLowest: Colors.white,
      surfaceContainerLow: colors.blushHeader,
      surfaceContainer: colors.pageBackground,
      surfaceContainerHigh: colors.shimmerBase,
      surfaceContainerHighest: colors.mapIcon,
      outline: colors.border,
      outlineVariant: colors.divider,
    );

    final TextTheme textTheme = TextTheme(
      displaySmall: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w800,
        height: 1.2,
        letterSpacing: -0.5,
        color: colors.textPrimary,
      ),
      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w800,
        height: 1.2,
        color: colors.textPrimary,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 1.15,
        color: colors.textPrimary,
      ),
      headlineSmall: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        height: 1.2,
        color: colors.textPrimary,
      ),
      titleLarge: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: colors.textPrimary,
      ),
      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w700,
        height: 1.25,
        color: colors.textPrimary,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: colors.textPrimary,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: colors.textSecondary,
      ),
      bodySmall: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: colors.textSecondary,
      ),
      labelLarge: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
      ),
      labelMedium: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        color: colors.textSecondary,
      ),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        height: 1.4,
        color: colors.textMuted,
      ),
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: colors.pageBackground,
      textTheme: textTheme,
      extensions: const <ThemeExtension<dynamic>>[colors],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        foregroundColor: colors.textPrimary,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _brandCyan,
          foregroundColor: Colors.white,
          disabledBackgroundColor: _brandCyan.withValues(alpha: 0.45),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          minimumSize: const Size(0, 54),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.2,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: _brandCyan,
          foregroundColor: Colors.white,
          disabledBackgroundColor: _brandCyan.withValues(alpha: 0.45),
          disabledForegroundColor: Colors.white,
          elevation: 0,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: colors.textPrimary,
          side: BorderSide(color: colors.border),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: _brandPink,
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(color: colors.textMuted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.lg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadii.input),
          borderSide: const BorderSide(color: _brandPink, width: 1.5),
        ),
      ),
      chipTheme: ChipThemeData(
        selectedColor: _brandCyan,
        backgroundColor: colors.pageBackground,
        side: const BorderSide(color: Colors.white, width: 2),
        shape: const StadiumBorder(),
        showCheckmark: false,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 10,
        ),
        labelStyle: TextStyle(
          color: colors.textMuted,
          fontWeight: FontWeight.w400,
        ),
      ),
      listTileTheme: ListTileThemeData(
        iconColor: colors.textMuted,
        titleTextStyle: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w700,
          color: colors.textPrimary,
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: _brandPink,
        linearTrackColor: colors.progressTrack,
        circularTrackColor: colors.progressTrack,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        showDragHandle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadii.sheet),
          ),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.cardLg),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: colors.textPrimary,
        contentTextStyle: const TextStyle(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.md),
        ),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.cardXl),
        ),
      ),
      tabBarTheme: TabBarThemeData(
        labelColor: _brandPink,
        unselectedLabelColor: colors.textSecondary,
        indicatorColor: _brandPink,
      ),
    );
  }
}

/// Convenient [BuildContext] getters for accessing theme tokens without boilerplate.
extension AppThemeContext on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => theme.colorScheme;
  TextTheme get textTheme => theme.textTheme;
  AppColors get appColors => theme.extension<AppColors>() ?? AppColors.light;
}
