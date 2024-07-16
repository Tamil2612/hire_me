class GetUserDetailsResponse {
  bool? status;
  String? msg;
  Data? data;

  GetUserDetailsResponse({this.status, this.msg, this.data});

  GetUserDetailsResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
class Data {
  String? userName;
  String? email;
  int? phone;
  String? registerType;
  String? companyName;
  String? businessEmail;
  int? businessNumber;
  String? address;

  Data({
    this.userName,
    this.email,
    this.phone,
    this.registerType,
    this.companyName,
    this.businessEmail,
    this.businessNumber,
    this.address,
  });

  factory Data.fromJson(Map<String, dynamic> json) {
    return Data(
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
