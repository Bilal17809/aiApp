import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';
import '../../../core/theme/app_theme.dart';

class NoInternetDialog extends StatelessWidget {
  final VoidCallback onRetry;
  final String title;
  final String message;
  final String button_text;

  final String? secondaryButtonText;
  final VoidCallback? onSecondary;

  const NoInternetDialog({
    super.key,
    required this.onRetry,
    this.message = "Please connect to the internet to continue.",
    this.title = 'No Internet',
    this.button_text = 'Retry',
    this.secondaryButtonText,
    this.onSecondary,
  });

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
            title,
            style: titleLargeStyle.copyWith(
              color: kBlack,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      content: Text(
        message,
        style: bodyMediumStyle.copyWith(color: textGreyColor),
        textAlign: TextAlign.center,
      ),
      actions: [
        if (secondaryButtonText != null && onSecondary != null)
          Row(
            children: [
              // Retry button
              Expanded(
                child: ElevatedButton(
                  onPressed: onRetry,
                  style: AppTheme.elevatedButtonStyle,
                  child: Text(button_text),
                ),
              ),
              const SizedBox(width: 12),
              // Exit button in colored container
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: skyColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton(
                    onPressed: onSecondary,
                    child: Text(
                      secondaryButtonText!,
                      style: titleSmallStyle.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        else
          Center(
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onRetry,
                style: AppTheme.elevatedButtonStyle,
                child: Text(button_text),
              ),
            ),
          ),
      ],
    );
  }
}
