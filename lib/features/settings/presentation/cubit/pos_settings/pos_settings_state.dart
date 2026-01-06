part of 'pos_settings_cubit.dart';

/// State for POS Settings Form
class POSSettingsState extends Equatable {
  final double taxRate;
  final bool autoCalculateTax;
  final bool autoPrintReceipt;
  final String currencyCode;
  final int decimalPlaces;
  final bool isDirty; // Track if form has unsaved changes
  final bool isSaving; // Track if save is in progress

  const POSSettingsState({
    required this.taxRate,
    required this.autoCalculateTax,
    required this.autoPrintReceipt,
    required this.currencyCode,
    required this.decimalPlaces,
    this.isDirty = false,
    this.isSaving = false,
  });

  factory POSSettingsState.initial() {
    return const POSSettingsState(
      taxRate: 11.0,
      autoCalculateTax: true,
      autoPrintReceipt: true,
      currencyCode: 'IDR',
      decimalPlaces: 2,
      isDirty: false,
      isSaving: false,
    );
  }

  POSSettingsState copyWith({
    double? taxRate,
    bool? autoCalculateTax,
    bool? autoPrintReceipt,
    String? currencyCode,
    int? decimalPlaces,
    bool? isDirty,
    bool? isSaving,
  }) {
    return POSSettingsState(
      taxRate: taxRate ?? this.taxRate,
      autoCalculateTax: autoCalculateTax ?? this.autoCalculateTax,
      autoPrintReceipt: autoPrintReceipt ?? this.autoPrintReceipt,
      currencyCode: currencyCode ?? this.currencyCode,
      decimalPlaces: decimalPlaces ?? this.decimalPlaces,
      isDirty: isDirty ?? this.isDirty,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [taxRate, autoCalculateTax, autoPrintReceipt, currencyCode, decimalPlaces, isDirty, isSaving];
}
