import 'package:test/core/class/crud.dart';
import 'package:test/linkapi.dart';

class RoomsData {
  final Crud crud;

  RoomsData(this.crud);

  Future<Map<String, dynamic>?> getRooms() async {
    var response = await crud.getData(AppLink.crowding);

    return response.fold(
      (failure) {
        print("ROOMS ERROR => $failure");
        return null;
      },
      (success) {
        return success;
      },
    );
  }
}
