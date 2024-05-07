import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ContextExtension on BuildContext {
  double dynamicWidth(double val) => MediaQuery.of(this).size.width * val;
  double dynamicHeight(double val) => MediaQuery.of(this).size.height * val;
  double get width => MediaQuery.of(this).size.width;
}

extension TextStyleExtension on BuildContext {
  TextStyle lowTextStyle(Color color) =>
      TextStyle(color: color, fontSize: 14.sp);
  TextStyle middleTextStyle(Color color) =>
      TextStyle(color: color, fontSize: 16.sp);
  TextStyle middleTitleTextStyle(Color color) =>
      TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 20.sp);
  TextStyle largeTitleTextStyle(Color color) =>
      TextStyle(color: color, fontSize: 20.sp);
  TextStyle largeTextStyle(Color color) =>
      TextStyle(color: color, fontSize: 28.sp);
  TextStyle bigTemperatureTextStyle(Color color) =>
      TextStyle(color: color, fontSize: 100.sp, fontWeight: FontWeight.bold);
}

extension IconSizeExtension on BuildContext {
  double get lowIconSize => 20.sp;
  double get middleIconSize => 40.sp;
  double get middleIconSize2 => 50.sp;
  double get largeIconSize => 100.sp;
}

extension PaddingExtension on BuildContext {
  EdgeInsets dynamicHorizontalPadding(double val) =>
      EdgeInsets.symmetric(horizontal: dynamicWidth(val));
  EdgeInsets dynamicVerticalPadding(double val) =>
      EdgeInsets.symmetric(vertical: dynamicHeight(val));
  EdgeInsets dynamicAllPadding(double val0, double val1) =>
      EdgeInsets.symmetric(
          vertical: dynamicHeight(val0), horizontal: dynamicWidth(val1));
}

extension BorderRadiusExtension on BuildContext {
  BorderRadius get borderRadiusValue =>
      const BorderRadius.all(Radius.circular(15));
}
