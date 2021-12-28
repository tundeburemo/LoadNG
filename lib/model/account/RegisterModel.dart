class UserRegisterModel {
  bool status;
  int id;
  String email;
  String username;
  String fullname;
  int walletbal;
  String refillbal;
  String billbal;
  String coins;
  String phoneno;
  String referby;
  String usertype;
  String userlevel;
  int providusaccno;
  String mainaccno;
  String mainaccname;
  String mainaccbankname;
  int activatepin;
  String datejoined;
  int userstarcount;
  String msg;

  UserRegisterModel(
      {this.status,
      this.id,
      this.email,
      this.username,
      this.fullname,
      this.walletbal,
      this.refillbal,
      this.billbal,
      this.coins,
      this.phoneno,
      this.referby,
      this.usertype,
      this.userlevel,
      this.providusaccno,
      this.mainaccno,
      this.mainaccname,
      this.mainaccbankname,
      this.activatepin,
      this.datejoined,
      this.userstarcount,
      this.msg});

  UserRegisterModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    id = json['id'];
    email = json['email'];
    username = json['username'];
    fullname = json['fullname'];
    walletbal = json['walletbal'];
    refillbal = json['refillbal'];
    billbal = json['billbal'];
    coins = json['coins'];
    phoneno = json['phoneno'];
    referby = json['referby'];
    usertype = json['usertype'];
    userlevel = json['userlevel'];
    providusaccno = json['providusaccno'];
    mainaccno = json['mainaccno'];
    mainaccname = json['mainaccname'];
    mainaccbankname = json['mainaccbankname'];
    activatepin = json['activatepin'];
    datejoined = json['datejoined'];
    userstarcount = json['userstarcount'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['fullname'] = this.fullname;
    data['walletbal'] = this.walletbal;
    data['refillbal'] = this.refillbal;
    data['billbal'] = this.billbal;
    data['coins'] = this.coins;
    data['phoneno'] = this.phoneno;
    data['referby'] = this.referby;
    data['usertype'] = this.usertype;
    data['userlevel'] = this.userlevel;
    data['providusaccno'] = this.providusaccno;
    data['mainaccno'] = this.mainaccno;
    data['mainaccname'] = this.mainaccname;
    data['mainaccbankname'] = this.mainaccbankname;
    data['activatepin'] = this.activatepin;
    data['datejoined'] = this.datejoined;
    data['userstarcount'] = this.userstarcount;
    data['msg'] = this.msg;
    return data;
  }
}
