import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/stock_bloc.dart';
import '../widgets/stock_header_section.dart';
import '../widgets/stock_pagination_section.dart';
import '../widgets/stock_table.dart';

class StockControlPage extends StatelessWidget {
  const StockControlPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<StockBloc>()..add(LoadStockItems()),
      child: const _StockContentView(),
    );
  }
}

class _StockContentView extends StatelessWidget {
  const _StockContentView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const StockHeaderSection(),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Divider(height: 1, color: Color(0xFFF1F5F9)),
                  Expanded(
                    child: BlocConsumer<StockBloc, StockState>(
                      listener: (context, state) {
                        if (state is StockError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.message)),
                          );
                        } else if (state is StockAdjusted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(state.message),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is StockLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (state is StockLoaded) {
                          if (state.stockItems.isEmpty) {
                            return const Center(
                              child: Text(
                                'No stock items found',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Color(0xFF64748B),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          }
                          return StockTable(stockItems: state.stockItems);
                        }
                        return const Center(child: Text('No stock items found'));
                      },
                    ),
                  ),
                  const StockPaginationSection(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
