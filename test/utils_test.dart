import 'package:flutter_test/flutter_test.dart';
import 'package:tech_task/core/utils.dart';

void main() {
  test('Validate if ingredient is Expired', () {
    bool result = isExpired(date: '2020-11-01', lunchDate: DateTime.now());

    expect(result, true);
  });
}
