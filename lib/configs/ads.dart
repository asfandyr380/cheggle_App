import 'dart:io';

class Ads {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8318136058462894~6297476501";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8318136058462894~6779680472";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8318136058462894/7418986484";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8318136058462894/6894681801";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get rewardedAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8318136058462894/9288625441";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8318136058462894/1642355124";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
