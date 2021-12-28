class PointHistory {
  bool status;
  List<Data> data;

  PointHistory({this.status, this.data});

  PointHistory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String username;
  String actionstatus;
  String actiontxt;
  String date;
  String time;
  int tid;
  String amt;
  String cointype;

  Data(
      {this.username,
      this.actionstatus,
      this.actiontxt,
      this.date,
      this.time,
      this.tid,
      this.amt,
      this.cointype});

  Data.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    actionstatus = json['actionstatus'];
    actiontxt = json['actiontxt'];
    date = json['date'];
    time = json['time'];
    tid = json['tid'];
    amt = json['amt'];
    cointype = json['cointype'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['actionstatus'] = this.actionstatus;
    data['actiontxt'] = this.actiontxt;
    data['date'] = this.date;
    data['time'] = this.time;
    data['tid'] = this.tid;
    data['amt'] = this.amt;
    data['cointype'] = this.cointype;
    return data;
  }
}