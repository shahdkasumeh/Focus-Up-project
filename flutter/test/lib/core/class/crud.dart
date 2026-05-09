import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;
import 'package:test/core/class/constant/storagehandler.dart';

class Failure {
  final String message;
  Failure(this.message);
}

class Crud {
  final StorageHandler storage = StorageHandler();

  // =========================
  // 🔧 GET TOKEN SAFE
  // =========================
  String? get _token {
    final t = storage.token;
    print("🔥 TOKEN USED => $t");
    return t;
  }

  // =========================
  // 🔧 HEADERS
  // =========================
  Map<String, String> _headers({Map<String, String>? extra}) {
    final headers = <String, String>{
      "Content-Type": "application/json",
      "Accept": "application/json",
    };

    if (_token != null && _token!.isNotEmpty) {
      headers["Authorization"] = "Bearer $_token";
    }

    if (extra != null) {
      headers.addAll(extra);
    }

    print("📌 HEADERS => $headers");
    return headers;
  }

  // =========================
  // 📤 POST
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> postData(
    String url,
    Map data, {
    Map<String, String>? headers,
  }) async {
    try {
      print("🚀 POST => $url");
      print("📦 BODY => $data");

      final response = await http.post(
        Uri.parse(url),
        headers: _headers(extra: headers),
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      print("❌ ERROR => $e");
      return Left(Failure("Unexpected error"));
    }
  }

  // =========================
  // 📥 GET
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> getData(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      print("🚀 GET => $url");

      final response = await http.get(
        Uri.parse(url),
        headers: _headers(extra: headers),
      );

      return _handleResponse(response);
    } catch (e) {
      print("❌ ERROR => $e");
      return Left(Failure("Unexpected error"));
    }
  }

  // =========================
  // ✏️ PUT
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> putData(
    String url,
    Map data, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: _headers(extra: headers),
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      print("❌ ERROR => $e");
      return Left(Failure("Unexpected error"));
    }
  }

  // =========================
  // ✅ PATCH
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> patchData(
    String url,
    Map data, {
    Map<String, String>? headers,
  }) async {
    try {
      print("🚀 PATCH => $url");
      print("📦 BODY => $data");

      final response = await http.patch(
        Uri.parse(url),
        headers: _headers(extra: headers),
        body: jsonEncode(data),
      );

      return _handleResponse(response);
    } catch (e) {
      print("❌ ERROR => $e");
      return Left(Failure("Unexpected error"));
    }
  }

  // =========================
  // 🗑 DELETE
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> deleteData(
    String url, {
    Map<String, String>? headers,
  }) async {
    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: _headers(extra: headers),
      );

      return _handleResponse(response);
    } catch (e) {
      print("❌ ERROR => $e");
      return Left(Failure("Unexpected error"));
    }
  }
  // =========================
// 🖼 UPLOAD IMAGE
// =========================
Future<Either<Failure, Map<String, dynamic>>> uploadFile(
  String url,
  String filePath, {
  String fieldName = "image",
}) async {
  try {
    print("🚀 UPLOAD => $url");
    print("📂 FILE => $filePath");

    final request = http.MultipartRequest(
      "POST",
      Uri.parse(url),
    );

    /// TOKEN
    if (_token != null && _token!.isNotEmpty) {
      request.headers["Authorization"] = "Bearer $_token";
    }

    request.headers["Accept"] = "application/json";

    /// FILE
    request.files.add(
      await http.MultipartFile.fromPath(
        fieldName,
        filePath,
      ),
    );

    final streamedResponse = await request.send();

    final response = await http.Response.fromStream(
      streamedResponse,
    );

    return _handleResponse(response);
  } catch (e) {
    print("❌ UPLOAD ERROR => $e");
    return Left(Failure("Upload failed"));
  }
}

  // =========================
  // 🧠 RESPONSE HANDLER
  // =========================
  Either<Failure, Map<String, dynamic>> _handleResponse(
    http.Response response,
  ) {
    print("📥 STATUS => ${response.statusCode}");
    print("📥 BODY => ${response.body}");

    final Map<String, dynamic> body = response.body.isNotEmpty
        ? jsonDecode(response.body)
        : {};

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return Right(body);
    }

    return Left(Failure(body['message'] ?? "Server Error"));
  }
}
