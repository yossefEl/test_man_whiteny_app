import 'package:analyse_donnees_app/enums/devices_enums.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

class ConfigSize {
  static MediaQueryData _mediaQueryData;
  static double textScaleFactor;
  static double screenWidth;
  static double screenHeight;
  static double insidMargin;
  static double outsidePadding;
  static double cardPadding;
  static double iconSize;
  static double miniIconSize;
  static double minPicSize;
  static double maxPicSize;
  static double imageScale;
  static double calendarHeight;
  static double textMargin;
  static bool isDesktop;
  static BuildContext context;
  static init(BuildContext ctx) {
    context=context;
    _mediaQueryData = MediaQuery.of(ctx);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    if (screenWidth > screenHeight || _mediaQueryData.orientation.index == 1) {
      isDesktop = true;
    } else {
      isDesktop = false;
    }

    double scaleFactor = screenHeight < 540
        ? 0.7
        : screenWidth > 1000
            ? 1.75
            : screenWidth > 800 ? 1.5 : screenWidth > 400 ? 1 : 0.8;

    imageScale = screenWidth > 400 ? 1.2 : 1.6;

    print('-----> ' +
        textScaleFactor.toString() +
        "  " +
        '$scaleFactor' +
        "  $screenWidth");
    calendarHeight = screenWidth > 1000 ? 255 : screenWidth > 400 ? 163 : 147;

    textScaleFactor = scaleFactor;

    insidMargin = 25.0 * scaleFactor;

    outsidePadding = 13.0 * scaleFactor;

    cardPadding = 09.0 * scaleFactor;

    iconSize = 33.0 * scaleFactor;

    miniIconSize = 24.0 * scaleFactor;

    minPicSize = 75.0 * scaleFactor;

    maxPicSize = 100 * scaleFactor;

    textMargin = 5.0 * scaleFactor;
  }
}
