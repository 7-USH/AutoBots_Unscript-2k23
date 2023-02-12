class RegisterModel {
  String? email;
  String? password;
  String? fullName;
  String? aadhaar_image_back;
  String? aadhaar_image_front;
  String? device_token;

  RegisterModel(
      {this.email,
      this.password,
      this.fullName,
      this.device_token,
      this.aadhaar_image_back,
      this.aadhaar_image_front});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    fullName = json['full_name'];
    device_token = json['device_token'];
    aadhaar_image_front = json['aadhaar_image_front'];
    aadhaar_image_back = json['aadhaar_image_back'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['full_name'] = fullName;
    data['device_token'] = device_token;
    data['aadhaar_image_front'] = aadhaar_image_front;
    data['aadhaar_image_back'] = aadhaar_image_back;
    return data;
  }
}
