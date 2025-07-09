class ServerException implements Exception {
  final String message;
  ServerException(this.message);

  @override
  String toString() => 'ServerException: $message'; // Opsional: untuk logging yang lebih baik
}

class CacheException implements Exception {
  final String message; // Tambahkan message jika diperlukan
  CacheException(this.message);

  @override
  String toString() => 'CacheException: $message';
}

class NetworkException implements Exception { // Jarang digunakan jika sudah ada ServerException untuk masalah jaringan dari API
  final String message;
  NetworkException(this.message);

  @override
  String toString() => 'NetworkException: $message';
}