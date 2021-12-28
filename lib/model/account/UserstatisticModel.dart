class UserstatisticModel {
  bool status;
  dynamic totalblockchaintrans;
  dynamic totalpaxfultrans;
  dynamic totalpmtrans;
  dynamic totalsuccsellpax;
  String totalsuccsellnairapax;
  String totalsuccsellusdpax;
  String totalsuccsellbc;
  dynamic totalsuccsellnairabc;
  dynamic totalsuccsellusdbc;
  dynamic totalsuccselleth;
  dynamic totalsuccsellnairaeth;
  dynamic totalsuccsellusdeth;
  dynamic totalsuccsellusdc;
  dynamic totalsuccsellnairusdc;
  dynamic totalsuccsellusdusdc;
  dynamic totalsuccsellltc;
  dynamic totalsuccsellnairaltc;
  dynamic totalsuccsellusdltc;
  dynamic totalsuccsellbch;
  dynamic totalsuccsellnairabch;
  dynamic totalsuccsellusdbch;
  dynamic totalsuccselluni;
  dynamic totalsuccsellnairauni;
  double totalsuccsellusduni;
  dynamic totalsuccsellpm;
  dynamic totalsuccsellnairapm;
  dynamic totalsuccsellusdpm;
  dynamic totalsuccsellall;
  dynamic totalsuccsellnairaall;
  double totalsuccsellusdall;
  List<Totalsuccbuyalljoin> totalsuccbuyalljoin;
  dynamic totalsuccbuyall;
  dynamic totalsuccbuynairaall;
  double totalsuccbuyusdall;
  List<Totalsuccgiftcalljoin> totalsuccgiftcalljoin;
  dynamic totalsuccgiftcall;
  dynamic totalsuccgiftcnairaall;
  dynamic totalsuccgiftcusdall;
  List<Totalsuccbizalljoin> totalsuccbizalljoin;
  dynamic totalsuccbizall;
  dynamic totalsuccbiznairaall;
  dynamic totalsuccbizusdall;
  String usercategory;
  String userlevel;
  String userstarcount;
  String msg;

  UserstatisticModel(
      {this.status,
      this.totalblockchaintrans,
      this.totalpaxfultrans,
      this.totalpmtrans,
      this.totalsuccsellpax,
      this.totalsuccsellnairapax,
      this.totalsuccsellusdpax,
      this.totalsuccsellbc,
      this.totalsuccsellnairabc,
      this.totalsuccsellusdbc,
      this.totalsuccselleth,
      this.totalsuccsellnairaeth,
      this.totalsuccsellusdeth,
      this.totalsuccsellusdc,
      this.totalsuccsellnairusdc,
      this.totalsuccsellusdusdc,
      this.totalsuccsellltc,
      this.totalsuccsellnairaltc,
      this.totalsuccsellusdltc,
      this.totalsuccsellbch,
      this.totalsuccsellnairabch,
      this.totalsuccsellusdbch,
      this.totalsuccselluni,
      this.totalsuccsellnairauni,
      this.totalsuccsellusduni,
      this.totalsuccsellpm,
      this.totalsuccsellnairapm,
      this.totalsuccsellusdpm,
      this.totalsuccsellall,
      this.totalsuccsellnairaall,
      this.totalsuccsellusdall,
      this.totalsuccbuyalljoin,
      this.totalsuccbuyall,
      this.totalsuccbuynairaall,
      this.totalsuccbuyusdall,
      this.totalsuccgiftcalljoin,
      this.totalsuccgiftcall,
      this.totalsuccgiftcnairaall,
      this.totalsuccgiftcusdall,
      this.totalsuccbizalljoin,
      this.totalsuccbizall,
      this.totalsuccbiznairaall,
      this.totalsuccbizusdall,
      this.usercategory,
      this.userlevel,
      this.userstarcount,
      this.msg});

  UserstatisticModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    totalblockchaintrans = json['totalblockchaintrans'];
    totalpaxfultrans = json['totalpaxfultrans'];
    totalpmtrans = json['totalpmtrans'];
    totalsuccsellpax = json['totalsuccsellpax'];
    totalsuccsellnairapax = json['totalsuccsellnairapax'];
    totalsuccsellusdpax = json['totalsuccsellusdpax'];
    totalsuccsellbc = json['totalsuccsellbc'];
    totalsuccsellnairabc = json['totalsuccsellnairabc'];
    totalsuccsellusdbc = json['totalsuccsellusdbc'];
    totalsuccselleth = json['totalsuccselleth'];
    totalsuccsellnairaeth = json['totalsuccsellnairaeth'];
    totalsuccsellusdeth = json['totalsuccsellusdeth'];
    totalsuccsellusdc = json['totalsuccsellusdc'];
    totalsuccsellnairusdc = json['totalsuccsellnairusdc'];
    totalsuccsellusdusdc = json['totalsuccsellusdusdc'];
    totalsuccsellltc = json['totalsuccsellltc'];
    totalsuccsellnairaltc = json['totalsuccsellnairaltc'];
    totalsuccsellusdltc = json['totalsuccsellusdltc'];
    totalsuccsellbch = json['totalsuccsellbch'];
    totalsuccsellnairabch = json['totalsuccsellnairabch'];
    totalsuccsellusdbch = json['totalsuccsellusdbch'];
    totalsuccselluni = json['totalsuccselluni'];
    totalsuccsellnairauni = json['totalsuccsellnairauni'];
    totalsuccsellusduni = json['totalsuccsellusduni'];
    totalsuccsellpm = json['totalsuccsellpm'];
    totalsuccsellnairapm = json['totalsuccsellnairapm'];
    totalsuccsellusdpm = json['totalsuccsellusdpm'];
    totalsuccsellall = json['totalsuccsellall'];
    totalsuccsellnairaall = json['totalsuccsellnairaall'];
    totalsuccsellusdall = json['totalsuccsellusdall'];
    if (json['totalsuccbuyalljoin'] != null) {
      totalsuccbuyalljoin = new List<Totalsuccbuyalljoin>();
      json['totalsuccbuyalljoin'].forEach((v) {
        totalsuccbuyalljoin.add(new Totalsuccbuyalljoin.fromJson(v));
      });
    }
    totalsuccbuyall = json['totalsuccbuyall'];
    totalsuccbuynairaall = json['totalsuccbuynairaall'];
    totalsuccbuyusdall = json['totalsuccbuyusdall'];
    if (json['totalsuccgiftcalljoin'] != null) {
      totalsuccgiftcalljoin = new List<Totalsuccgiftcalljoin>();
      json['totalsuccgiftcalljoin'].forEach((v) {
        totalsuccgiftcalljoin.add(new Totalsuccgiftcalljoin.fromJson(v));
      });
    }
    totalsuccgiftcall = json['totalsuccgiftcall'];
    totalsuccgiftcnairaall = json['totalsuccgiftcnairaall'];
    totalsuccgiftcusdall = json['totalsuccgiftcusdall'];
    if (json['totalsuccbizalljoin'] != null) {
      totalsuccbizalljoin = new List<Totalsuccbizalljoin>();
      json['totalsuccbizalljoin'].forEach((v) {
        totalsuccbizalljoin.add(new Totalsuccbizalljoin.fromJson(v));
      });
    }
    totalsuccbizall = json['totalsuccbizall'];
    totalsuccbiznairaall = json['totalsuccbiznairaall'];
    totalsuccbizusdall = json['totalsuccbizusdall'];
    usercategory = json['usercategory'];
    userlevel = json['userlevel'];
    userstarcount = json['userstarcount'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['totalblockchaintrans'] = this.totalblockchaintrans;
    data['totalpaxfultrans'] = this.totalpaxfultrans;
    data['totalpmtrans'] = this.totalpmtrans;
    data['totalsuccsellpax'] = this.totalsuccsellpax;
    data['totalsuccsellnairapax'] = this.totalsuccsellnairapax;
    data['totalsuccsellusdpax'] = this.totalsuccsellusdpax;
    data['totalsuccsellbc'] = this.totalsuccsellbc;
    data['totalsuccsellnairabc'] = this.totalsuccsellnairabc;
    data['totalsuccsellusdbc'] = this.totalsuccsellusdbc;
    data['totalsuccselleth'] = this.totalsuccselleth;
    data['totalsuccsellnairaeth'] = this.totalsuccsellnairaeth;
    data['totalsuccsellusdeth'] = this.totalsuccsellusdeth;
    data['totalsuccsellusdc'] = this.totalsuccsellusdc;
    data['totalsuccsellnairusdc'] = this.totalsuccsellnairusdc;
    data['totalsuccsellusdusdc'] = this.totalsuccsellusdusdc;
    data['totalsuccsellltc'] = this.totalsuccsellltc;
    data['totalsuccsellnairaltc'] = this.totalsuccsellnairaltc;
    data['totalsuccsellusdltc'] = this.totalsuccsellusdltc;
    data['totalsuccsellbch'] = this.totalsuccsellbch;
    data['totalsuccsellnairabch'] = this.totalsuccsellnairabch;
    data['totalsuccsellusdbch'] = this.totalsuccsellusdbch;
    data['totalsuccselluni'] = this.totalsuccselluni;
    data['totalsuccsellnairauni'] = this.totalsuccsellnairauni;
    data['totalsuccsellusduni'] = this.totalsuccsellusduni;
    data['totalsuccsellpm'] = this.totalsuccsellpm;
    data['totalsuccsellnairapm'] = this.totalsuccsellnairapm;
    data['totalsuccsellusdpm'] = this.totalsuccsellusdpm;
    data['totalsuccsellall'] = this.totalsuccsellall;
    data['totalsuccsellnairaall'] = this.totalsuccsellnairaall;
    data['totalsuccsellusdall'] = this.totalsuccsellusdall;
    if (this.totalsuccbuyalljoin != null) {
      data['totalsuccbuyalljoin'] =
          this.totalsuccbuyalljoin.map((v) => v.toJson()).toList();
    }
    data['totalsuccbuyall'] = this.totalsuccbuyall;
    data['totalsuccbuynairaall'] = this.totalsuccbuynairaall;
    data['totalsuccbuyusdall'] = this.totalsuccbuyusdall;
    if (this.totalsuccgiftcalljoin != null) {
      data['totalsuccgiftcalljoin'] =
          this.totalsuccgiftcalljoin.map((v) => v.toJson()).toList();
    }
    data['totalsuccgiftcall'] = this.totalsuccgiftcall;
    data['totalsuccgiftcnairaall'] = this.totalsuccgiftcnairaall;
    data['totalsuccgiftcusdall'] = this.totalsuccgiftcusdall;
    if (this.totalsuccbizalljoin != null) {
      data['totalsuccbizalljoin'] =
          this.totalsuccbizalljoin.map((v) => v.toJson()).toList();
    }
    data['totalsuccbizall'] = this.totalsuccbizall;
    data['totalsuccbiznairaall'] = this.totalsuccbiznairaall;
    data['totalsuccbizusdall'] = this.totalsuccbizusdall;
    data['usercategory'] = this.usercategory;
    data['userlevel'] = this.userlevel;
    data['userstarcount'] = this.userstarcount;
    data['msg'] = this.msg;
    return data;
  }
}

class Totalsuccbuyalljoin {
  String name;
  dynamic totalusd;
  dynamic totalnaira;

  Totalsuccbuyalljoin({this.name, this.totalusd, this.totalnaira});

  Totalsuccbuyalljoin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalusd = json['totalusd'];
    totalnaira = json['totalnaira'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['totalusd'] = this.totalusd;
    data['totalnaira'] = this.totalnaira;
    return data;
  }
}

class Totalsuccgiftcalljoin {
  String name;
  String totalsuccesstrans;
  String totalusd;
  String totalnaira;

  Totalsuccgiftcalljoin(
      {this.name, this.totalsuccesstrans, this.totalusd, this.totalnaira});

  Totalsuccgiftcalljoin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalsuccesstrans = json['totalsuccesstrans'];
    totalusd = json['totalusd'];
    totalnaira = json['totalnaira'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['totalsuccesstrans'] = this.totalsuccesstrans;
    data['totalusd'] = this.totalusd;
    data['totalnaira'] = this.totalnaira;
    return data;
  }
}

class Totalsuccbizalljoin {
  String name;
  String totalsuccesstrans;
 dynamic totalusd;
 dynamic totalnaira;

  Totalsuccbizalljoin(
      {this.name, this.totalsuccesstrans, this.totalusd, this.totalnaira});

  Totalsuccbizalljoin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    totalsuccesstrans = json['totalsuccesstrans'];
    totalusd = json['totalusd'];
    totalnaira = json['totalnaira'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['totalsuccesstrans'] = this.totalsuccesstrans;
    data['totalusd'] = this.totalusd;
    data['totalnaira'] = this.totalnaira;
    return data;
  }
}