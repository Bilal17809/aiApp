import 'dart:io';
import 'package:ai_app/presentations/premium_screen/premium_screen.dart';
import 'package:ai_app/presentations/remove_ads_contrl/remove_ads_contrl.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/routes/app_routes.dart';
import '../../report_issue/view/report_issue_page.dart';
import '/core/theme/app_colors.dart';
import '/core/theme/app_styles.dart';
import '../drawer_controller/drawer_controller.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final RemoveAds removeAds =Get.put(RemoveAds());
    final DrawerContlr drawerController=Get.put(DrawerContlr());
    return Drawer(
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
                    'assets/images/logo.png',
                    width: 80,
                    height: 80,
                    fit: BoxFit.contain,
                  ),

                  const SizedBox(height: 8),
                  Text(
                    "YOU VS AI",
                    style: headlineMediumStyle.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.star_rate,color: Colors.blue,),
            title: const Text('Rate Us'),
            onTap:(){
              drawerController.rateUs();
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip,color: Colors.blue,),
            title: const Text('Privacy Policy'),
            onTap:(){
              drawerController.privacy();
            },
          ),
          ListTile(
            leading: const Icon(Icons.apps,color: Colors.blue,),
            title: const Text('More Apps'),
            onTap:()=>drawerController.moreApp()
          ),
          if(Platform.isIOS)
          ListTile(
              leading: Image.asset('assets/trial/sub1.png',height: 32,width: 32,color: Colors.blue,),
              title:  Text( removeAds.isSubscribedGet.value?'Ads Free Version!':'Remove Ads'),
              onTap:(){
                Get.to(PremiumScreen());
              }
          ),
          if(Platform.isAndroid)
          ListTile(
              leading: const Icon(Icons.report,color: Colors.blue,),
              title: const Text('Report an Issue'),
              onTap:(){
                Get.to(ReportIssuePage());

              }
          ),
        ],
      ),
    );
  }
}
