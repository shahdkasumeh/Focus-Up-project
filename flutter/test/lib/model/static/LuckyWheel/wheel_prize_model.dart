// class WheelPrizeModel {
//   final int id;
//   final String name;
//   final String value;
//   final bool isUsed;

//   WheelPrizeModel({
//     required this.id,
//     required this.name,
//     required this.value,
//     required this.isUsed,
//   });

//   factory WheelPrizeModel.fromJson(Map<String, dynamic> json) {
//     return WheelPrizeModel(
//       id: int.tryParse(json['id'].toString()) ?? 0,
//       name: json['name']?.toString() ?? '',
//       value: json['value']?.toString() ?? '',
//       isUsed: json['is_used'] == true || json['is_used'] == 1,
//     );
//   }
// }
class WheelPrizeModel {
  final int id;
  final String name;
  final String value;
  final bool isUsed;

  WheelPrizeModel({
    required this.id,
    required this.name,
    required this.value,
    this.isUsed = false,
  });

  factory WheelPrizeModel.fromJson(Map<String, dynamic> json) {
    return WheelPrizeModel(
      id: int.tryParse(json['id']?.toString() ?? '0') ?? 0,
      name: json['name']?.toString() ?? '',
      value: json['value']?.toString() ?? '',
      isUsed: json['is_used'] == true ||
          json['is_used'] == 1 ||
          json['is_used']?.toString() == '1',
    );
  }
}