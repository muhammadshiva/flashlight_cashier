class AppLottieConst {
  AppLottieConst._();

  static AppLottieConst? _instance;
  static AppLottieConst get instance {
    _instance ??= AppLottieConst._();
    return _instance!;
  }

  static const String loading = "assets/json/loading.json";
  static const String info = "assets/json/lottieInfo.json";
  static const String success = "assets/json/lottieSuccess.json";
  static const String tanya = "assets/json/lottieTanya.json";
  static const String delete = "assets/json/delete.json";
  static const String toggleSwitch = "assets/json/toggle_switch.json";
  static const String arrow = "assets/json/lottie_arrow.json";
  static const String noInternet = "assets/json/anim_not_found.json";
}
