class WalletSellModel {
  bool status;
  String msg;
  String wallet;

  WalletSellModel({this.status, this.msg, this.wallet});

  WalletSellModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    wallet = json['wallet'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['wallet'] = this.wallet;
    return data;
  }
}