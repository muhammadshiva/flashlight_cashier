class AppSvgConst {
  AppSvgConst._();

  static AppSvgConst? _instance;
  static AppSvgConst get instance {
    _instance ??= AppSvgConst._();
    return _instance!;
  }

  // Social Media Icons
  static const String icWhatsapp = 'assets/image/svg/ic_whatsapp.svg';
  static const String icTiktok = 'assets/image/svg/ic_tiktok.svg';
  static const String icInstagram = 'assets/image/svg/ic_instagram.svg';
  static const String icStar = 'assets/image/svg/ic_start.svg';

  // UI Icons
  static const String icPlayButton = 'assets/image/svg/ic_play_button.svg';

  // Method untuk mendapatkan semua social media icons
  List<String> getAllSocialMediaIcons() {
    return [icWhatsapp, icTiktok, icInstagram];
  }

  // Method untuk mendapatkan semua UI icons
  List<String> getAllUiIcons() {
    return [icPlayButton];
  }

  // Method untuk mendapatkan semua SVG assets
  List<String> getAllAssets() {
    return [...getAllSocialMediaIcons(), ...getAllUiIcons()];
  }

  // Method untuk mencari icon berdasarkan nama
  String? getIconByName(String iconName) {
    final allAssets = getAllAssets();
    final found = allAssets.where((asset) => asset.toLowerCase().contains(iconName.toLowerCase())).toList();
    return found.isNotEmpty ? found.first : null;
  }
}
