class WalkInCrowdingModel {
  final String roomName;
  final int capacity;
  final int currentInside;
  final double percentage;
  final String color;
  final String status;
  final String message;

  WalkInCrowdingModel({
    required this.roomName,
    required this.capacity,
    required this.currentInside,
    required this.percentage,
    required this.color,
    required this.status,
    required this.message,
  });

  factory WalkInCrowdingModel.fromJson(Map<String, dynamic> json) {
    return WalkInCrowdingModel(
      roomName: json['room_name'] ?? '',
      capacity: json['capacity'] ?? 0,
      currentInside: json['current_inside'] ?? 0,

      // 🔥 مهم التعديل هون
      percentage: (json['crowding_percentage'] as num?)?.toDouble() ?? 0.0,

      color: json['color'] ?? 'grey',
      status: json['status'] ?? '',
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'room_name': roomName,
      'capacity': capacity,
      'current_inside': currentInside,
      'crowding_percentage': percentage,
      'color': color,
      'status': status,
      'message': message,
    };
  }
}
