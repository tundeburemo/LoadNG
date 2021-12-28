class UserBankTransList {
  bool status;
  String msg;
  List<Banks> banks;

  UserBankTransList({this.status, this.msg, this.banks});

  UserBankTransList.fromJson(Map<String, dynamic> json) {
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
  String systemname;
  int bankid;
  String bankname;
  String bankaccno;
  String accname;

  Banks(
      {this.systemname,
      this.bankid,
      this.bankname,
      this.bankaccno,
      this.accname});

  Banks.fromJson(Map<String, dynamic> json) {
    systemname = json['systemname'];
    bankid = json['bankid'];
    bankname = json['bankname'];
    bankaccno = json['bankaccno'];
    accname = json['accname'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['systemname'] = this.systemname;
    data['bankid'] = this.bankid;
    data['bankname'] = this.bankname;
    data['bankaccno'] = this.bankaccno;
    data['accname'] = this.accname;
    return data;
  }
}