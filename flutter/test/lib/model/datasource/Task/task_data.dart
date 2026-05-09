import 'package:dartz/dartz.dart';
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class TaskData {
  final Crud crud;

  TaskData(this.crud);

  Future<Either<Failure, Map<String, dynamic>>> getTasksByDate(
    String date,
  ) async {
    return await crud.getData(
      "${AppLink.tasks}?date=$date",
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> createTask({
    required String title,
    required String description,
    required String dueDate,
  }) async {
    return await crud.postData(
      AppLink.tasks,
      {
        "title": title,
        "description": description,
        "due_date": dueDate,
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> updateTask({
    required int taskId,
    required String title,
    required String description,
    required String dueDate,
  }) async {
    return await crud.putData(
      "${AppLink.tasks}/$taskId",
      {
        "title": title,
        "description": description,
        "due_date": dueDate,
      },
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> completeTask(
    int taskId,
  ) async {
    return await crud.patchData(
      "${AppLink.tasks}/$taskId/done",
      {},
    );
  }

  Future<Either<Failure, Map<String, dynamic>>> deleteTask(
    int taskId,
  ) async {
    return await crud.deleteData(
      "${AppLink.tasks}/$taskId",
    );
  }
}