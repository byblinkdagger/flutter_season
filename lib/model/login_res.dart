class LoginRes {
  String Token;

  LoginRes({this.Token});

  LoginRes.fromJson(Map<String, dynamic> json) {
    Token = json['Token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Token'] = this.Token;
    return data;
  }
}