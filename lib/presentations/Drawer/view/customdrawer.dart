import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_styles.dart';


class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
              padding: EdgeInsets.zero,
              decoration: const BoxDecoration(color: skyColor),
              child: Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/person_robot.png',
                      width: 55,
                      height: 55,
                      fit: BoxFit.contain,
                    ),

                    const SizedBox(height: 8),
                    Text(
                      "QUIZ DUEL",
                      style: headlineMediumStyle.copyWith(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),

            ListTile(
              leading: const Icon(Icons.apps),
              title: const Text('More Apps'),
            ),
            ListTile(
              leading: const Icon(Icons.star_rate),
              title: const Text('Rate Us'),
            ),
            ListTile(
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
            ),
          ],
        ),
      ),
    );
  }
}
