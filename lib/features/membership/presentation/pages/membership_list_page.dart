import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../injection_container.dart';
import '../bloc/membership_bloc.dart';

class MembershipListPage extends StatelessWidget {
  const MembershipListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MembershipBloc>()..add(LoadMemberships()),
      child: const MembershipListView(),
    );
  }
}

class MembershipListView extends StatelessWidget {
  const MembershipListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memberships'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => context.push('/memberships/new'),
          ),
        ],
      ),
      body: BlocConsumer<MembershipBloc, MembershipState>(
        listener: (context, state) {
          if (state is MembershipError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is MembershipLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MembershipLoaded) {
            return ListView.builder(
              itemCount: state.memberships.length,
              itemBuilder: (context, index) {
                final membership = state.memberships[index];
                return ListTile(
                  title: Text(membership.membershipType),
                  subtitle: Text(membership.customerId),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      context
                          .read<MembershipBloc>()
                          .add(DeleteMembershipEvent(membership.id));
                    },
                  ),
                );
              },
            );
          }
          return const Center(child: Text('No memberships found'));
        },
      ),
    );
  }
}
