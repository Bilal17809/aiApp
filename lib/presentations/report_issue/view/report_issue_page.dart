import 'package:ai_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/common_wgt/elevated_button.dart';
import '../../../core/constants/report_issues.dart';
import '../../../core/theme/app_styles.dart';

class ReportIssuePage extends StatelessWidget {
  const ReportIssuePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final issueController = TextEditingController();
    String selectedIssue = '';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: skyColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: kWhite),
          onPressed: () => Get.back(),
        ),
        title: const Text('Report an issue', style: TextStyle(color: kWhite)),
        centerTitle: true,
      ),
      backgroundColor: kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Let us know what’s wrong. We’ll look into it as soon as possible.",
                  style: descriptionTextStyle,
                ),
                const SizedBox(height: 20),

                TextFormField(
                  controller: nameController,
                  validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? "Please enter your name"
                      : null,
                  decoration: InputDecoration(
                    hintText: "Enter your name",
                    filled: true,
                    fillColor: greyBorderColor.withAlpha(40),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                StatefulBuilder(
                  builder: (context, setState) {
                    return DropdownButtonFormField<String>(
                      value: selectedIssue.isNotEmpty ? selectedIssue : null,
                      decoration: InputDecoration(
                        hintText: "Select Issue Type",
                        filled: true,
                        fillColor: greyBorderColor.withAlpha(40),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) =>
                      value == null || value.isEmpty
                          ? "Please select an issue type"
                          : null,
                      items: reportIssues
                          .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                          .toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedIssue = value!;
                        });
                      },
                    );
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: issueController,
                  maxLines: 5,
                  validator: (value) =>
                  value == null || value.trim().isEmpty
                      ? "Please describe the issue"
                      : null,
                  decoration: InputDecoration(
                    hintText: "Describe the issue",
                    filled: true,
                    fillColor: greyBorderColor.withAlpha(40),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: CommonFilledButton(
                    text: "Send Report",
                    backgroundColor: skyColor,
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        final String subject = 'User Report - $selectedIssue';

                        final String body = '''
Name: ${nameController.text}
Issue Type: $selectedIssue
Description: ${issueController.text}
''';

                        final Uri emailUri = Uri.parse(
                          'mailto:unisoftaps@gmail.com?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}',
                        );

                        try {
                          await launchUrl(emailUri);
                        } catch (e) {
                          Get.snackbar(
                            "Error",
                            "Could not open Gmail.",
                            backgroundColor: kRed.withAlpha(50),
                          );
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
