class NewCoinsList { //biz coins nd new coins
  bool status;
  String msg;
  List<Coins> coins;

  NewCoinsList({this.status, this.msg, this.coins});

  NewCoinsList.fromJson(Map<String, dynamic> json) {
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
  int rate;
  String trackid;
  String address;
  String img;

  Coins({this.name, this.rate, this.trackid, this.address, this.img});

  Coins.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rate = json['rate'];
    trackid = json['trackid'];
    address = json['address'];
    img = json['img'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['trackid'] = this.trackid;
    data['address'] = this.address;
    data['img'] = this.img;
    return data;
  }
}