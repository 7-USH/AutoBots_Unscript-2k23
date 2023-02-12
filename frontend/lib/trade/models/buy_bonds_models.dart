class BuyBonds {
  double? lastPrice;
  double? bondPrice;
  double? downVal;
  String? change;
  double? faceValue;
  String? id;
  double? upVal;
  double? volume;
  bool? available;
  String? companyName;

  BuyBonds(
      {this.lastPrice,
      this.bondPrice,
      this.downVal,
      this.change,
      this.companyName,
      this.faceValue,
      this.id,
      this.upVal,
      this.volume,
      this.available});

  BuyBonds.fromJson(Map<String, dynamic> json) {
    lastPrice = json['last_price'];
    bondPrice = json['bond_price'];
    downVal = json['down_val'];
    change = json['change'];
    companyName = json['company_name'];
    faceValue = json['face_value'];
    id = json['id'];
    upVal = json['up_val'];
    volume = json['volume'];
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['last_price'] = lastPrice;
    data['bond_price'] = bondPrice;
    data['down_val'] = downVal;
    data['change'] = change;
    data['company_name'] = companyName;
    data['face_value'] = faceValue;
    data['id'] = id;
    data['up_val'] = upVal;
    data['volume'] = volume;
    data['available'] = available;
    return data;
  }
}
