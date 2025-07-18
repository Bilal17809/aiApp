import 'package:flutter/material.dart';
import '../../core/theme/app_styles.dart';
import '../../core/theme/app_colors.dart';
import '../../core/constants/constants.dart'; // Assuming you place borderRadius etc. here

class CommonFilledButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const CommonFilledButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = buttonBlueColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: defaultButtonBorderRadius,
          ),
          elevation: 3,
          backgroundColor: Colors.transparent,
          shadowColor: whiteShadowColor,
        ),
        child: Ink(
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: defaultButtonBorderRadius,
          ),
          child: Container(
            padding: verticalButtonPadding,
            alignment: Alignment.center,
            child: Text(
              text,
              style: bodyLargeStyle.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
