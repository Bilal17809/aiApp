import 'package:ai_app/presentations/pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ai_app/core/common_wgt/CategoryTILE/categorytile.dart';
import '../../../core/common_wgt/clippers/bottom_curve_clipper.dart';
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
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF65DF94),
                      Color(0xFF02A6A5),
                    ],
                  ),
                ),
                child: Stack(
                  children: [

                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.02,
                      left: -100,
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF65DF94),
                                Color(0xFF00ADA3),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha((0.2 * 255).round()),


                                blurRadius: 12,
                                spreadRadius: 4,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),




                    Positioned(
                      top: MediaQuery.of(context).size.height * 0.15,
                      right: -90,
                      child: Opacity(
                        opacity: 0.2,
                        child: Container(
                          width: 160,
                          height: 160,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color(0xFF65DF94),
                                Color(0xFF00ADA3),
                              ],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha((0.2 * 255).round()),
                                blurRadius: 12,
                                spreadRadius: 4,
                                offset: Offset(0, 6),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(80.0),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'QUIZ DUEL',
                              style: TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'AI RIVAL',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.white70,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 40),

                          ],
                        ),
                      ),
                    ),

                    Positioned(
                      top: (MediaQuery.of(context).size.height * 0.5) - 200,

                      left: 0,
                      right: 0,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          double totalWidth = constraints.maxWidth;
                          double avatarWidth = totalWidth * 0.35;
                          double vsSize = totalWidth * 0.20;

                          return Row(

                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Left Avatar
                              ClipOval(
                                child: Container(
                                  width: avatarWidth,
                                  height: avatarWidth,
                                  color: Colors.white.withAlpha((0.2 * 255).round()),
                                  child: Image.asset(
                                    'assets/images/man-avatar_home_Screen.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              SizedBox(width: totalWidth * 0.02),

                              // VS Circle
                              Container(
                                width: vsSize,
                                height: vsSize,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [Color(0xFF65DF94), Color(0xFF00ADA3)],
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.black26,
                                      blurRadius: 6,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'VS',
                                  style: TextStyle(
                                    fontSize: vsSize * 0.35,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),

                              SizedBox(width: totalWidth * 0.02),

                              // Right Avatar
                              ClipOval(
                                child: Container(
                                  width: avatarWidth,
                                  height: avatarWidth,
                                  color: Colors.white.withAlpha((0.2 * 255).round()),
                                  child: Image.asset(
                                    'assets/images/robot-assistant.png',
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),


                  ],
                ),
              ),
            ),

            // Expanded GridView section (unchanged)
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
                    ),
                    CategoryTile(
                      title: "Science",
                      imagePath: "assets/images/science.png",
                    ),
                    CategoryTile(
                      title: "History",
                      imagePath: "assets/images/history.png",
                    ),
                    CategoryTile(
                      title: "Word Power",
                      imagePath: "assets/images/word_power.png",
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
}

