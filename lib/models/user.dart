// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'login.dart';

class User {
  String? id;
  String? username;
  String? avatar;
  String? fullname;
  String? email;
  String? description;

  User(
      {this.id,
      this.username,
      this.avatar,
      this.fullname,
      this.email,
      this.description});

  User.fromLoginResponse(LoginResponse response) {
    this.id = response.id;
    this.username = response.username;
    this.avatar = response.avatar;
    this.fullname = response.fullname;
    this.email = response.email;
    this.description = response.description;
  }
}

class UserResponse extends User {
  UserResponse(id, username, fullname, avatar, email, description)
      : super(
            id: id,
            username: username,
            fullname: fullname,
            avatar: avatar,
            email: email,
            description: description);

  UserResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    avatar = json['avatar'];
    fullname = json['fullname'];
    email = json['email'];
    description = json['description'];
  }

  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['avatar'] = this.avatar;
    data['fullname'] = this.fullname;
    data['email'] = this.email;
    data['description'] = this.description;
    return data;
  }
}
