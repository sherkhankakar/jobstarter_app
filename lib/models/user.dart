// // ignore_for_file: non_constant_identifier_names

// class User {
//   bool status;
//   String message;
//   String token;
//   dynamic data;

//   User({this.status, this.message, this.token, this.data});

//   User.fromJson(Map<String, dynamic> json)
//       : status = json['status'],
//         message = json['message'],
//         token = json['token'],
//         data = json['data'];

//   Map<String, dynamic> toJson() => {
//         'status': status,
//         'message': message,
//         'token': token,
//         'data': data,
//       };
// }

// class UserData {
//   String name;
//   String address;
//   String description;
//   String dob;
//   String email;
//   String school;
//   String profile_image;
//   String id;

//   UserData({
//     this.id,
//     this.school,
//     this.profile_image,
//     this.address,
//     this.dob,
//     this.description,
//     this.email,
//     this.name,
//   });

//   UserData.fromJson(Map<String, dynamic> json)
//       : name = json['name'],
//         email = json['email'],
//         dob = json['dob'],
//         description = json['description'],
//         address = json['address'],
//         school = json['school'],
//         profile_image = json['profile_image'];

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'email': email,
//         'dob': dob,
//         'description': description,
//         'address': address,
//         'profile_image': profile_image,
//         'school': school,
//       };
// }

class User {
  bool status;
  String message;
  String token;
  List<Data> data;

  User({this.status, this.message, this.data, this.token});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    token = json['token'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int id;
  String name;
  String email;
  String profileImage;
  String school;
  String address;
  String description;
  String dob;

  Data(
      {this.id,
      this.name,
      this.email,
      this.profileImage,
      this.school,
      this.address,
      this.description,
      this.dob});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    profileImage = json['profile_image'];
    school = json['school'];
    address = json['address'];
    description = json['description'];
    dob = json['dob'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['profile_image'] = profileImage;
    data['school'] = school;
    data['address'] = address;
    data['description'] = description;
    data['dob'] = dob;
    return data;
  }
}
