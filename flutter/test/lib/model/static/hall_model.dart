class RoomModel {
  final int id;
  final String name;
  final String type;
  final int capacity;
  final int currentOccupancy;
  final double percentage;
  final String color;
  final String status;

  RoomModel({
    required this.id,
    required this.name,
    required this.type,
    required this.capacity,
    required this.currentOccupancy,
    required this.percentage,
    required this.color,
    required this.status,
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['room_id'],
      name: json['room_name'],
      type: json['room_type'],
      capacity: json['capacity'],
      currentOccupancy: json['current_occupancy'],
      percentage: (json['percentage'] as num).toDouble(),
      color: json['color'],
      status: json['status'],
    );
  }
}
