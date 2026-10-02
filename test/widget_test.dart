// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:higo/utils/validators.dart';

void main() {
  group('Form Validators', () {
    test('Email validation works correctly', () {
      // Valid emails
      expect(Validators.validateEmail('test@example.com'), isNull);
      expect(Validators.validateEmail('user.name@domain.co.uk'), isNull);

      // Invalid emails
      expect(Validators.validateEmail(''), isNotNull);
      expect(Validators.validateEmail('invalid'), isNotNull);
      expect(Validators.validateEmail('test@'), isNotNull);
      expect(Validators.validateEmail('@example.com'), isNotNull);
    });

    test('Password validation works correctly', () {
      // Valid passwords
      expect(Validators.validatePassword('123456'), isNull);
      expect(Validators.validatePassword('longpassword123'), isNull);

      // Invalid passwords
      expect(Validators.validatePassword(''), isNotNull);
      expect(Validators.validatePassword('12345'), isNotNull); // too short
    });

    test('Display name validation works correctly', () {
      // Valid names
      expect(Validators.validateDisplayName('John'), isNull);
      expect(Validators.validateDisplayName('محمد'), isNull);

      // Invalid names
      expect(Validators.validateDisplayName(''), isNotNull);
      expect(Validators.validateDisplayName('A'), isNotNull); // too short
    });

    test('Password confirmation validation works correctly', () {
      const password = 'password123';

      // Valid confirmation
      expect(Validators.validateConfirmPassword(password, password), isNull);

      // Invalid confirmations
      expect(Validators.validateConfirmPassword('', password), isNotNull);
      expect(
        Validators.validateConfirmPassword('different', password),
        isNotNull,
      );
    });
  });
}
