import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sim_check/flutter_sim_check.dart';

void main() {
  const MethodChannel channel = MethodChannel('flutter_sim_check');

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('check_sim_exist', () async {
    expect(await FlutterSimCheck.checkSimExist, '42');
  });
}
