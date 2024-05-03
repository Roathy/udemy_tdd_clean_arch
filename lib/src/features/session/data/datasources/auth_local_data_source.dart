import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../core/errors/exception.dart';
import '../../../../../core/services/shared_preferences_service.dart';
import '../models/api_response_model.dart';

abstract class AuthLocalDataSource {
  Future<bool> getLastSuccess();
  Future<String> getLastMessage();
  Future<String> getLastToken();
  Future<ApiResponseModel> getLastResponse();

  Future<bool> cacheApiResponse(
    bool success,
    String message,
    String token,
  );
  Future<bool> cacheData({
    required key,
    required value,
  });
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  // AuthLocalDataSourceImpl({required this.preferences});
  // final SharedPreferences preferences ;
  AuthLocalDataSourceImpl(this.sharedPreferencesService);

  final SharedPreferencesService sharedPreferencesService;

  @override
  Future<bool> getLastSuccess() {
    final jsonString = sharedPreferencesService.getData('CACHED_SUCCESS');
    if (jsonString != null) {
      return Future.value(jsonString);
    } else {
      throw const CacheException(message: 'Failed to read local data: success', statusCode: 500);
    }
  }

  @override
  Future<String> getLastMessage() {
    final jsonString = sharedPreferencesService.getData('CACHED_MESSAGE');
    if (jsonString != null) {
      return Future.value(jsonString);
    } else {
      throw const CacheException(message: 'Failed to read local data: message', statusCode: 500);
    }
  }

  @override
  Future<String> getLastToken() {
    final jsonString = sharedPreferencesService.getData('CACHED_TOKEN');
    if (jsonString != null) {
      return Future.value(jsonString);
    } else {
      throw const CacheException(message: 'Failed to read local data: token', statusCode: 500);
    }
  }

  @override
  Future<ApiResponseModel> getLastResponse() async {
    return ApiResponseModel(
      success: sharedPreferencesService.getData('CACHED_SUCCESS'),
      message: sharedPreferencesService.getData('CACHED_MESSAGE'),
      data: {
        'token': sharedPreferencesService.getData('CACHED_DATA')
      },
    );
  }

  @override
  Future<bool> cacheApiResponse(bool success, String message, String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.clear();
    try {
      // Save each piece of data separately and await each operation
      await sharedPreferencesService.saveData('CACHED_SUCCESS', success);
      await sharedPreferencesService.saveData('CACHED_MESSAGE', message);
      await sharedPreferencesService.saveData('CACHED_TOKEN', token);

      // If all saveData operations succeed, return true
      return true;
    } catch (e) {
      // Handle any errors during data saving and return false
      return false;
    }
  }

  @override
  Future<bool> cacheData({required key, required value}) async {
    return sharedPreferencesService.saveData(key, value);
  }
}
