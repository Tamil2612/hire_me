class LoginResponse {
  bool? status;
  String? msg;
  String? accessToken;
  User? user;

  LoginResponse({this.status, this.msg, this.accessToken, this.user});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    accessToken = json['accessToken'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    data['accessToken'] = accessToken;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    return data;
  }
}

class User {
  String? id;
  String? email;
  int? phone;
  String? address;
  String? companyName;

  User({this.id, this.email, this.phone, this.address, this.companyName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    address = json['address'];
    companyName = json['companyName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['email'] = email;
    data['phone'] = phone;
    data['address'] = address;
    data['companyName'] = companyName;
    return data;
  }
}
