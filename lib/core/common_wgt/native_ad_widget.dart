import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../presentations/Ads/native/controller/native_ad_controller.dart';


class NativeAdWidget extends StatelessWidget {
  final NativeAdSizeType sizeType;
  final double? customHeight;

  const NativeAdWidget({
    super.key,
    this.sizeType = NativeAdSizeType.medium,
    this.customHeight,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      NativeAdController(sizeType: sizeType, customHeight: customHeight),
      tag: UniqueKey().toString(), // avoid conflict in multiple instances
    );

    return Obx(() {
      if (!controller.isLoaded.value) {
        return const SizedBox(
          height: 50,
          child: Center(child: CircularProgressIndicator()),
        );
      }

      return Container(
        alignment: Alignment.center,
        width: controller.bannerAd.size.width.toDouble(),
        height: controller.bannerAd.size.height.toDouble(),
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: AdWidget(ad: controller.bannerAd),
      );
    });
  }
}
