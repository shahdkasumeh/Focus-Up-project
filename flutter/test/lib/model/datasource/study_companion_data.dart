import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class StudyCompanionData {
  final Crud crud;

  StudyCompanionData(this.crud);
  Future<Either<Failure, Map<String, dynamic>>> getPosts() async {
    return await crud.getData(AppLink.posts);
  }

  Future<Either<Failure, Map<String, dynamic>>> getSinglePost(
    int postId,
  ) async {
    return await crud.getData("${AppLink.posts}/$postId");
  }

  Future<Either<Failure, Map<String, dynamic>>> createPost({
    required String title,
    required String content,
  }) async {
    return await crud.postData(AppLink.posts, {
      "title": title,
      "content": content,
    });
  }

  Future<Either<Failure, Map<String, dynamic>>> addComment({
    required int postId,
    required String content,
  }) async {
    return await crud.postData("${AppLink.posts}/$postId/comments", {
      "content": content,
    });
  }

  Future<Either<Failure, Map<String, dynamic>>> updatePost({
    required int postId,
    required String title,
    required String content,
  }) async {
    return await crud.putData("${AppLink.posts}/$postId", {
      "title": title,
      "content": content,
    });
  }

  Future<Either<Failure, Map<String, dynamic>>> deletePost(int postId) async {
    return await crud.deleteData("${AppLink.posts}/$postId");
  }

  Future<Either<Failure, Map<String, dynamic>>> updateComment({
    required int postId,
    required int commentId,
    required String content,
  }) async {
    return await crud.putData("${AppLink.posts}/$postId/comments/$commentId", {
      "content": content,
    });
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteComment({
    required int postId,
    required int commentId,
  }) async {
    return await crud.deleteData(
      "${AppLink.posts}/$postId/comments/$commentId",
    );
  }
}
