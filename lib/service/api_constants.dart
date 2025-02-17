class ApiConstants {
  static const String baseUrl = "http://10.0.60.206:9090/api/v1";
  static const String imageBaseUrl = "http://10.0.60.206:9090";
  static const String signUpEndPoint = "/auth/register";
  static const String otpVerifyEndPoint = "/auth/verify-email";
  static const String logInEndPoint = "/auth/login";
  static const String forgotPassEndPoint = "/auth/forgot-password";
  static const String resetPassEndPoint = "/auth/reset-password";
  static const String changePassEndPoint = "/auth/change-password";
  static const String updateLocationEndPoint = "/info/location";
  static const String getProfileEndPoint = "/users/self/in";
  static const String updateProfileEndPoint = "/users/self/update";
  static const String updateGalleryEndPoint = "/users/self/gallery";
  static const String getHomeAllUserEndPoint = "/users/all/profiles";
  static String getSingleUserEndPoint(String userID) => "/users/profile/$userID";
  static const String interestEndPoint = "/interests/all";
  static const String idealMatchesEndPoint = "/matches/all";
  static const String userMatchingEndPoint = "/users/matching";
  static const String setLocationEndPoint = "/info/location";
  static const String termsConditionEndPoint = "/info/terms-services";
  static const String privacyPolicyEndPoint = "/info/privacy-policy";
  static const String aboutUsEndPoint = "/info/about-us";
}
