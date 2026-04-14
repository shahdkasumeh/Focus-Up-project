class CrowdRoomModel {
  final int id;
  final String roomName;
  final String roomType;
  final int capacity;
  final int currentOccupancy;
  final double percentage;
  final String color;
  final String status;

  CrowdRoomModel({
    required this.id,
    required this.roomName,
    required this.roomType,
    required this.capacity,
    required this.currentOccupancy,
    required this.percentage,
    required this.color,
    required this.status,
  });

  factory CrowdRoomModel.fromJson(Map<String, dynamic> json) {
    return CrowdRoomModel(
      id: json['room_id'],
      roomName: json['room_name'],
      roomType: json['room_type'],
      capacity: json['capacity'],
      currentOccupancy: json['current_occupancy'],
      percentage: (json['percentage'] as num).toDouble(),
      color: json['color'],
      status: json['status'],
    );
  }
}
