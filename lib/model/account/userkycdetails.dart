class KycDetails {
  bool status;
  String bvn;
  String facebooklink;
  String twitterlink;
  String telegramlink;
  String instagramlink;
  String biztype;
  String regtype;
  String firstname;
  String lastname;
  String email; 
  String phoneno;
  String dob;
  String fulladdress;
  String state;
  String country;
  String submittedtime;
  String passport;
  String regulationimg;
  String holdregulationimg;
  String businesscc;
  String msg;

  KycDetails(
      {this.status,
      this.bvn,
      this.facebooklink,
      this.twitterlink,
      this.telegramlink,
      this.instagramlink,
      this.biztype,
      this.regtype,
      this.firstname,
      this.lastname,
      this.email,
      this.phoneno,
      this.dob,
      this.fulladdress,
      this.state,
      this.country,
      this.submittedtime,
      this.passport,
      this.regulationimg,
      this.holdregulationimg,
      this.businesscc,
      this.msg});

  KycDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    bvn = json['bvn'];
    facebooklink = json['facebooklink'];
    twitterlink = json['twitterlink'];
    telegramlink = json['telegramlink'];
    instagramlink = json['instagramlink'];
    biztype = json['biztype'];
    regtype = json['regtype'];
    firstname = json['firstname'];
    lastname = json['lastname'];
    email = json['email'];
    phoneno = json['phoneno'];
    dob = json['dob'];
    fulladdress = json['fulladdress'];
    state = json['state'];
    country = json['country'];
    submittedtime = json['submittedtime'];
    passport = json['passport'];
    regulationimg = json['regulationimg'];
    holdregulationimg = json['holdregulationimg'];
    businesscc = json['businesscc'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['bvn'] = this.bvn;
    data['facebooklink'] = this.facebooklink;
    data['twitterlink'] = this.twitterlink;
    data['telegramlink'] = this.telegramlink;
    data['instagramlink'] = this.instagramlink;
    data['biztype'] = this.biztype;
    data['regtype'] = this.regtype;
    data['firstname'] = this.firstname;
    data['lastname'] = this.lastname;
    data['email'] = this.email;
    data['phoneno'] = this.phoneno;
    data['dob'] = this.dob;
    data['fulladdress'] = this.fulladdress;
    data['state'] = this.state;
    data['country'] = this.country;
    data['submittedtime'] = this.submittedtime;
    data['passport'] = this.passport;
    data['regulationimg'] = this.regulationimg;
    data['holdregulationimg'] = this.holdregulationimg;
    data['businesscc'] = this.businesscc;
    data['msg'] = this.msg;
    return data;
  }
}