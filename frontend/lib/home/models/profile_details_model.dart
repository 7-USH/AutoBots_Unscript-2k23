class ProfileDetailsModel {
  bool? isActive;
  String? email;
  String? address;
  String? dob;
  double? accountBalance;
  String? fullName;
  String? registrationDate;
  String? aadhaarNo;
  String? gender;

  ProfileDetailsModel(
      {this.isActive,
      this.email,
      this.address,
      this.dob,
      this.accountBalance,
      this.fullName,
      this.registrationDate,
      this.aadhaarNo,
      this.gender});

  ProfileDetailsModel.fromJson(Map<String, dynamic> json) {
    isActive = json['is_active'];
    email = json['email'];

    address = json['address'];
    dob = json['dob'];
    accountBalance = json['account_balance'];
    fullName = json['full_name'];
    registrationDate = json['registration_date'];
    aadhaarNo = json['aadhaar_no'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['is_active'] = isActive;
    data['email'] = email;

    data['address'] = address;
    data['dob'] = dob;
    data['account_balance'] = accountBalance;
    data['full_name'] = fullName;
    data['registration_date'] = registrationDate;
    data['aadhaar_no'] = aadhaarNo;
    data['gender'] = gender;
    return data;
  }
}
