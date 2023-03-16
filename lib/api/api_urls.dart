import 'dart:core';

class Apis {
  static const String baseUrl = 'https://jobstarterapp.com/api/';
  static var signUpUrl = Uri.parse(baseUrl + 'signup');
  static var signInUrl = Uri.parse(baseUrl + 'login');
  static var otpUrl = Uri.parse(baseUrl + 'verify-otp');
  static var updateProfileUrl = Uri.parse(baseUrl + 'update-profile');
  static var updateProfileImg = Uri.parse(baseUrl + 'update-profile-image');
  static var getUsersList = Uri.parse(baseUrl + 'graduates');
  static var logout = Uri.parse(baseUrl + 'logout');
}
