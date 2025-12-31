import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../config/routes/app_routes.dart';
import '../../core/utils/network_diagnostics.dart';

class DebugButton extends StatefulWidget {
  const DebugButton({super.key});

  @override
  State<DebugButton> createState() => _DebugButtonState();
}

class _DebugButtonState extends State<DebugButton> {
  Offset position = const Offset(20, 100);

  void _showDebugMenu(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Debug Menu'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.bug_report),
              title: const Text('Open Inspector'),
              onTap: () {
                Navigator.pop(context);
                context.push(AppRoutes.debug);
              },
            ),
            ListTile(
              leading: const Icon(Icons.network_check),
              title: const Text('Network Diagnostics'),
              onTap: () {
                Navigator.pop(context);
                _runNetworkDiagnostics(context);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _runNetworkDiagnostics(BuildContext context) async {
    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Running network diagnostics...'),
          ],
        ),
      ),
    );

    try {
      final results = await NetworkDiagnostics.instance.runDiagnostics();

      if (!context.mounted) return;

      // Close loading dialog
      Navigator.pop(context);

      // Show results dialog
      final summary = results['summary'] as Map<String, dynamic>;
      final passed = summary['passed'] as int;
      final failed = summary['failed'] as int;
      final total = summary['total'] as int;
      final passRate = (summary['passRate'] as num).toDouble();

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(
                failed == 0 ? Icons.check_circle : Icons.error,
                color: failed == 0 ? Colors.green : Colors.red,
              ),
              const SizedBox(width: 8),
              const Text('Diagnostics Results'),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Summary',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Text('Total Tests: $total'),
                Text(
                  'Passed: $passed',
                  style: const TextStyle(color: Colors.green),
                ),
                Text(
                  'Failed: $failed',
                  style: TextStyle(
                    color: failed > 0 ? Colors.red : Colors.grey,
                  ),
                ),
                Text('Pass Rate: ${passRate.toStringAsFixed(1)}%'),
                const Divider(height: 24),
                const Text(
                  'Details',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                ...results.entries
                    .where(
                  (e) =>
                      e.value is Map && (e.value as Map).containsKey('success'),
                )
                    .map<Widget>((e) {
                  final result = e.value as Map<String, dynamic>;
                  final success = result['success'] as bool;
                  final endpoint = result['endpoint'] ?? e.key;
                  final message = success
                      ? (result['message'] ?? 'Success')
                      : (result['error'] ?? 'Failed');

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          success ? Icons.check_circle : Icons.error,
                          size: 16,
                          color: success ? Colors.green : Colors.red,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                endpoint,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                message,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                final report = NetworkDiagnostics.instance.getReportString(
                  results,
                );
                debugPrint(report);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Report printed to console'),
                  ),
                );
              },
              child: const Text('Print Report'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      // Close loading dialog
      Navigator.pop(context);

      // Show error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Row(
            children: [
              Icon(Icons.error, color: Colors.red),
              SizedBox(width: 8),
              Text('Error'),
            ],
          ),
          content: Text('Failed to run diagnostics: $e'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position = Offset(
              position.dx + details.delta.dx,
              position.dy + details.delta.dy,
            );
          });
        },
        child: Material(
          type: MaterialType.circle,
          color: Colors.amber,
          clipBehavior: Clip.antiAlias,
          elevation: 7,
          shadowColor: Colors.black45,
          child: InkWell(
            onTap: () {
              context.push(AppRoutes.debug);
            },
            onLongPress: () {
              _showDebugMenu(context);
            },
            child: const SizedBox(
              width: 35,
              height: 35,
              child: Icon(Icons.bug_report_outlined, color: Colors.yellow),
            ),
          ),
        ),
      ),
    );
  }
}
