class UserBizSuitWalletList {
  bool status;
  String msg;
  List<Coins> coins;

  UserBizSuitWalletList({this.status, this.msg, this.coins});

  UserBizSuitWalletList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['coins'] != null) {
      coins = new List<Coins>();
      json['coins'].forEach((v) {
        coins.add(new Coins.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.coins != null) {
      data['coins'] = this.coins.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Coins {
  String bankname;
  int walletrate;
  String nameofwallet;
  String address;
  String bankaccno;
  String colorcode;
  String coinname;
  int wallletid;

  Coins(
      {this.bankname,
      this.walletrate,
      this.nameofwallet,
      this.address,
      this.bankaccno,
      this.colorcode,
      this.coinname,
      this.wallletid});

  Coins.fromJson(Map<String, dynamic> json) {
    bankname = json['bankname'];
    walletrate = json['walletrate'];
    nameofwallet = json['nameofwallet'];
    address = json['address'];
    bankaccno = json['bankaccno'];
    colorcode = json['colorcode'];
    coinname = json['coinname'];
    wallletid = json['wallletid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankname'] = this.bankname;
    data['walletrate'] = this.walletrate;
    data['nameofwallet'] = this.nameofwallet;
    data['address'] = this.address;
    data['bankaccno'] = this.bankaccno;
    data['colorcode'] = this.colorcode;
    data['coinname'] = this.coinname;
    data['wallletid'] = this.wallletid;
    return data;
  }
}