class UserNotifications {
  bool status;
  String msg;
  List<Notifications> notifications;

  UserNotifications({this.status, this.msg, this.notifications});

  UserNotifications.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    msg = json['msg'];
    if (json['notifications'] != null) {
      notifications = new List<Notifications>();
      json['notifications'].forEach((v) {
        notifications.add(new Notifications.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['msg'] = this.msg;
    if (this.notifications != null) {
      data['notifications'] =
          this.notifications.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Notifications {
  int id;
  String message;
  String time;
  int status;

  Notifications({this.id, this.message, this.time, this.status});

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    time = json['time'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['time'] = this.time;
    data['status'] = this.status;
    return data;
  }
}