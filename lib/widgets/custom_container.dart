import 'package:flutter/material.dart';
import 'package:weaather_app/storage/context_extension.dart';

Container customContainer(
    BuildContext context, Color color, Color color1, Widget widget,
    [double? height, double? width]) {
  return Container(
    padding: context.dynamicAllPadding(0.01, 0.02),
    margin: context.dynamicAllPadding(0.01, 0.02),
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: context.borderRadiusValue,
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withOpacity(0.5), color1.withOpacity(0.5)]),
    ),
    child: widget,
  );
}
