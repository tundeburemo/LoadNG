class Biz2walletList {
  bool status;
  String msg;
  List<Wallet> wallet;

  Biz2walletList({this.status, this.msg, this.wallet});

  Biz2walletList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['wallet'] != null) {
      wallet = new List<Wallet>();
      json['wallet'].forEach((v) {
        wallet.add(new Wallet.fromJson(v));
      });
    }
  }
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.wallet != null) {
      data['wallet'] = this.wallet.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Wallet {
  String coinname;
  String address;
  dynamic rate;
  String theimage;
  String colorcode;
  String memo;

  Wallet(
      {this.coinname, this.address, this.rate, this.theimage, this.colorcode,this.memo});

  Wallet.fromJson(Map<String, dynamic> json) {
    coinname = json['coinname'];
    address = json['address'];
    rate = json['rate'];
    theimage = json['theimage'];
    colorcode = json['colorcode'];
    memo = json['memo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['coinname'] = this.coinname;
    data['address'] = this.address;
    data['rate'] = this.rate;
    data['theimage'] = this.theimage;
    data['colorcode'] = this.colorcode;
    data['memo'] = this.memo;
    return data;
  }
}