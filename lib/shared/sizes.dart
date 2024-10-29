import 'package:flutter/cupertino.dart';

class AppSizes {
  // Day Widget
  static const double defaultDayWidgetHorizontalPadding = 1.0;
  static const double defaultDayWidgetWidth = 46.0;
  static const double defaultDayWidgetHeight = 50.0;
  static const double defaultDayWidgetOccupiedIndicatorSize = 5.0;

  // Week Widget
  static const double defaultWeekWidgetVerticalMargin = 1.0;

  // responsive sizes

  static const ResponsiveSizes responsiveSizes = ResponsiveSizes(
    defaultResponsiveHeight: 812.0,
    mobileResponsiveWidth: 375.0,
    mobileResponsiveHeight: 812.0,
    tabletResponsiveWidth: 768.0,
    tabletResponsiveHeight: 1024.0,
    desktopResponsiveWidth: 1440.0,
    desktopResponsiveHeight: 900.0,
  );
}

class ResponsiveSizes {
  final double defaultResponsiveHeight;
  final double mobileResponsiveWidth;
  final double mobileResponsiveHeight;
  final double tabletResponsiveWidth;
  final double tabletResponsiveHeight;
  final double desktopResponsiveWidth;
  final double desktopResponsiveHeight;

  bool isMobile(BuildContext ctx) {
    return MediaQuery.of(ctx).size.width < tabletResponsiveWidth;
  }

  bool isTablet(BuildContext ctx) {
    return MediaQuery.of(ctx).size.width >= tabletResponsiveWidth && MediaQuery.of(ctx).size.width < desktopResponsiveWidth;
  }

  bool isDesktop(BuildContext ctx) {
    return MediaQuery.of(ctx).size.width >= desktopResponsiveWidth;
  }

  const ResponsiveSizes({
    required this.defaultResponsiveHeight,
    required this.mobileResponsiveWidth,
    required this.mobileResponsiveHeight,
    required this.tabletResponsiveWidth,
    required this.tabletResponsiveHeight,
    required this.desktopResponsiveWidth,
    required this.desktopResponsiveHeight,
  });
}
