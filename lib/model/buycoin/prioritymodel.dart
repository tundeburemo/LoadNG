class BuyPriorityListModel {
  bool status;
  String msg;
  List<Priority> priority;

  BuyPriorityListModel({this.status, this.msg, this.priority});

  BuyPriorityListModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['priority'] != null) {
      priority = new List<Priority>();
      json['priority'].forEach((v) {
        priority.add(new Priority.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.priority != null) {
      data['priority'] = this.priority.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Priority {
  String name;
  int block;
  String trackid;

  Priority({this.name, this.block, this.trackid});

  Priority.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    block = json['block'];
    trackid = json['trackid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['block'] = this.block;
    data['trackid'] = this.trackid;
    return data;
  }
}