class CrowdRoomModel {
  final int roomId;
  final String roomName;
  final String roomType;
  final int capacity;
  final int totalTables;
  final int occupiedTables;
  final int percentage;
  final String color;
  final String status;
  final String message;

  CrowdRoomModel({
    required this.roomId,
    required this.roomName,
    required this.roomType,
    required this.capacity,
    required this.totalTables,
    required this.occupiedTables,
    required this.percentage,
    required this.color,
    required this.status,
    required this.message,
  });

  factory CrowdRoomModel.fromJson(Map<String, dynamic> json) {
    return CrowdRoomModel(
      roomId: json['room_id'] ?? 0,
      roomName: json['room_name'] ?? '',
      roomType: json['room_type'] ?? '',
      capacity: json['capacity'] ?? 0,
      totalTables: json['total_tables'] ?? 0,
      occupiedTables: json['occupied_tables'] ?? 0,
      percentage: json['percentage'] ?? 0,
      color: json['color'] ?? '',
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }
}
