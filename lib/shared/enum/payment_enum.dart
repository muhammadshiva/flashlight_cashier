enum PaymentStatus {
  initial,
  submitting,
  success,
  failure;

  bool get isInitial => this == PaymentStatus.initial;
  bool get isSubmitting => this == PaymentStatus.submitting;
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
