import 'package:equatable/equatable.dart';

/// Parameters for getting store information
///
/// isPrototype: If true, return dummy data instead of calling API
class GetStoreInfoParams extends Equatable {
  final bool isPrototype;

  const GetStoreInfoParams({
    this.isPrototype = false,
  });

  @override
  List<Object?> get props => [isPrototype];
}
