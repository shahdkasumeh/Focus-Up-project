import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import 'package:test/core/class/constant/storagehandler.dart';

class Failure {
  final String message;
  Failure(this.message);
}

class Crud {
  // =========================
  // 📤 POST
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> postData(
    String url,
    Map data,
  ) async {
    try {
      print("🚀 POST START: $url");
      print("📦 BODY: $data");

      final token = StorageHandler().token;

      final response = await http.post(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          if (token != null && token.isNotEmpty)
            "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      );

      print("📥 STATUS: ${response.statusCode}");
      print("📥 RESPONSE: ${response.body}");

      final Map<String, dynamic> responseBody = jsonDecode(
        response.body.isNotEmpty ? response.body : "{}",
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(responseBody);
      }

      return Left(Failure(responseBody['message'] ?? "Server Error"));
    } catch (e) {
      print("❌ ERROR: $e");
      return Left(Failure("Unexpected error"));
    }
  }

  // =========================
  // 📥 GET
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> getData(String url) async {
    try {
      print("🚀 GET START: $url");

      final token = StorageHandler().token;

      final response = await http.get(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          if (token != null && token.isNotEmpty)
            "Authorization": "Bearer $token",
        },
      );

      print("📥 STATUS: ${response.statusCode}");
      print("📥 RESPONSE: ${response.body}");

      final Map<String, dynamic> responseBody = jsonDecode(
        response.body.isNotEmpty ? response.body : "{}",
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(responseBody);
      }

      return Left(Failure(responseBody['message'] ?? "Server Error"));
    } catch (e) {
      print("❌ ERROR: $e");
      return Left(Failure("Unexpected error"));
    }
  }

  // =========================
  // ✏️ PUT
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> putData(
    String url,
    Map data,
  ) async {
    try {
      final token = StorageHandler().token;

      final response = await http.put(
        Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          if (token != null && token.isNotEmpty)
            "Authorization": "Bearer $token",
        },
        body: jsonEncode(data),
      );

      final Map<String, dynamic> responseBody = jsonDecode(
        response.body.isNotEmpty ? response.body : "{}",
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(responseBody);
      }

      return Left(Failure(responseBody['message'] ?? "Server Error"));
    } catch (e) {
      return Left(Failure("Unexpected error"));
    }
  }

  // =========================
  // 🗑 DELETE
  // =========================
  Future<Either<Failure, Map<String, dynamic>>> deleteData(String url) async {
    try {
      final token = StorageHandler().token;

      final response = await http.delete(
        Uri.parse(url),
        headers: {
          "Accept": "application/json",
          if (token != null && token.isNotEmpty)
            "Authorization": "Bearer $token",
        },
      );

      final Map<String, dynamic> responseBody = jsonDecode(
        response.body.isNotEmpty ? response.body : "{}",
      );

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(responseBody);
      }
      return Left(Failure(responseBody['message'] ?? "Server Error"));
    } catch (e) {
      return Left(Failure("Unexpected error"));
    }
  }
}
