class AllLiveRates {
  bool status;
  String msg;
  String universallive;
  String ethlive;
  String ltclive;
  String bchlive;
  int blockchainlive;

  AllLiveRates(
      {this.status,
      this.msg,
      this.universallive,
      this.ethlive,
      this.ltclive,
      this.bchlive,
      this.blockchainlive});

  AllLiveRates.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    universallive = json['universallive'];
    ethlive = json['ethlive'];
    ltclive = json['ltclive'];
    bchlive = json['bchlive'];
    blockchainlive = json['blockchainlive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['universallive'] = this.universallive;
    data['ethlive'] = this.ethlive;
    data['ltclive'] = this.ltclive;
    data['bchlive'] = this.bchlive;
    data['blockchainlive'] = this.blockchainlive;
    return data;
  }
}