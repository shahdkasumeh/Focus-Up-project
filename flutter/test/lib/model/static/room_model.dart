// import 'package:test/model/static/table_model.dart';

// class RoomModel {
//   final int id;
//   final String name;
//   final String type;
//   final int capacity;
//   final int isActive;
//   final int isOccupied;
//   final String status;
//   final List<TableModel> tables;

//   RoomModel({
//     required this.id,
//     required this.name,
//     required this.type,
//     required this.capacity,
//     required this.isActive,
//     required this.isOccupied,
//     required this.status,
//     required this.tables,
//   });

//   factory RoomModel.fromJson(Map<String, dynamic> json) {
//     return RoomModel(
//       id: json["id"],
//       name: json["name"],
//       type: json["type"],
//       capacity: json["capacity"],
//       isActive: json["is_active"],
//       isOccupied: json["is_occupied"],
//       status: json["status"],
//       tables: (json["tables"] as List)
//           .map((t) => TableModel.fromJson(t))
//           .toList(),
//     );
//   }
// }
