class AllRates {
  bool status;
  String msg;
  String paxful;
  String blockchain;
  String universal;
  int pm;
  String eth;
  String bch;
  String ltc;
  String usdc;
  String dai;
  String doge;
  List<Others> others;

  AllRates(
      {this.status,
      this.msg,
      this.paxful,
      this.blockchain,
      this.universal,
      this.pm,
      this.eth,
      this.bch,
      this.ltc,
      this.usdc,
      this.doge,
      this.dai,
      this.others});

  AllRates.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    paxful = json['paxful'];
    blockchain = json['blockchain'];
    universal = json['universal'];
    pm = json['pm'];
    eth = json['eth'];
    bch = json['bch'];
    ltc = json['ltc'];
    usdc = json['usdc'];
    dai = json['dai'];
    doge = json['doge'];

    if (json['others'] != null) {
      others = new List<Others>();
      json['others'].forEach((v) {
        others.add(new Others.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['paxful'] = this.paxful;
    data['blockchain'] = this.blockchain;
    data['universal'] = this.universal;
    data['pm'] = this.pm;
    data['eth'] = this.eth;
    data['bch'] = this.bch;
    data['ltc'] = this.ltc;
    data['usdc'] = this.usdc;
    data['doge'] = this.doge;
    data['dai'] = this.dai;

    if (this.others != null) {
      data['others'] = this.others.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Others {
  String name;
  int rate;
  String trackid;

  Others({this.name, this.rate, this.trackid});

  Others.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    rate = json['rate'];
    trackid = json['trackid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['rate'] = this.rate;
    data['trackid'] = this.trackid;
    return data;
  }
}