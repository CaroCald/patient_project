abstract class StorageService {
  Future<void> write(String key, String value);
  Future<String?> read(String key);
  Future<void> delete(String key);
  Future<void> deleteAll();
}

abstract class StorageKeys {
  static const String authToken = 'auth_token';
}
