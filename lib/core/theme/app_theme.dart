import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_styles.dart';

abstract class AppTheme {
  static const fontFamily = 'Montserrat';

  // BUTTON STYLES use for no inter net
  static final ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: skyColor,
    textStyle: buttonTextStyle,
    foregroundColor: Colors.white,
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
    minimumSize: const Size(double.maxFinite, 50),
    shadowColor: Colors.grey.withValues(alpha: 0.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );



  static const UnderlineInputBorder greyUnderLineBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: greyBorderColor),
  );

  static final ButtonStyle splashButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: yellowButtonColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
  );
}
