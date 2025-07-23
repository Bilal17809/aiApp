import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_theme.dart';

class NoInternetDialog extends StatelessWidget {
  final VoidCallback onRetry;

  const NoInternetDialog({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kWhite,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      titlePadding: const EdgeInsets.only(top: 16),
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      title: Column(
        children: [
          Image.asset(
            'assets/images/no-internet.png',
            height: 100,
            width: 100,
            fit: BoxFit.contain,

          ),
          const SizedBox(height: 12),
          Text(
            "No Internet",
            style: titleLargeStyle.copyWith(
              color: kBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Text(
        "Please connect to the internet to continue.",
        style: bodyMediumStyle.copyWith(
          color: textGreyColor,
        ),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: onRetry,
          style: AppTheme.elevatedButtonStyle,
          child: const Text("Retry"),
        ),
      ],
    );
  }
}
