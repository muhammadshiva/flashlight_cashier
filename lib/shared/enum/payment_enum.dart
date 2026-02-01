enum PaymentStatus {
  initial,
  success,
  failure;

  bool get isInitial => this == PaymentStatus.initial;
  bool get isSuccess => this == PaymentStatus.success;
  bool get isFailure => this == PaymentStatus.failure;
}

enum PaymentMethodType {
  cash,
  card,
  qris;

  bool get isCash => this == PaymentMethodType.cash;
  bool get isCard => this == PaymentMethodType.card;
  bool get isQris => this == PaymentMethodType.qris;
}
