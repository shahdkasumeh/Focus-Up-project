class AppLink {
  static const String server = "http://192.168.1.111:8080/api";
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
  //static const String comments = "$server/posts/{postId}/comments/{commentId}";
  static const String tasks = "$server/tasks";
  static const String profile = "$server/profile";
  static const String uploadProfileImage = "$server/profile/image";
  static const String forgetPassword = "$server/forgot-password";
  static const String prizes = "$server/prizes";
static const String canSpin = "$server/can-spin";
static const String spin = "$server/spin";
static const String myPrizes = "$server/wheel/my-prizes";
static const String currentPrize = "$server/wheel/my-prizesCurrent";
}
