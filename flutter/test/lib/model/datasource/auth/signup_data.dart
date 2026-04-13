// import 'package:test/core/class/crud.dart';
// import 'package:test/linkapi.dart';

// class SignupData {
//   Crud crud;
//   SignupData(this.crud);
//   postData(
//     String full_name,
//     String phone,
//     String email,
//     String password,
//     String password_confirmation,
//   ) async {
//     var response = await crud.postData(AppLink.SignUP, {
//       "full_name": full_name,
//       "email": email,
//       "password": password,
//       "password_confirmation": password_confirmation,
//     }, {});
//     return response.fold((l) => l, (r) => r);
//   }
// }
import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';
import 'package:test/model/static/signup_model.dart';

class SignupData {
  final Crud crud;

  SignupData(this.crud);

  Future<dynamic> postData(SignupModel model) async {
    var response = await crud.postData(AppLink.SignUP, model.toJson());

    return response.fold((l) => l, (r) => r);
  }
}
