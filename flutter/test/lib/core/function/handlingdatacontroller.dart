import 'package:test/core/class/statusrequest.dart';

StatusRequest handlingData(dynamic response) {
  // إذا ما في رد
  if (response == null) {
    return StatusRequest.serverfailure;
  }

  // إذا كان response من نوع failure (Left من dartz)
  if (response is StatusRequest) {
    return response;
  }

  // إذا البيانات جاية صح
  if (response is Map) {
    return StatusRequest.success;
  }

  // أي حالة غير معروفة
  return StatusRequest.serverfailure;
}
