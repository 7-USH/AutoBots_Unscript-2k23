class RegisterModel {
  String? email;
  String? password;
  String? fullName;

  RegisterModel({this.email, this.password, this.fullName});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fullName = json['full_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['full_name'] = fullName;
    return data;
  }
}
