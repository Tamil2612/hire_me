class RegistrationResponse {
  bool? status;
  String? msg;
  String? accessToken;
  User? user;

  RegistrationResponse({this.status, this.msg, this.accessToken, this.user});

  factory RegistrationResponse.fromJson(Map<String, dynamic> json) {
    return RegistrationResponse(
      status: json['status'],
      msg: json['msg'],
      accessToken: json['accessToken'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'msg': msg,
      'accessToken': accessToken,
      'user': user?.toJson(),
    };
  }
}

class User {
  String? userName;
  String? email;
  int? phone;
  String? registerType;
  String? companyName;
  String? businessEmail;
  int? businessNumber;
  String? address;

  User({
    this.userName,
    this.email,
    this.phone,
    this.registerType,
    this.companyName,
    this.businessEmail,
    this.businessNumber,
    this.address,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userName: json['userName'],
      email: json['email'],
      phone: json['phone'],
      registerType: json['registerType'],
      companyName: json['companyName'],
      businessEmail: json['businessEmail'],
      businessNumber: json['businessNumber'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userName': userName,
      'email': email,
      'phone': phone,
      'registerType': registerType,
      'companyName': companyName,
      'businessEmail': businessEmail,
      'businessNumber': businessNumber,
      'address': address,
    };
  }
}

