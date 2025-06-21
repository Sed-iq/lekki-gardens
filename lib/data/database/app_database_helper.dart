import 'dart:async';

import 'package:get_storage/get_storage.dart';

import 'database_helper.dart';

class AppDatabaseHelper implements DatabaseHelper {

  final GetStorage getStorage;

  AppDatabaseHelper(this.getStorage);

  @override
  Future<void> saveApiNetworkCache(String key, String? value) {
    return getStorage.write(key, value);
  }

  @override
  Stream<String?> getApiNetworkCache(String key) {
    StreamController<String?> streamController = StreamController<String?>();
    streamController.add(getStorage.read(key));
    getStorage.listenKey(key, (value) {
      streamController.add(value);
    });
    return streamController.stream;
  }

  @override
  Future<void> deleteApiNetworkCache(String key) {
    return getStorage.remove(key);
  }

  @override
  Stream<bool> isApiNetworkCacheExists(String key) {
    return Stream.value(getStorage.hasData(key));
  }

  @override
  Future<void> clearApiNetworkCache() {
    return getStorage.erase();
  }

}