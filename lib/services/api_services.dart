import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import '../api/api_urls.dart';
import '../models/user.dart';

class ApiServices {
  var token;

  final _dio = Dio();

  // Future<bool> setToken(String value) async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.setString('token', value);
  // }

  // Future<String> getToken() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   return prefs.getString('token');
  // }

  Future<dynamic> authenticate(
      {String email, String name, String password, String type}) async {
    final Map<String, dynamic> registrationData = {
      'name': name,
      'email': email,
      'password': password,
      'type': type
    };
    // try {
    //   final response = await http.post(Apis.signUpUrl, body: registrationData);
    //   print(response.body);
    //   print(response.statusCode);
    //   return response.body;
    // } on HttpException catch (e) {
    //   print('error = $e');
    //   return e;
    // }
    print(registrationData);
    try {
      print('try...');
      final response = await http.post(Apis.signUpUrl, body: registrationData);
      var jsonData = json.decode(response.body);
      print('response: $jsonData');

      print(response.statusCode);

      if (response.statusCode == 200) {
        return jsonData;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // Future<User> register(
  //     {String email, String name, String password, String type}) async {
  //   final Map<String, String> registrationData = {
  //     'name': name,
  //     'email': email,
  //     'password': password,
  //     'type': type
  //   };

  //   print('$email, $name, $password, $type');

  //   try {
  //     final response = await http.post(
  //       Apis.signUpUrl,
  //       body: json.encode(registrationData),
  //     );
  //     if (response.statusCode == 200) {
  //       print(response.body);
  //       User authUser = User.fromJson(jsonDecode(response.body));
  //       return authUser;
  //     } else {
  //       throw Exception(response.statusCode);
  //     }
  //   } catch (error) {
  //     onError(error);
  //   }
  // }

  // static Future<dynamic> onValue(http.Response response) async {
  //   Map<String, Object> result;
  //   final Map<String, dynamic> responseData = json.decode(response.body);

  //   if (response.statusCode == 200) {
  //     var userData = responseData['data'];

  //     User authUser = User.fromJson(userData);

  //     // UserPreferences().saveUser(authUser);
  //     result = {
  //       'status': true,
  //       'message': 'Successfully registered',
  //       'data': authUser
  //     };
  //   } else {
  //     result = {
  //       'status': false,
  //       'message': 'Registration failed',
  //       'data': responseData
  //     };
  //   }

  //   return result;
  // }

  // static onError(error) {
  //   print("the error is $error.detail");
  //   return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  // }

  // Future<void> loginUser(
  //     {String email, String password, BuildContext ctx}) async {
  //   final url = Apis.signInUrl;

  //   try {
  //     final response = await http.post(url, body: <String, String>{
  //       'email': email,
  //       'password': password,
  //     }, headers: <String, String>{
  //       "Access-Control-Allow-Origin": '*',
  //     });

  //     if (response.statusCode == 200) {
  //       var jsonData = json.decode(response.body);
  //       token = setToken(jsonData['token']);
  //       var message = jsonData['message'];
  //       print('token = $token');
  //       print(response.body);
  //       String role = jsonData['data']['role'];
  //       var data = jsonData['data'];
  //       print(response.statusCode);
  //       if (role == 'graduate') {
  //         print('${data['password']} | ${data['email']}');
  //         Navigator.of(ctx).pushAndRemoveUntil(
  //           MaterialPageRoute(
  //               builder: (ctx) => HomePage(
  //                     name: data['name'],
  //                     email: data['email'],
  //                     address: data['address'],
  //                     photo: data['profile_image'],
  //                     dob: data['dob'],
  //                     description: data['description'],
  //                     school: data['school'],
  //                   )),
  //           (route) => false,
  //         );
  //       } else if (role == 'company') {
  //         Navigator.of(ctx).pushAndRemoveUntil(
  //           MaterialPageRoute(builder: (ctx) => const CompanyProfile()),
  //           (route) => false,
  //         );
  //       } else {
  //         print('else Invalid user');
  //       }
  //     } else {
  //       print(response.body);
  //       print(response.statusCode);
  //       throw Exception();
  //     }
  //   } catch (e) {
  //     print(e);

  //     throw Exception(e);
  //   }
  // }

  Future<dynamic> loginApi(String email, String password) async {
    try {
      final response = await _dio.post(
        'https://jobstarterapp.com/api/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      print(response.data);
      return response.data;
    } on DioError catch (e) {
      print(e.response.data);
      return e.response.data;
    }
  }

  Future logOut(String id, String token) async {
    try {
      final response = await _dio.get(
        'https://jobstarterapp.com/api/logout/$id',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      print(response.data);
    } on DioError catch (e) {
      return e.response.data;
    }
  }

  Future<Map<String, dynamic>> getUserData(
      String accessToken, String id) async {
    try {
      print('user id : $id');
      final response = await _dio.get(
          'https://jobstarterapp.com/api/profile/$id',
          options: Options(headers: {'Authorization': 'Bearer $accessToken'}));
      print('get user data: ${response.data}');
      final result = jsonDecode(response.data) as Map<String, dynamic>;
      return result;
    } on DioError catch (e) {
      print(e.response.data);
      return e.response.data;
    }
  }

  Future<dynamic> verifyOtp(
      String otp, String userId, String verifyToken) async {
    print(userId);
    try {
      final response = await http.post(Apis.otpUrl, headers: {
        'Authorization': 'Bearer $verifyToken'
      }, body: {
        'user_id': userId,
        'otp': otp,
      });
      // final response = await _dio.post(
      //     'https://jobstarterapp.com/api/verify-otp',
      //     options: Options(headers: {'Authorization': 'Bearer $verifyToken'}));
      print(response.body);
      print(response.reasonPhrase);
      final data = json.decode(response.body);
      print(data);
      if (response.statusCode == 200) {
        return data;
      } else {
        print(response.statusCode);
        return;
      }
    } catch (e) {
      print(e);
      throw Exception(e.message);
    }
  }

  Future<dynamic> updataUserProfile(
      String token, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(
        'https://jobstarterapp.com/api/update-profile',
        data: data,
        options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
            validateStatus: (status) {
              return status == 200;
            }),
      );
      return response.data;
    } on DioError catch (e) {
      print('dio: $e');
      return e.response.data;
    }
  }

  Future<void> updateImage(String userId, File file, String imgToken) async {
    try {
      final request = http.MultipartRequest("POST", Apis.updateProfileImg);

      request.fields['user_id'] = userId;
      request.headers['Authorization'] = 'Bearer $imgToken';
      request.headers['Content-type'] = "application/json";
      // request.headers['Accept'] = "application/json";
      var pic = await http.MultipartFile.fromPath("image", file.path);
      print('path: ${file.path}');
      request.files.add(pic);

      final response = await request.send();
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      print('image: ${response.statusCode}');
      if (response.statusCode == 200) {
        print(response.statusCode);
        print(responseString);
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('error in response: $e');
      throw Exception(e);
    }
  }

  Future<List<Data>> graduatesList(String token) async {
    try {
      final response = await http
          .get(Apis.getUsersList, headers: {'Authorization': 'Bearer $token'});
      print(response.statusCode);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        print(data);
        var users = User.fromJson(data);

        print(users.data[0]);

        // final userData = data['data'];
        // print(userData.runtimeType);

        // var usersList = UserData.fromJson(userData);
        // print(usersList.name);
        return users.data;
      }
    } on DioError catch (e) {
      print(e.response.statusMessage);
    }
  }

  Future<Map<String, dynamic>> getAllSub(String token) async {
    final response = await http.get(
      Uri.parse('https://jobstarterapp.com/api/subscriptions'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print('response: ${response.body}');
      final result = jsonDecode(response.body) as Map<String, dynamic>;
      return result;
    } else {
      print(response.statusCode);
      throw Exception(response.reasonPhrase);
    }
  }

  Future<Map<String, dynamic>> freeTrial(String token, String companyId) async {
    try {
      const url = 'https://jobstarterapp.com/api/free-trial';
      final response = await http.post(
        Uri.parse(url),
        body: {'company': companyId, 'subscription': '1'},
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        print(response.body);
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        return result;
      } else {
        print(response.statusCode);
        throw Exception(response.reasonPhrase);
      }
    } catch (e) {
      print(e);
      throw Exception(e);
    }
  }

  Future<Map<String, dynamic>> subscriptions(
      {String token, Map<String, dynamic> data}) async {
    try {
      print('object: $data');
      print(token);
      final response = await http.post(
        Uri.parse('https://jobstarterapp.com/api/pay'),
        body: data,
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.statusCode);

      if (response.statusCode == 200) {
        print(response.body);
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        return result;
      } else if (response.statusCode >= 400) {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        return result;
      } else {
        final result = jsonDecode(response.body) as Map<String, dynamic>;
        print('statuscode:');
        print(response.statusCode);
        print(response.body);
        return result;
      }
    } catch (e) {
      print('dio error: $e');
      throw Exception(e);
    }
  }

  Future<void> sendEmial(
      {String companyId, String graduateId, String token}) async {
    try {
      final response = await _dio.post(
        'https://jobstarterapp.com/api/send_mail',
        data: {
          'company_id': companyId,
          'graduate_id': graduateId,
        },
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.statusCode == 200) {
        print(response.data);

        // return response.data;
      } else {
        print(response.statusCode);
        // return response.data;
      }
    } on DioError catch (e) {
      print(e.response.data);
      // return e.response.data;
    }
  }
}
