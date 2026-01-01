/// Domain Entity for Application Settings
/// Contains: Store Information, POS Settings, Language & Region, Display Settings
class AppSettings {
  // Store Information
  final String storeName;
  final String storeAddress;
  final String storePhone;
  final String storeEmail;

  // POS Settings
  final double taxRate;
  final bool autoCalculateTax;

  // Language & Region
  final String language;
  final String region;
  final String currencySymbol;

  // Display Settings
  final String theme;
  final double fontSize;

  const AppSettings({
    required this.storeName,
    required this.storeAddress,
    required this.storePhone,
    required this.storeEmail,
    required this.taxRate,
    required this.autoCalculateTax,
    required this.language,
    required this.region,
    required this.currencySymbol,
    required this.theme,
    required this.fontSize,
  });

  factory AppSettings.initial() {
    return const AppSettings(
      storeName: 'Mocca POS',
      storeAddress: 'Jl. Merdeka No. 123, Jakarta',
      storePhone: '+62 21 1234 5678',
      storeEmail: 'info@moccapos.com',
      taxRate: 11.0,
      autoCalculateTax: true,
      language: 'id_ID',
      region: 'Indonesia',
      currencySymbol: 'Rp',
      theme: 'light',
      fontSize: 14.0,
    );
  }

  AppSettings copyWith({
    String? storeName,
    String? storeAddress,
    String? storePhone,
    String? storeEmail,
    double? taxRate,
    bool? autoCalculateTax,
    String? language,
    String? region,
    String? currencySymbol,
    String? theme,
    double? fontSize,
  }) {
    return AppSettings(
      storeName: storeName ?? this.storeName,
      storeAddress: storeAddress ?? this.storeAddress,
      storePhone: storePhone ?? this.storePhone,
      storeEmail: storeEmail ?? this.storeEmail,
      taxRate: taxRate ?? this.taxRate,
      autoCalculateTax: autoCalculateTax ?? this.autoCalculateTax,
      language: language ?? this.language,
      region: region ?? this.region,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      theme: theme ?? this.theme,
      fontSize: fontSize ?? this.fontSize,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AppSettings &&
        other.storeName == storeName &&
        other.storeAddress == storeAddress &&
        other.storePhone == storePhone &&
        other.storeEmail == storeEmail &&
        other.taxRate == taxRate &&
        other.autoCalculateTax == autoCalculateTax &&
        other.language == language &&
        other.region == region &&
        other.currencySymbol == currencySymbol &&
        other.theme == theme &&
        other.fontSize == fontSize;
  }

  @override
  int get hashCode {
    return Object.hash(
      storeName,
      storeAddress,
      storePhone,
      storeEmail,
      taxRate,
      autoCalculateTax,
      language,
      region,
      currencySymbol,
      theme,
      fontSize,
    );
  }
}
