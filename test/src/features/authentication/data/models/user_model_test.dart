import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd_clean_arch/src/features/authentication/data/user_model.dart';
import 'package:tdd_clean_arch/src/features/authentication/domain/entities/user.dart';

import '../../../../../fixtures/fixture_reader.dart';

void main() {
  // arrenge
  const tModel = UserModel.empty();

  test('[UserModel] should be a subclass of [User]', () {
    // assert
    expect(tModel, isA<User>());
  });

  // arrenge
  final tJson = fixture('user.json');
  final tMap = jsonDecode(tJson);

  group('from Map', () {
    test('should return a map from json', () {
      // arrenge
      // act
      final result = UserModel.fromMap(tMap);
      expect(result, equals(tModel));
    });
  });

  group('from JSON', () {
    test('should return a [UserModel] from json data', () {
      // act
      final result = UserModel.fromJson(tJson);
      expect(result, equals(tModel));
    });
  });

  group('to Map', () {
    test('should return a [Map] from [UserModel] with the right data', () {
      // act
      final result = tModel.toMap();
      // assert
      expect(result, equals(tMap));
    });
  });

  group('to JSON', () {
    test('should return a [JSON] string from [UserModel] with the right data', () {
      // act
      final result = tModel.toJson();
      final tJson = jsonEncode({
        "id": "1",
        "name": "_empty.name",
        "avatar": "_empty.avatar",
        "createdAt": "_empty.createdAt"
      });
      // assert
      expect(result, equals(tJson));
    });
  });

  group('copywith', () {
    test('should return an updated [UserModel] with the new value(s)', () {
      // act
      final result = tModel.copyWith(name: 'test name');
      // assert
      // expect(result, const UserModel(id: '1', name: 'test name', createdAt: '_empty.createdAt', avatar: '_empty.avatar'));
      expect(result.name, equals('test name'));
    });
  });
}
