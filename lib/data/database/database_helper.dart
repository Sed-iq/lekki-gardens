abstract class DatabaseHelper {

  Future<void> saveApiNetworkCache(String key, String? value);

  Stream<String?> getApiNetworkCache(String key);

  Future<void> deleteApiNetworkCache(String key);

  Stream<bool> isApiNetworkCacheExists(String key);

  Future<void> clearApiNetworkCache();

}