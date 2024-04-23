/// status : 200
/// message : "Verifikasi OTP berhasil."
/// data : {"id":1,"email":"yoga.irgi14@smk.belajar.id","username":"Yogha Kurniawan","level":"User","token":"5|7FuxC6Q2nRsRnnfAMPhApEoH2EQFaSfOSzS7yQ9R5eeb36cc"}

class ResponseLogin {
  ResponseLogin({
      this.status, 
      this.message, 
      this.data,});

  ResponseLogin.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? DataLogin.fromJson(json['data']) : null;
  }
  int? status;
  String? message;
  DataLogin? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }

}

/// id : 1
/// email : "yoga.irgi14@smk.belajar.id"
/// username : "Yogha Kurniawan"
/// level : "User"
/// token : "5|7FuxC6Q2nRsRnnfAMPhApEoH2EQFaSfOSzS7yQ9R5eeb36cc"

class DataLogin {
  DataLogin({
      this.id, 
      this.email, 
      this.username, 
      this.level, 
      this.token,});

  DataLogin.fromJson(dynamic json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    level = json['level'];
    token = json['token'];
  }
  int? id;
  String? email;
  String? username;
  String? level;
  String? token;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['email'] = email;
    map['username'] = username;
    map['level'] = level;
    map['token'] = token;
    return map;
  }

}