import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';

class TermsAndConPage extends StatelessWidget {
  const TermsAndConPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: skyColor,
        iconTheme: const IconThemeData(color: kWhite),
        title: const Text(
          'Terms and Conditions',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'YOU VS AI- App Introduction',
                  style: titleLargeStyle.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: kBlue,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'This is an AI-powered quiz app where you compete with an AI opponent in four exciting categories: General Knowledge, Science, History, and Word Power.',
                style: bodyLargeStyle,
              ),
              const SizedBox(height: 16),
               Text(
                '✨ Key Features:',
                style:  titleLargeStyle.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: kBlue,
                ),
              ),
              const SizedBox(height: 8),
              _FeatureItem('AI plays against you in every quiz.'),
              _FeatureItem('Voice assistance after wrong answers.'),
              _FeatureItem('Sound feedback on both correct and incorrect answers.'),
              _FeatureItem('After 3 wrong answers, AI starts teaching the correct answer.'),
              _FeatureItem('End summary includes winner, loser, score, and percentage.'),
              _FeatureItem('Includes offline access to amazing Fun Facts.'),
              _FeatureItem('Facts cover Natural, Historical, and other categories.'),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color:yellowButtonColor.withAlpha(51),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: yellowButtonColor),
                ),
                child: Row(
                  children: const [
                    Icon(Icons.star, color: yellowButtonColor),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        'Want an Ad-Free Experience? Purchase the premium version!',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: kBlack,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'By continuing, you agree to our terms and privacy policy.',
                style: bodyMediumStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final String text;

  const _FeatureItem(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 18)),
          Expanded(child: Text(text, style: bodyLargeStyle)),
        ],
      ),
    );
  }
}
