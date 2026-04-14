import 'package:get/get.dart';
import 'package:test/core/class/constant/storagehandler.dart';
import 'package:test/model/datasource/auth/room_details_data.dart';
import 'package:test/model/static/table_model.dart';

class RoomDetailsController extends GetxController {
  RoomDetailsData roomData = RoomDetailsData(Get.find());

  var tables = <TableModel>[].obs;
  var isLoading = false.obs;

  late int roomId;

  @override
  void onInit() {
    super.onInit();

    // 🔥 قراءة ID بشكل آمن
    final arg = Get.arguments;

    roomId = (arg is int) ? arg : int.tryParse(arg?.toString() ?? '') ?? 1;

    print("🏠 ROOM ID => $roomId");

    // 🔥 debug token (مهم لحل 403)
    print("🔥 TOKEN => ${StorageHandler().token}");

    fetchTables();
  }

  // =======================
  // 📥 GET ROOM + TABLES
  // =======================
  fetchTables() async {
    isLoading.value = true;

    try {
      var response = await roomData.getRoom(roomId);

      response.fold(
        (failure) {
          print("❌ REQUEST FAILED");
        },
        (data) {
          print("📥 RAW DATA => $data");

          final List list = data['data']['tables'] ?? [];

          tables.value = list.map((e) => TableModel.fromJson(e)).toList();
        },
      );
    } catch (e) {
      print("❌ CONTROLLER ERROR => $e");
    }

    isLoading.value = false;
  }

  // =======================
  // 🪑 SELECT TABLE
  // =======================
  void selectTable(TableModel table) {
    if (table.isOccupied == 1) {
      Get.snackbar("خطأ", "الطاولة مشغولة");
      return;
    }

    Get.snackbar("تم", "تم اختيار طاولة ${table.tableNum}");

    print("🪑 SELECTED TABLE => ${table.id}");
  }
}
