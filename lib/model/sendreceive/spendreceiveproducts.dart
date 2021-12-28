class AllSpendReceiveProducts {
  bool status;
  String msg;
  List<Coins> coins;

  AllSpendReceiveProducts({this.status, this.msg, this.coins});

  AllSpendReceiveProducts.fromJson(Map<String, dynamic> json) {
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
  String name;
  String cointype;
  String trackid;
  String img;

  Coins({this.name, this.cointype, this.trackid, this.img});

  Coins.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cointype = json['cointype'];
    trackid = json['trackid'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cointype'] = this.cointype;
    data['trackid'] = this.trackid;
    data['img'] = this.img;
    return data;
  }
}