import 'package:flashlight_pos/config/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: Color(0xFFF8FAFC),
      ),
      child: Row(
        children: [
          // Branding
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.blackFoundation600,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.circle, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          const Text(
            'Flashlight',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E293B),
            ),
          ),

          const Spacer(),

          // Right Actions
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined,
                color: Color(0xFF64748B)),
          ),
          const SizedBox(width: 16),

          // User Profile
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              String userName = 'Alexander';
              String userRole = 'Admin';

              if (state is AuthSuccess) {
                userName = state.auth.user.name;
                // Assuming role is available or hardcoded for now
              }

              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 16,
                      backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?u=a042581f4e29026024d'),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userName,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF1E293B),
                          ),
                        ),
                        Text(
                          userRole,
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF64748B),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.keyboard_arrow_down,
                        size: 16, color: Color(0xFF64748B)),
                    const SizedBox(width: 4),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
