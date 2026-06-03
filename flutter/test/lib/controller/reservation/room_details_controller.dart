import 'package:get/get.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/model/datasource/home/room_details_data.dart';
import 'package:test/model/static/booking/table_model.dart';

class RoomDetailsController extends GetxController {
  RoomDetailsData roomData = RoomDetailsData(Get.find());

  var tables = <TableModel>[].obs;
  var isLoading = false.obs;
  var isRefreshing = false.obs;

  late int roomId;

  @override
  void onInit() {
    super.onInit();

    final arg = Get.arguments;
    roomId = (arg is int) ? arg : int.tryParse(arg?.toString() ?? '') ?? 1;

    print("🏠 ROOM ID => $roomId");
    print("🔥 TOKEN => ${StorageHandler().token}");

    fetchTables();
  }

  bool isTableOccupied(TableModel table) {
  return table.isOccupied;
}

  Future<void> fetchTables({bool showLoading = true}) async {
    if (showLoading) {
      isLoading.value = true;
    } else {
      isRefreshing.value = true;
    }

    try {
      var response = await roomData.getRoom(roomId);

      response.fold(
        (failure) {
          print("❌ REQUEST FAILED => ${failure.message}");
        },
        (data) {
          print("📥 RAW DATA => $data");

          final List list = data['data']['tables'] ?? [];

          tables.assignAll(list.map((e) => TableModel.fromJson(e)).toList());

          tables.refresh();

          for (var table in tables) {
            print(
              "TABLE ${table.tableNum} => isOccupied ${table.isOccupied} | type: ${table.isOccupied.runtimeType}",
            );
          }
        },
      );
    } catch (e) {
      print("❌ CONTROLLER ERROR => $e");
    } finally {
      if (showLoading) {
        isLoading.value = false;
      } else {
        isRefreshing.value = false;
      }
    }
  }

  Future<void> refreshTables() async {
    await fetchTables(showLoading: false);
  }

  void selectTable(TableModel table) {
    if (isTableOccupied(table)) {
      Get.snackbar("خطأ", "الطاولة مشغولة");
      return;
    }

    Get.snackbar("تم", "تم اختيار طاولة ${table.tableNum}");
    print("🪑 SELECTED TABLE => ${table.id}");
  }
}
