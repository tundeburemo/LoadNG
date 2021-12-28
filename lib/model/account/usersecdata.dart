class UserSecData {
  bool status;
  String referallink;
  int buypoint;
  int sellpoint;
  int refpoint;
  int totalpoint;
  String maintotalpoints;

  UserSecData(
      {this.status,
      this.referallink,
      this.buypoint,
      this.sellpoint,
      this.refpoint,
      this.totalpoint,
      this.maintotalpoints});

  UserSecData.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    referallink = json['referallink'];
    buypoint = json['buypoint'];
    sellpoint = json['sellpoint'];
    refpoint = json['refpoint'];
    totalpoint = json['totalpoint'];
    maintotalpoints = json['maintotalpoints'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['referallink'] = this.referallink;
    data['buypoint'] = this.buypoint;
    data['sellpoint'] = this.sellpoint;
    data['refpoint'] = this.refpoint;
    data['totalpoint'] = this.totalpoint;
    data['maintotalpoints'] = this.maintotalpoints;
    return data;
  }
}