enum Flavor {
  dev,
  staging,
  production,
}

class F {
  static late final Flavor appFlavor;

  static String get name => appFlavor.name;

  static String get title {
    switch (appFlavor) {
      case Flavor.dev:
        return 'Flashlight POS Dev';
      case Flavor.staging:
        return 'Flashlight POS Staging';
      case Flavor.production:
        return 'Flashlight POS';
    }
  }

  static String get baseUrl {
    switch (appFlavor) {
      case Flavor.dev:
        return 'https://dev.example.com';
      case Flavor.staging:
        return 'https://staging.example.com';
      case Flavor.production:
        return 'https://api.example.com';
    }
  }
}
