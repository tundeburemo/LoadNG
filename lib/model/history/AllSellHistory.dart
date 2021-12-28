class UserAllSellHistory {
  bool status;
  String msg;
  int total;
  List<History> history;
  dynamic currentpage;
  dynamic totalpage;

  UserAllSellHistory(
      {this.status,
      this.msg,
      this.total,
      this.history,
      this.currentpage,
      this.totalpage});

  UserAllSellHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    total = json['total'];
    if (json['history'] != null) {
      history = new List<History>();
      json['history'].forEach((v) {
        history.add(new History.fromJson(v));
      });
    }
    currentpage = json['currentpage'];
    totalpage = json['totalpage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['total'] = this.total;
    if (this.history != null) {
      data['history'] = this.history.map((v) => v.toJson()).toList();
    }
    data['currentpage'] = this.currentpage;
    data['totalpage'] = this.totalpage;
    return data;
  }
}

class History {
  String name;
  int id;
  dynamic ourrate;
  dynamic usdvalue;
  dynamic nairavalue;
  String orderid;
  dynamic statusnumber;
  String date;
  dynamic btcval;
  String payref;
  String paystatus;
  String statustext;
  String address;
  String hashlink;
  String hash;
  List<String> images;

  History(
      {this.name,
      this.id,
      this.ourrate,
      this.usdvalue,
      this.nairavalue,
      this.orderid,
      this.statusnumber,
      this.date,
      this.btcval,
      this.payref,
      this.paystatus,
      this.statustext,
      this.address,
      this.hashlink,
      this.hash,
      this.images});

  History.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    ourrate = json['ourrate'];
    usdvalue = json['usdvalue'];
    nairavalue = json['nairavalue'];
    orderid = json['orderid'];
    statusnumber = json['statusnumber'];
    date = json['date'];
    btcval = json['btcval'];
    payref = json['payref'];
    paystatus = json['paystatus'];
    statustext = json['statustext'];
    address = json['address'];
    hashlink = json['hashlink'];
    hash = json['hash'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['ourrate'] = this.ourrate;
    data['usdvalue'] = this.usdvalue;
    data['nairavalue'] = this.nairavalue;
    data['orderid'] = this.orderid;
    data['statusnumber'] = this.statusnumber;
    data['date'] = this.date;
    data['btcval'] = this.btcval;
    data['payref'] = this.payref;
    data['paystatus'] = this.paystatus;
    data['statustext'] = this.statustext;
    data['address'] = this.address;
    data['hashlink'] = this.hashlink;
    data['hash'] = this.hash;
    data['images'] = this.images;
    return data;
  }
}