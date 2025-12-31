import 'package:dio/dio.dart';
import '../../configs/injector/injector_config.dart';
import '../network/dio_client.dart';

class NetworkDiagnostics {
  // Private constructor
  NetworkDiagnostics._();

  // Singleton instance
  static final NetworkDiagnostics instance = NetworkDiagnostics._();

  // Get Dio instance from injection
  Dio get _dio => sl<DioClient>().dio;

  /// Run all diagnostics
  Future<Map<String, dynamic>> runDiagnostics() async {
    final results = <String, dynamic>{};
    int passed = 0;
    int failed = 0;

    // 1. Check Internet/Gateway
    // We'll trust the device network connection for now,
    // or we could ping a public DNS like 8.8.8.8 if needed.
    // For this scope, we focus on API connectivity.

    // 2. Check API Health/Root
    try {
      final response = await _dio.get('/');
      results['API Root'] = {
        'success': response.statusCode == 200,
        'message': 'Status: ${response.statusCode}',
        'endpoint': '/',
      };
      if (response.statusCode == 200)
        passed++;
      else
        failed++;
    } catch (e) {
      results['API Root'] = {
        'success': false,
        'error': e.toString(),
        'endpoint': '/',
      };
      failed++;
    }

    // 3. Check Auth Endpoint (Ping or similar if available)
    // Since we don't have a specific health check endpoint listed in common docs,
    // we'll try a lightweight public endpoint if known, or just rely on root.
    // Assuming root is enough for general connectivity.

    // Summary
    results['summary'] = {
      'total': passed + failed,
      'passed': passed,
      'failed': failed,
      'passRate':
          (passed + failed) > 0 ? (passed / (passed + failed)) * 100 : 0.0,
    };

    return results;
  }

  String getReportString(Map<String, dynamic> results) {
    final buffer = StringBuffer();
    buffer.writeln('Network Diagnostics Report');
    buffer.writeln('==========================');

    final summary = results['summary'] as Map<String, dynamic>;
    buffer.writeln('Summary:');
    buffer.writeln('  Total: ${summary['total']}');
    buffer.writeln('  Passed: ${summary['passed']}');
    buffer.writeln('  Failed: ${summary['failed']}');
    buffer.writeln('  Pass Rate: ${summary['passRate']}%');
    buffer.writeln('');

    buffer.writeln('Details:');
    results.entries.forEach((entry) {
      if (entry.key == 'summary') return;

      final val = entry.value as Map<String, dynamic>;
      buffer.writeln('- ${entry.key}: ${val['success'] ? "PASS" : "FAIL"}');
      if (val['success']) {
        buffer.writeln('  Message: ${val['message']}');
      } else {
        buffer.writeln('  Error: ${val['error']}');
      }
    });

    return buffer.toString();
  }
}
