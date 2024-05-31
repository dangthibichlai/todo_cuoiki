// ignore_for_file: constant_identifier_names

class EndPoint {
  static const String BASE_URL = "http://10.0.2.2:3000";
  // static const String BASE_URL = "http://localhost:3000";
  static const String tasks = "$BASE_URL/tasks";
  static const String users = "$BASE_URL/users";
  static const String login = "$BASE_URL/auth/sign-in";
  static const String send_otp = "$BASE_URL/auth/send-otp";
  static const String verify_otp = "$BASE_URL/auth/validate-otp";
  static const String register = "$BASE_URL/auth/sign-up";
}
