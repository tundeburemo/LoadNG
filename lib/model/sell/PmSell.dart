class PmSellModel {
  bool status;
  String msg;
  String selllink;
  String transref;
  String usdamount;

  PmSellModel({this.msg, this.selllink, this.transref, this.usdamount,this.status});

  PmSellModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    selllink = json['selllink'];
    transref = json['transref'];
    usdamount = json['usdamount'];
  } 

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['selllink'] = this.selllink;
    data['transref'] = this.transref;
    data['usdamount'] = this.usdamount;
    return data;
  }
}