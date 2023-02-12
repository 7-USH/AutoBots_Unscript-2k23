class BondModel {
  String? companyName;
  double? lastPrice;
  String? change;
  double? open;
  double? high;
  double? low;
  double? volume;
  double? faceValue;

  BondModel(
      {this.companyName,
      this.lastPrice,
      this.change,
      this.open,
      this.high,
      this.low,
      this.volume,
      this.faceValue});

  BondModel.fromJson(Map<String, dynamic> json) {
    companyName = json['company_name'];
    lastPrice = json['last_price'];
    change = json['change'];
    open = json['open'];
    high = json['high'];
    low = json['low'];
    volume = json['volume'];
    faceValue = json['face_value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['company_name'] = companyName;
    data['last_price'] = lastPrice;
    data['change'] = change;
    data['open'] = open;
    data['high'] = high;
    data['low'] = low;
    data['volume'] = volume;
    data['face_value'] = faceValue;
    return data;
  }
}
