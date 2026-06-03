import 'package:get/get.dart';

String? validInput(String val, int min, int max, String type) {
  if (val.trim().isEmpty) {
    return "can't be empty";
  }

  if (type == "username") {
    if (!GetUtils.isUsername(val.trim())) {
      return "not valid username";
    }
  }

  if (type == "email") {
    if (!GetUtils.isEmail(val.trim())) {
      return "not valid email";
    }
  }

  if (type == "phone") {
    if (!GetUtils.isPhoneNumber(val.trim())) {
      return "not valid phone";
    }
  }

  if (type == "verifycode") {
    if (!GetUtils.isNumericOnly(val.trim())) {
      return "Verification code must contain numbers only";
    }

    if (val.trim().length != 6) {
      return "Verification code must be 6 digits";
    }

    return null;
  }

  if (val.trim().length < min) {
    return "can't be less than $min";
  }

  if (val.trim().length > max) {
    return "can't be larger than $max";
  }

  return null;
}