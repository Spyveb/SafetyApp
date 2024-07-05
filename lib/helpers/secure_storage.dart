import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Service for handling storage operations.
class StorageService {
  final _secureStorage = const FlutterSecureStorage();

  // Returns AndroidOptions for secure storage.
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  // Writes data securely to storage.
  // Parameters:
  // - key: The key under which data will be stored.
  // - data: The data to be stored.
  Future<void> writeSecureData(
    String key,
    String? data,
  ) async {
    debugPrint("Writing new data having key ${key}");
    await _secureStorage.write(
      key: key,
      value: data,
      aOptions: _getAndroidOptions(),
    );
  }

  // Reads securely stored data from storage.
  // Parameters:
  // - key: The key for which data will be read.
  Future<String?> readSecureData(String key) async {
    debugPrint("Reading data having key $key");
    var readData = await _secureStorage.read(
      key: key,
      aOptions: _getAndroidOptions(),
    );
    return readData;
  }

  // Deletes all securely stored data.
  Future<void> deleteAllSecureData() async {
    debugPrint("Deleting all secured data");
    await _secureStorage.deleteAll(aOptions: _getAndroidOptions());
  }

  // Deletes securely stored data.
  Future<void> deleteSecureData(String key) async {
    debugPrint("Deleting secured data");
    await _secureStorage.delete(key: key, aOptions: _getAndroidOptions());
  }

  // Checks if a key exists in the securely stored data.
  // Parameters:
  // - key: The key to check.
  Future<bool> containsKeyInSecureData(String key) async {
    debugPrint("Checking data for the key $key");
    var containsKey = await _secureStorage.containsKey(
      key: key,
      aOptions: _getAndroidOptions(),
    );
    return containsKey;
  }

  // Checks if the app is running for the first time.
  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    bool returnValue = false;
    if (prefs.getBool('first_run') ?? true) {
      returnValue = true;
      await StorageService().deleteAllSecureData();
      await prefs.setBool('first_run', false);
    } else {
      returnValue = false;
    }
    return returnValue;
  }
}
