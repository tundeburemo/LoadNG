class PsBankList {
  bool status;
  String msg;
  List<Banks> banks;

  PsBankList({this.status, this.msg, this.banks});

  PsBankList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['banks'] != null) {
      banks = new List<Banks>();
      json['banks'].forEach((v) {
        banks.add(new Banks.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.banks != null) {
      data['banks'] = this.banks.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Banks {
  String bankcode;
  String bankname;

  Banks({this.bankcode, this.bankname});

  Banks.fromJson(Map<String, dynamic> json) {
    bankcode = json['bankcode'];
    bankname = json['bankname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankcode'] = this.bankcode;
    data['bankname'] = this.bankname;
    return data;
  }
}