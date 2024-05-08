import "package:flutter/material.dart";

class MaterialThemeCustom {
  final TextTheme textTheme;

  const MaterialThemeCustom(this.textTheme);

  static MaterialScheme lightScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4279779432),
      surfaceTint: Color(4282146954),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4279779432),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4282208620),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4282208620),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278210611),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4280776275),
      onTertiaryContainer: Color(4294967295),
      error: Color(4286645760),
      onError: Color(4294967295),
      errorContainer: Color(4290650127),
      onErrorContainer: Color(4294967295),
      background: Color(4294572541),
      onBackground: Color(4279901215),
      surface: Color(4294572541),
      onSurface: Color(4279901215),
      surfaceVariant: Color(4292862700),
      onSurfaceVariant: Color(4282599246),
      outline: Color(4285757311),
      outlineVariant: Color(4291020495),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282611),
      inverseOnSurface: Color(4294045940),
      inversePrimary: Color(4289055225),
      primaryFixed: Color(4292011263),
      onPrimaryFixed: Color(4278197303),
      primaryFixedDim: Color(4289055225),
      onPrimaryFixedVariant: Color(4280437105),
      secondaryFixed: Color(4292011263),
      onSecondaryFixed: Color(4278459445),
      secondaryFixedDim: Color(4289972456),
      onSecondaryFixedVariant: Color(4281550946),
      tertiaryFixed: Color(4289065927),
      onTertiaryFixed: Color(4278198546),
      tertiaryFixedDim: Color(4287223724),
      onTertiaryFixedVariant: Color(4278211124),
      surfaceDim: Color(4292532957),
      surfaceBright: Color(4294572541),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243319),
      surfaceContainer: Color(4293848561),
      surfaceContainerHigh: Color(4293454060),
      surfaceContainerHighest: Color(4293059302),
    );
  }

  ThemeData light() {
    return theme(lightScheme().toColorScheme());
  }

  static MaterialScheme lightMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4279779432),
      surfaceTint: Color(4282146954),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4282410126),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4281287774),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4284577426),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278209841),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4280776275),
      onTertiaryContainer: Color(4294967295),
      error: Color(4286645760),
      onError: Color(4294967295),
      errorContainer: Color(4290650127),
      onErrorContainer: Color(4294967295),
      background: Color(4294572541),
      onBackground: Color(4279901215),
      surface: Color(4294572541),
      onSurface: Color(4279901215),
      surfaceVariant: Color(4292862700),
      onSurfaceVariant: Color(4282336074),
      outline: Color(4284178279),
      outlineVariant: Color(4286020483),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282611),
      inverseOnSurface: Color(4294045940),
      inversePrimary: Color(4289055225),
      primaryFixed: Color(4283660194),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4282015368),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4284577426),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4282998137),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4281696862),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4279658822),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292532957),
      surfaceBright: Color(4294572541),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243319),
      surfaceContainer: Color(4293848561),
      surfaceContainerHigh: Color(4293454060),
      surfaceContainerHighest: Color(4293059302),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme lightHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.light,
      primary: Color(4278199106),
      surfaceTint: Color(4282146954),
      onPrimary: Color(4294967295),
      primaryContainer: Color(4280108397),
      onPrimaryContainer: Color(4294967295),
      secondary: Color(4278985532),
      onSecondary: Color(4294967295),
      secondaryContainer: Color(4281287774),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4278200344),
      onTertiary: Color(4294967295),
      tertiaryContainer: Color(4278209841),
      onTertiaryContainer: Color(4294967295),
      error: Color(4283236864),
      onError: Color(4294967295),
      errorContainer: Color(4287235840),
      onErrorContainer: Color(4294967295),
      background: Color(4294572541),
      onBackground: Color(4279901215),
      surface: Color(4294572541),
      onSurface: Color(4278190080),
      surfaceVariant: Color(4292862700),
      onSurfaceVariant: Color(4280296491),
      outline: Color(4282336074),
      outlineVariant: Color(4282336074),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4281282611),
      inverseOnSurface: Color(4294967295),
      inversePrimary: Color(4293062143),
      primaryFixed: Color(4280108397),
      onPrimaryFixed: Color(4294967295),
      primaryFixedDim: Color(4278201939),
      onPrimaryFixedVariant: Color(4294967295),
      secondaryFixed: Color(4281287774),
      onSecondaryFixed: Color(4294967295),
      secondaryFixedDim: Color(4279774791),
      onSecondaryFixedVariant: Color(4294967295),
      tertiaryFixed: Color(4278209841),
      onTertiaryFixed: Color(4294967295),
      tertiaryFixedDim: Color(4278203424),
      onTertiaryFixedVariant: Color(4294967295),
      surfaceDim: Color(4292532957),
      surfaceBright: Color(4294572541),
      surfaceContainerLowest: Color(4294967295),
      surfaceContainerLow: Color(4294243319),
      surfaceContainer: Color(4293848561),
      surfaceContainerHigh: Color(4293454060),
      surfaceContainerHighest: Color(4293059302),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme().toColorScheme());
  }

  static MaterialScheme darkScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4289055225),
      surfaceTint: Color(4289055225),
      onPrimary: Color(4278268505),
      primaryContainer: Color(4280568435),
      onPrimaryContainer: Color(4292076799),
      secondary: Color(4289972456),
      onSecondary: Color(4280037963),
      secondaryContainer: Color(4284577426),
      onSecondaryContainer: Color(4294967295),
      tertiary: Color(4287223724),
      onTertiary: Color(4278204451),
      tertiaryContainer: Color(4278213435),
      onTertiaryContainer: Color(4290052052),
      error: Color(4294948007),
      onError: Color(4284941312),
      errorContainer: Color(4288088320),
      onErrorContainer: Color(4294958808),
      background: Color(4279374614),
      onBackground: Color(4293059302),
      surface: Color(4279374614),
      onSurface: Color(4293059302),
      surfaceVariant: Color(4282599246),
      onSurfaceVariant: Color(4291020495),
      outline: Color(4287467929),
      outlineVariant: Color(4282599246),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059302),
      inverseOnSurface: Color(4281282611),
      inversePrimary: Color(4282146954),
      primaryFixed: Color(4292011263),
      onPrimaryFixed: Color(4278197303),
      primaryFixedDim: Color(4289055225),
      onPrimaryFixedVariant: Color(4280437105),
      secondaryFixed: Color(4292011263),
      onSecondaryFixed: Color(4278459445),
      secondaryFixedDim: Color(4289972456),
      onSecondaryFixedVariant: Color(4281550946),
      tertiaryFixed: Color(4289065927),
      onTertiaryFixed: Color(4278198546),
      tertiaryFixedDim: Color(4287223724),
      onTertiaryFixedVariant: Color(4278211124),
      surfaceDim: Color(4279374614),
      surfaceBright: Color(4281874748),
      surfaceContainerLowest: Color(4279045649),
      surfaceContainerLow: Color(4279901215),
      surfaceContainer: Color(4280164387),
      surfaceContainerHigh: Color(4280822317),
      surfaceContainerHighest: Color(4281546040),
    );
  }

  ThemeData dark() {
    return theme(darkScheme().toColorScheme());
  }

  static MaterialScheme darkMediumContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4289318397),
      surfaceTint: Color(4289055225),
      onPrimary: Color(4278196014),
      primaryContainer: Color(4285567936),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4290235628),
      onSecondary: Color(4278196014),
      secondaryContainer: Color(4286419632),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4287486896),
      onTertiary: Color(4278197006),
      tertiaryContainer: Color(4283670393),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294949550),
      onError: Color(4281729280),
      errorContainer: Color(4294923581),
      onErrorContainer: Color(4278190080),
      background: Color(4279374614),
      onBackground: Color(4293059302),
      surface: Color(4279374614),
      onSurface: Color(4294703870),
      surfaceVariant: Color(4282599246),
      onSurfaceVariant: Color(4291283924),
      outline: Color(4288652203),
      outlineVariant: Color(4286546827),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059302),
      inverseOnSurface: Color(4280822317),
      inversePrimary: Color(4280568434),
      primaryFixed: Color(4292011263),
      onPrimaryFixed: Color(4278194726),
      primaryFixedDim: Color(4289055225),
      onPrimaryFixedVariant: Color(4278925407),
      secondaryFixed: Color(4292011263),
      onSecondaryFixed: Color(4278194726),
      secondaryFixedDim: Color(4289972456),
      onSecondaryFixedVariant: Color(4280432465),
      tertiaryFixed: Color(4289065927),
      onTertiaryFixed: Color(4278195466),
      tertiaryFixedDim: Color(4287223724),
      onTertiaryFixedVariant: Color(4278206247),
      surfaceDim: Color(4279374614),
      surfaceBright: Color(4281874748),
      surfaceContainerLowest: Color(4279045649),
      surfaceContainerLow: Color(4279901215),
      surfaceContainer: Color(4280164387),
      surfaceContainerHigh: Color(4280822317),
      surfaceContainerHighest: Color(4281546040),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme().toColorScheme());
  }

  static MaterialScheme darkHighContrastScheme() {
    return const MaterialScheme(
      brightness: Brightness.dark,
      primary: Color(4294638335),
      surfaceTint: Color(4289055225),
      onPrimary: Color(4278190080),
      primaryContainer: Color(4289318397),
      onPrimaryContainer: Color(4278190080),
      secondary: Color(4294638335),
      onSecondary: Color(4278190080),
      secondaryContainer: Color(4290235628),
      onSecondaryContainer: Color(4278190080),
      tertiary: Color(4293853170),
      onTertiary: Color(4278190080),
      tertiaryContainer: Color(4287486896),
      onTertiaryContainer: Color(4278190080),
      error: Color(4294965752),
      onError: Color(4278190080),
      errorContainer: Color(4294949550),
      onErrorContainer: Color(4278190080),
      background: Color(4279374614),
      onBackground: Color(4293059302),
      surface: Color(4279374614),
      onSurface: Color(4294967295),
      surfaceVariant: Color(4282599246),
      onSurfaceVariant: Color(4294638335),
      outline: Color(4291283924),
      outlineVariant: Color(4291283924),
      shadow: Color(4278190080),
      scrim: Color(4278190080),
      inverseSurface: Color(4293059302),
      inverseOnSurface: Color(4278190080),
      inversePrimary: Color(4278201167),
      primaryFixed: Color(4292471039),
      onPrimaryFixed: Color(4278190080),
      primaryFixedDim: Color(4289318397),
      onPrimaryFixedVariant: Color(4278196014),
      secondaryFixed: Color(4292536575),
      onSecondaryFixed: Color(4278190080),
      secondaryFixedDim: Color(4290235628),
      onSecondaryFixedVariant: Color(4278196014),
      tertiaryFixed: Color(4289329355),
      onTertiaryFixed: Color(4278190080),
      tertiaryFixedDim: Color(4287486896),
      onTertiaryFixedVariant: Color(4278197006),
      surfaceDim: Color(4279374614),
      surfaceBright: Color(4281874748),
      surfaceContainerLowest: Color(4279045649),
      surfaceContainerLow: Color(4279901215),
      surfaceContainer: Color(4280164387),
      surfaceContainerHigh: Color(4280822317),
      surfaceContainerHighest: Color(4281546040),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme().toColorScheme());
  }

  ThemeData theme(ColorScheme colorScheme) => ThemeData(
        useMaterial3: true,
        brightness: colorScheme.brightness,
        colorScheme: colorScheme,
        textTheme: textTheme.apply(
          bodyColor: colorScheme.onSurface,
          displayColor: colorScheme.onSurface,
        ),
        scaffoldBackgroundColor: colorScheme.background,
        canvasColor: colorScheme.surface,
      );

  List<ExtendedColor> get extendedColors => [];
}

class MaterialScheme {
  const MaterialScheme({
    required this.brightness,
    required this.primary,
    required this.surfaceTint,
    required this.onPrimary,
    required this.primaryContainer,
    required this.onPrimaryContainer,
    required this.secondary,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.error,
    required this.onError,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.background,
    required this.onBackground,
    required this.surface,
    required this.onSurface,
    required this.surfaceVariant,
    required this.onSurfaceVariant,
    required this.outline,
    required this.outlineVariant,
    required this.shadow,
    required this.scrim,
    required this.inverseSurface,
    required this.inverseOnSurface,
    required this.inversePrimary,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.primaryFixedDim,
    required this.onPrimaryFixedVariant,
    required this.secondaryFixed,
    required this.onSecondaryFixed,
    required this.secondaryFixedDim,
    required this.onSecondaryFixedVariant,
    required this.tertiaryFixed,
    required this.onTertiaryFixed,
    required this.tertiaryFixedDim,
    required this.onTertiaryFixedVariant,
    required this.surfaceDim,
    required this.surfaceBright,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
  });

  final Brightness brightness;
  final Color primary;
  final Color surfaceTint;
  final Color onPrimary;
  final Color primaryContainer;
  final Color onPrimaryContainer;
  final Color secondary;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color error;
  final Color onError;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color background;
  final Color onBackground;
  final Color surface;
  final Color onSurface;
  final Color surfaceVariant;
  final Color onSurfaceVariant;
  final Color outline;
  final Color outlineVariant;
  final Color shadow;
  final Color scrim;
  final Color inverseSurface;
  final Color inverseOnSurface;
  final Color inversePrimary;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color primaryFixedDim;
  final Color onPrimaryFixedVariant;
  final Color secondaryFixed;
  final Color onSecondaryFixed;
  final Color secondaryFixedDim;
  final Color onSecondaryFixedVariant;
  final Color tertiaryFixed;
  final Color onTertiaryFixed;
  final Color tertiaryFixedDim;
  final Color onTertiaryFixedVariant;
  final Color surfaceDim;
  final Color surfaceBright;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
}

extension MaterialSchemeUtils on MaterialScheme {
  ColorScheme toColorScheme() {
    return ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: onPrimary,
      primaryContainer: primaryContainer,
      onPrimaryContainer: onPrimaryContainer,
      secondary: secondary,
      onSecondary: onSecondary,
      secondaryContainer: secondaryContainer,
      onSecondaryContainer: onSecondaryContainer,
      tertiary: tertiary,
      onTertiary: onTertiary,
      tertiaryContainer: tertiaryContainer,
      onTertiaryContainer: onTertiaryContainer,
      error: error,
      onError: onError,
      errorContainer: errorContainer,
      onErrorContainer: onErrorContainer,
      background: background,
      onBackground: onBackground,
      surface: surface,
      onSurface: onSurface,
      surfaceVariant: surfaceVariant,
      onSurfaceVariant: onSurfaceVariant,
      outline: outline,
      outlineVariant: outlineVariant,
      shadow: shadow,
      scrim: scrim,
      inverseSurface: inverseSurface,
      onInverseSurface: inverseOnSurface,
      inversePrimary: inversePrimary,
    );
  }
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
