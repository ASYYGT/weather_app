import 'package:flutter/material.dart';
import 'package:weaather_app/storage/context_extension.dart';

class CustomRowWidgets {
  static Row customLowTextRowWidget(
      BuildContext context, String title, String val) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            textAlign: TextAlign.left,
            style: context.lowTextStyle(Colors.white),
          ),
        ),
        Expanded(
          child: Text(
            val,
            textAlign: TextAlign.right,
            style: context.lowTextStyle(Colors.white),
          ),
        ),
      ],
    );
  }
}
