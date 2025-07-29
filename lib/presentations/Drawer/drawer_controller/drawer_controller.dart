import 'dart:io';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';


class DrawerContlr extends GetxController{

   Future<void> privacy() async {
    const androidUrl = 'https://modernmobileschool.blogspot.com/2017/07/modern-school-privacy-policy.html';
    const iosUrl = 'https://asadarmantech.blogspot.com/2019/11/asad-arman-tech-privacy-policy-for-apps.html';

    final url = Platform.isIOS ? iosUrl : androidUrl;

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

   Future<void> rateUs() async {
    const androidUrl =
        'https://play.google.com/store/apps/details?id=com.modernschool.youvsaiquiz';
    const iosUrl =
        'https://apps.apple.com/us/app/You Vs AI/6749058448';

    final url = Platform.isIOS ? iosUrl : androidUrl;

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

   Future<void> moreApp() async {
    const androidUrl =
        'https://play.google.com/store/apps/developer?id=Modern+School';
    const iosUrl =
        'https://apps.apple.com/us/developer/muhammad-asad-arman/id1487950157';

    final url = Platform.isIOS ? iosUrl : androidUrl;

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }
}