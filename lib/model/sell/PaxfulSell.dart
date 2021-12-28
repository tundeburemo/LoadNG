class PaxfulSellModel {
  bool status;
  String msg;
  String selllink;
  String transref;
  String usdamount;
  String btcamount;

  PaxfulSellModel(
      {this.status,
      this.msg,
      this.selllink,
      this.transref,
      this.usdamount,
      this.btcamount});

  PaxfulSellModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    selllink = json['selllink'];
    transref = json['transref'];
    usdamount = json['usdamount'];
    btcamount = json['btcamount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['selllink'] = this.selllink;
    data['transref'] = this.transref;
    data['usdamount'] = this.usdamount;
    data['btcamount'] = this.btcamount;
    return data;
  }
}