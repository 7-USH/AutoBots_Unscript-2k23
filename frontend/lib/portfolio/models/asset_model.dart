// ignore_for_file: unnecessary_new

class AssetModel {
  String? bondId;
  String? id;
  String? userEmail;
  String? timestamp;
  BondDetails? bondDetails;

  AssetModel(
      {this.bondId, this.id, this.userEmail, this.timestamp, this.bondDetails});

  AssetModel.fromJson(Map<String, dynamic> json) {
    bondId = json['bond_id'];
    id = json['id'];
    userEmail = json['user_email'];
    timestamp = json['timestamp'];
    bondDetails = json['bond_details'] != null
        ? new BondDetails.fromJson(json['bond_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bond_id'] = bondId;
    data['id'] = id;
    data['user_email'] = userEmail;
    data['timestamp'] = timestamp;
    if (bondDetails != null) {
      data['bond_details'] = bondDetails!.toJson();
    }
    return data;
  }
}

class BondDetails {
  double? lastPrice;
  String? companyName;
  double? upVal;
  String? change;
  double? faceValue;
  double? bondPrice;
  String? id;
  double? downVal;
  double? volume;
  bool? available;

  BondDetails(
      {this.lastPrice,
      this.companyName,
      this.upVal,
      this.change,
      this.faceValue,
      this.bondPrice,
      this.id,
      this.downVal,
      this.volume,
      this.available});

  BondDetails.fromJson(Map<String, dynamic> json) {
    lastPrice = json['last_price'];
    companyName = json['company_name'];
    upVal = json['up_val'];
    change = json['change'];
    faceValue = json['face_value'];
    bondPrice = json['bond_price'];
    id = json['id'];
    downVal = json['down_val'];
    volume = json['volume'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_price'] = lastPrice;
    data['company_name'] = companyName;
    data['up_val'] = upVal;
    data['change'] = change;
    data['face_value'] = faceValue;
    data['bond_price'] = bondPrice;
    data['id'] = id;
    data['down_val'] = downVal;
    data['volume'] = volume;
    data['available'] = available;
    return data;
  }
}
