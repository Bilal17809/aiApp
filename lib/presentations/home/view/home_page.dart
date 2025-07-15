import 'package:ai_app/core/theme/app_colors.dart';
import 'package:ai_app/core/theme/app_styles.dart';
import 'package:ai_app/presentations/pages.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_app/core/common_wgt/common.dart';



class HomePage extends GetView<HomeController> {
  const HomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [

            ClipPath(
              clipper: BottomCurveClipper(),
              child: Stack(
                children: [
                  // Gradient Background
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          kLightGreen1,
                          kDarkGreen2,
                        ],
                      ),
                    ),
                  ),


                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.15,
                    right: -80,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kDarkGreen1.withOpacity(0.80),
                      ),
                    ),
                  ),

                  // Top-left Circle
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.02,
                    left: -80,
                    child: Container(
                      width: 160,
                      height: 160,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kDarkGreen1.withOpacity(0.35),
                      ),
                    ),
                  ),


                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: MediaQuery.of(context).size.height * 0.10,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'QUIZ DUEL',
                            style: headlineMediumStyle,
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'AI RIVAL',
                            style: headlineSmallStyle,
                          ),
                          const SizedBox(height: 30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/man-avatar_home_Screen.png',
                                height: MediaQuery.of(context).size.height * 0.15,
                              ),
                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [kLightGreen1, kDarkGreen2],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: const Text(
                                  'VS',
                                  style: headlineSmallStyle,
                                ),
                              ),

                              const SizedBox(width: 12),
                              Image.asset(
                                'assets/images/robot-assistant.png',
                                height: MediaQuery.of(context).size.height * 0.15,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: GridView.count(
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.1,
                  children: [
                    CategoryTile(
                      title: "General Knowledge",
                      imagePath: "assets/images/general.png",
                      color: skyColor,
                    ),
                    CategoryTile(
                      title: "Science",
                      imagePath: "assets/images/science.png",
                      color: skyColor,
                    ),
                    CategoryTile(
                      title: "History",
                      imagePath: "assets/images/history.png",
                      color: skyColor,
                    ),
                    CategoryTile(
                      title: "Word Power",
                      imagePath: "assets/images/word_power.png",
                      color: skyColor,
                    ),
        
        
                  ],
                ),
              ),
            ),
        
          ],
        ),
      ),
    );
  }


  Widget buildQuizButton(String label, {required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        child: Text(
          label,
          style: buttonTextStyle,
        ),
      ),
    );
  }
}


class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 60);
    path.quadraticBezierTo(
      size.width / 2, size.height,
      size.width, size.height - 60,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
