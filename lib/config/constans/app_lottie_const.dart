class AppLottieConst {
  AppLottieConst._();

  static AppLottieConst? _instance;
  static AppLottieConst get instance {
    _instance ??= AppLottieConst._();
    return _instance!;
  }

  static const String lottieLoading = "assets/json/loading.json";
  static const String lottieInfo = "assets/json/lottieInfo.json";
  static const String lottieSuccess = "assets/json/lottieSuccess.json";
  static const String lottieTanya = "assets/json/lottieTanya.json";
  static const String lottieDelete = "assets/json/delete.json";
  static const String lottieSwitch = "assets/json/toggle_switch.json";
  static const String lottieArrow = "assets/json/lottie_arrow.json";
}
