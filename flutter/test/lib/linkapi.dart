class AppLink {
  static const String server = "http://192.168.196.1:8080/api";
  static const String SignUP = "$server/register";
  static const String login = "$server/login";
  static const String crowding = "$server/crowding";
  static const String checkIn = "$server/bookings/check_in";
  static const String checkOut = "$server/bookings/check_out";
  static const String rooms = "$server/rooms";
  static const String bookings = "$server/bookings";
  static const String emailVerificationNotification =
      "$server/email/verification-notification";
  static const String crowdingWalkIn = "$server/crowding/walkin";
  static const String packages = "$server/packages";
  static const String buyPackage = "$server/buy";
  static const String myPackage = "$server/myPackage";
  static const String activePackage = "$server/active";
  static const String posts = "$server/posts";
  static const String addcomments = "posts/{id}/comments";
  static const String comments = "$server/posts/{postId}/comments/{commentId}";
}
