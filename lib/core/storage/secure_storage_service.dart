import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vision_erp_app/core/storage/storage_service.dart';

class SecureStorageService implements StorageService {
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  @override
  Future<void> write({required String key, required String value}) {
    return _secureStorage.write(key: key, value: value);
  }

  @override
  Future<String?> read({required String key}) {
    return _secureStorage.read(key: key);
  }

  @override
  Future<void> delete({required String key}) {
    return _secureStorage.delete(key: key);
  }
}
