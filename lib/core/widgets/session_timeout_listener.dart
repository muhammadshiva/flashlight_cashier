import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

class SessionTimeoutListener extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const SessionTimeoutListener({
    super.key,
    required this.child,
    this.duration = const Duration(minutes: 15),
  });

  @override
  State<SessionTimeoutListener> createState() => _SessionTimeoutListenerState();
}

class _SessionTimeoutListenerState extends State<SessionTimeoutListener> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer(widget.duration, _onTimeout);
  }

  void _onTimeout() {
    // Only logout if currently authenticated
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthSuccess) {
      context.read<AuthBloc>().add(LogoutRequested());
      context.go('/login');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session timed out due to inactivity.')),
      );
    }
  }

  void _resetTimer() {
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) => _resetTimer(),
      onPointerMove: (_) => _resetTimer(), // Maybe too frequent?
      onPointerUp: (_) => _resetTimer(),
      // Keyboard?
      child: widget.child,
    );
  }
}
