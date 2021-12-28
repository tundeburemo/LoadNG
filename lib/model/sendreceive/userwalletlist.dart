class UserwalletList {
  bool status;
  String msg;
  List<Coins> coins;

  UserwalletList({this.status, this.msg, this.coins});

  UserwalletList.fromJson(Map<String, dynamic> json) {
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
  String productname;
  String cointype;
  String useraddress;
  String walletbal;
  String wallettrackid;
  String productrackid;
  String img;

  Coins(
      {this.productname,
      this.cointype,
      this.useraddress,
      this.walletbal,
      this.wallettrackid,
      this.productrackid,
      this.img});

  Coins.fromJson(Map<String, dynamic> json) {
    productname = json['productname'];
    cointype = json['cointype'];
    useraddress = json['useraddress'];
    walletbal = json['walletbal'];
    wallettrackid = json['wallettrackid'];
    productrackid = json['productrackid'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productname'] = this.productname;
    data['cointype'] = this.cointype;
    data['useraddress'] = this.useraddress;
    data['walletbal'] = this.walletbal;
    data['wallettrackid'] = this.wallettrackid;
    data['productrackid'] = this.productrackid;
    data['img'] = this.img;
    return data;
  }
}