class UserReferalModel {
  bool status;
  String msg;
  int total;
  int totalpaid;
  List<Users> users;

  UserReferalModel(
      {this.status, this.msg, this.total, this.totalpaid, this.users});

  UserReferalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    total = json['total'];
    totalpaid = json['totalpaid'];
    if (json['users'] != null) {
      users = new List<Users>();
      json['users'].forEach((v) {
        users.add(new Users.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    data['total'] = this.total;
    data['totalpaid'] = this.totalpaid;
    if (this.users != null) {
      data['users'] = this.users.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Users {
  int id;
  String name;
  String username;
  int paid;
  int amtpaid;

  Users({this.id, this.name, this.username, this.paid, this.amtpaid});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    paid = json['paid'];
    amtpaid = json['amtpaid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['paid'] = this.paid;
    data['amtpaid'] = this.amtpaid;
    return data;
  }
}