import 'package:get/get.dart';
import 'package:test/model/datasource/pakages/pakage_data.dart';
import 'package:test/model/static/packages/buy_pakage_model.dart';
import 'package:test/model/static/packages/pakage_model.dart';

class PackagesController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isBuying = false.obs;
  RxBool isCurrentPackageLoading = false.obs;

  RxInt selectedTab = 0.obs;

  PakageData packageData = PakageData(Get.find());

  RxList<PackageModel> packagesToBuy = <PackageModel>[].obs;

  RxList<BuyPackageModel> myPackages = <BuyPackageModel>[].obs;

  Rxn<BuyPackageModel> currentPackage = Rxn<BuyPackageModel>();

  Rxn<PackageModel> selectedPackage = Rxn<PackageModel>();

  final tabs = ['الشخصية', 'الاشتراك', 'الحالية'];

  @override
  void onInit() {
    super.onInit();
    getCurrentPackage();
  }

  void changeTab(int index) {
    selectedTab.value = index;

    if (index == 0) {
      getCurrentPackage(); // الحالية
    } else if (index == 1) {
      getPackagesToBuy(); // الاشتراك
    } else {
      getMyPackages(); // الشخصية
    }
  }

  Future<void> getPackagesToBuy() async {
    try {
      isLoading.value = true;

      final response = await packageData.getPackages();

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },

        (success) {
          final data = success["data"];

          if (data != null && data is List) {
            packagesToBuy.assignAll(
              data
                  .map((e) => PackageModel.fromJson(e as Map<String, dynamic>))
                  .toList(),
            );
          } else {
            packagesToBuy.clear();
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> buyPackage(int packageId) async {
    try {
      isBuying.value = true;

      final response = await packageData.buyPackage(packageId);

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },

        (success) async {
          Get.snackbar(
            "تم",
            success["message"]?.toString() ?? "تم شراء الباقة بنجاح",
          );

          await getMyPackages();

          await getCurrentPackage();

          selectedTab.value = 0;
        },
      );
    } finally {
      isBuying.value = false;
    }
  }

  Future<void> getMyPackages() async {
    try {
      isLoading.value = true;

      final response = await packageData.getMyPackage();

      response.fold(
        (failure) {
          Get.snackbar("خطأ", failure.message);
        },

        (success) {
          final data = success["data"];

          if (data != null && data is List) {
            myPackages.assignAll(
              data
                  .map(
                    (e) => BuyPackageModel.fromJson(e as Map<String, dynamic>),
                  )
                  .toList(),
            );
          } else {
            myPackages.clear();
          }
        },
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> getCurrentPackage() async {
    try {
      isCurrentPackageLoading.value = true;

      final response = await packageData.getActivePackage();

      response.fold(
        (failure) {
          currentPackage.value = null;

          Get.snackbar("خطأ", failure.message);
        },

        (success) {
          final data = success["data"];

          if (data != null && data is Map<String, dynamic>) {
            currentPackage.value = BuyPackageModel.fromJson(data);
          } else {
            currentPackage.value = null;
          }
        },
      );
    } finally {
      isCurrentPackageLoading.value = false;
    }
  }
}
