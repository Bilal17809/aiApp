import 'package:flutter/material.dart';
import '../constants/constants.dart';
import 'app_colors.dart';

const TextStyle headlineMediumStyle = TextStyle(     // use in 'QUIZ DUEL' in Home_page,use in VS text
  fontFamily: fontFamily,
  fontSize: 30,
  fontWeight: FontWeight.w700,
  color: textWhiteColor,
);
const TextStyle headlineSmallStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 24,
  fontWeight: FontWeight.w500,
  color: textWhiteColor,
);

const TextStyle titleLargeStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 22,
  fontWeight: FontWeight.w500,
  color: blackTextColor,
);

const TextStyle titleMediumStyle = TextStyle(     // use in 'AI RIVAL' in Home_page
    fontFamily: fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: textWhiteColor);

const TextStyle titleSmallStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  color: blackTextColor,
);

const TextStyle bodyLargeStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w400,
);

const TextStyle bodyMediumStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: blackTextColor,
);

const TextStyle bodySmallStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 12,
  fontWeight: FontWeight.w400,
);

const TextStyle buttonTextStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

const TextStyle labelMediumStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 14,
  fontWeight: FontWeight.w500,
  color: blackTextColor,
);
const TextStyle labelSmallStyle = TextStyle(
  fontFamily: fontFamily,
  fontSize: 12,
  fontWeight: FontWeight.w500,
  color: blackTextColor,
);
//decoration

final BoxDecoration roundedDecorationWithShadow = BoxDecoration( // use in category button decoration
  color: Colors.white,
  borderRadius: BorderRadius.circular(20),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withValues(alpha: 0.5),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ],
);
final BoxDecoration roundedDecoration = BoxDecoration(  // use for Ai message value on quiz screen
  color: Colors.white,
  borderRadius: BorderRadius.circular(10),
  boxShadow: [
    BoxShadow(
      color: Colors.grey.withValues(alpha: 0.2),
      blurRadius: 6,
      offset: Offset(0, 2),
    ),
  ],
);
final BoxDecoration roundedGreenBorderDecoration = BoxDecoration(
  color: greenColor.withValues(alpha: 0.3),
  borderRadius: BorderRadius.circular(10),
  border: Border.all(
    color: greenColor,
    width: 1.0,
  ),
);

final BoxDecoration roundedgreyBorderDecoration = BoxDecoration(
  color: bgColor,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(color: greyColor ),
);

final BoxDecoration circleWhiteBorderDecoration = BoxDecoration(
  color: skyColor,
  shape: BoxShape.circle,
  border: Border.all(color: Colors.white, width: 2),

);



final BoxDecoration rounderGreyBorderDecoration = BoxDecoration(
  color: kWhite,
  borderRadius: BorderRadius.circular(12),
  border: Border.all(
    color: greyBorderColor,
  ),
);

final BoxDecoration circleAvatarDecoration =  BoxDecoration( // use in Quiz screen for Avartar decoration
  color: skyColor,
  shape: BoxShape.circle,
  border: Border.all(color: Colors.white, width: 2),
);




final boxShadow = BoxShadow(
  color: Colors.grey.withValues(alpha: 0.2),
  blurRadius: 6,
  offset: Offset(0, 2),
);

final BoxDecoration circleWhiteShadowDecoration = BoxDecoration( //use in VS decoration in home screen
  color: skyColor,
  shape: BoxShape.circle,
  border: Border.all(
    color: Colors.white,
    width: 2,
  ),
  boxShadow: const [
    BoxShadow(
      color: Colors.black26,
      blurRadius: 12,
      offset: Offset(0, 3),
    ),
  ],
);

final BoxDecoration skyTransparentBoxDecoration = BoxDecoration(  // use in category button image container button
  color: skyColor.withAlpha(60),
  borderRadius: BorderRadius.circular(12),
);

const TextStyle questiontextStyle = TextStyle(  // use in Question Text
  fontFamily: fontFamily,
  fontSize: 20,
  fontWeight: FontWeight.w400,
  color: blackTextColor,
  height: 1.5,
);



