class LoginResponse {
  String? id;
  String? username;
  String? fullname;
  String? createdAt;
  String? avatar;
  String? description;
  String? email;
  String? token;
  String? refreshToken;

  LoginResponse(
      {this.id,
      this.username,
      this.fullname,
      this.createdAt,
      this.avatar,
      this.description,
      this.email,
      this.token,
      this.refreshToken});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    fullname = json['fullname'];
    createdAt = json['createdAt'];
    avatar = json['avatar'];
    description = json['description'];
    email = json['email'];
    token = json['token'];
    refreshToken = json['refreshToken'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['username'] = username;
    data['fullname'] = fullname;
    data['description'] = description;
    data['email'] = email;
    data['token'] = token;
    data['avatar'] = avatar;
    data['refreshToken'] = refreshToken;
    return data;
  }
}

class LoginRequest {
  String? username;
  String? password;

  LoginRequest({this.username, this.password});

  LoginRequest.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['username'] = username;
    data['password'] = password;
    return data;
  }
}
