import 'package:equatable/equatable.dart';

class ReportsState extends Equatable {
  const ReportsState();
  @override
  List<Object> get props => [];
}

class ReportsInitial extends ReportsState {}

class ReportsLoading extends ReportsState {}

class ReportsError extends ReportsState {
  final String message;
  const ReportsError(this.message);
  @override
  List<Object> get props => [message];
}

class ReportsLoaded extends ReportsState {
  final Map<DateTime, int> dailyRevenue;
  final Map<String, int> serviceRevenue;
  final int totalCarsProcessed;

  const ReportsLoaded({
    required this.dailyRevenue,
    required this.serviceRevenue,
    required this.totalCarsProcessed,
  });

  @override
  List<Object> get props => [dailyRevenue, serviceRevenue, totalCarsProcessed];
}
