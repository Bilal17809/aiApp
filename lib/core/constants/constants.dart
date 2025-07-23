import 'package:flutter/cupertino.dart';

const fontFamily='Montserrat';
const double bodyHp=16.0;
double mobileHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double mobileWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}
const EdgeInsets verticalButtonPadding = EdgeInsets.symmetric(vertical: 16);

const Map<String, List<String>> hints = {
  "science": [
    'biology', 'chemistry', 'physics', 'space', 'genetics',
    'human body', 'plants', 'astronomy', 'energy', 'earth science'
  ],
  "history": [
    'world wars', 'ancient civilizations', 'historical events', 'leaders',
    'independence movements', 'revolutions', 'medieval history',
    'colonialism', 'empires', 'modern politics'
  ],
  "word": [
    'synonyms',  'word formation', 'idioms', 'vocabulary', 'proverbs',
    'fill in the blanks', 'sentence correction','antonyms', 'phrases',
    'confusing words'
  ],
  "general": [
    'geography', 'current affairs', 'inventions', 'sports', 'books',
    'famous personalities', 'technology', 'records', 'abbreviations', 'economics'
  ],
};