class AppImgConst {
  AppImgConst._();

  static AppImgConst? _instance;
  static AppImgConst get instance {
    _instance ??= AppImgConst._();
    return _instance!;
  }

  // App Icons
  static const String appIcon = 'assets/app_icons/app_icon.png';
  static const String appIconDev = 'assets/app_icons/app_icon_dev.png';
  static const String appIconStaging = 'assets/app_icons/app_icon_staging.png';

  // Images PNG
  static const String drawLogoFlashlight = 'assets/image/png/draw_logo_flashligt.png';
  static const String drawCleanMootobike = 'assets/image/png/draw_clean_motobike.png';

  static const String icChooseLanguage = 'assets/image/png/ic_choose_language.png';
  static const String icPlayButton = 'assets/image/png/ic_play_button.png';
  static const String icPlatNumber = 'assets/image/png/ic_plat_number.png';
  static const String icMotorcycle = 'assets/image/png/ic_motorcycle.png';
  static const String icMotorcycle2 = 'assets/image/png/ic_moto_cycle.png';
  static const String icPerson = 'assets/image/png/ic_person.png';
  static const String icServices = 'assets/image/png/ic_services.png';

  // Screen Design
  static const String welcomeScreen = 'assets/screen_design/welcome_screen.png';

  // Method untuk mendapatkan app icon berdasarkan flavor
  String getAppIconByFlavor(String flavor) {
    switch (flavor.toLowerCase()) {
      case 'dev':
        return appIconDev;
      case 'staging':
        return appIconStaging;
      case 'production':
      default:
        return appIcon;
    }
  }

  // Method untuk mendapatkan semua app icons
  List<String> getAllAppIcons() {
    return [appIcon, appIconDev, appIconStaging];
  }

  // Method untuk mendapatkan semua images
  List<String> getAllImages() {
    return [icChooseLanguage, drawLogoFlashlight, welcomeScreen];
  }

  // Method untuk mendapatkan semua assets
  List<String> getAllAssets() {
    return [...getAllAppIcons(), ...getAllImages()];
  }
}
