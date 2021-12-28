import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loadng/services/baseapi/accountbaseapi.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/baseurl.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/model/MessageModel.dart';
import 'package:loadng/model/account/Loginmodel.dart';
import 'package:loadng/model/account/RegisterModel.dart';
import 'package:loadng/model/account/UserstatisticModel.dart';
import 'package:loadng/model/account/UserReferals.dart';
import 'package:loadng/model/account/UserNotifications.dart';
import 'package:loadng/model/account/userkycdetails.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/model/account/usersecdata.dart';


var url = locator<BaseUrl>();
var custom = locator<CustomFunction>();

class AccountApi extends AccountBaseApi {
//   @override
  Future<UserRegisterModel> registerApi(
      {uname, email, phoneno, referby, fcm, pass,accbank,accname,accno,bankcode}) async {
    var map = Map<String, dynamic>();
    map['uname'] = uname;
    map['email'] = email;
    map['phoneno'] = phoneno;
    map['pass'] = pass;
    map['referby'] = referby;
    map['fcm'] = fcm; 
    map['accbank'] = accbank; 
    map['accname'] = accname; 
    map['accno'] = accno; 
    map['bankcode'] = bankcode; 
    

    try {
      var response = await http
          .post(url.register, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserRegisterModel register = UserRegisterModel.fromJson(convert);
        custom.saveStaticInfo(mail: email, userid: register.id);
        return register;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<UserLoginModel> loginApi({email, fcm, pass}) async {
    var map = Map<String, dynamic>();
    map['email'] = email;
    map['fcm'] = fcm;
    map['pass'] = pass;

    try {
      var response =
          await http.post(url.login, body: map).timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserLoginModel resultdata = UserLoginModel.fromJson(convert);
        custom.saveStaticInfo(mail: email, userid: resultdata.id);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<ResponseMessage> registerchecker({uname, email, phoneno}) async {
    var map = Map<String, dynamic>();
    map['email'] = email;
    map['phoneno'] = phoneno;
    map['uname'] = uname;
    try {
      var response = await http
          .post(url.registerchecker, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<ResponseMessage> resetpasswordtoken({snum, email}) async {
    var map = Map<String, dynamic>();
    map['snum'] = snum;
    map['email'] = email;
    try {
      var response = await http
          .post(url.getresettoken, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<ResponseMessage> resetpassword({snum, token, pass, cpass}) async {
    var map = Map<String, dynamic>();
    map['snum'] = snum;
    map['token'] = token;
    map['pass'] = pass;
    map['cpass'] = cpass;

    try {
      var response = await http
          .post(url.resetpassword, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<UserLoginModel> userfulldetails() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.userdetails, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserLoginModel resultdata = UserLoginModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  //   @override
   Future<UserSecData> usersecdetails() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.usersecdetails, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
       UserSecData resultdata = UserSecData.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
    //   @override
Future<ResponseMessage> userwithdrawcoin() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.userwithdrawcoin, body: map)
          .timeout(Duration(seconds: 20));
      var convert = json.decode(response.body);
      print(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
    ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<UserstatisticModel> userstatistics() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.userstatistic, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserstatisticModel resultdata = UserstatisticModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<UserReferalModel> userreferals() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    String refcode = settings.dusername.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['refcode'] = refcode.toString();

    try {
      var response = await http
          .post(url.userreferals, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserReferalModel resultdata = UserReferalModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<ResponseMessage> useractivatedeactivatepin() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.useractivatedeactipin, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<ResponseMessage> userupdateprofile({name, phoneno, bankid}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['name'] = name;
    map['phoneno'] = phoneno;
    map['bankid'] = bankid.toString();

    try {
      var response = await http
          .post(url.userupdateprofile, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<ResponseMessage> userchangepin({pin, pass}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pin'] = pin;
    map['pass'] = pass;

    try {
      var response = await http
          .post(url.userchangepin, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<ResponseMessage> userchangepass({pass, oldpass}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['oldpass'] = oldpass;
    map['pass'] = pass;

    try {
      var response = await http
          .post(url.userchangepassword, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<ResponseMessage> userverifypin({pin}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pin'] = pin.toString();
    try {
      var response = await http
          .post(url.userpinverify, body: map)
          .timeout(Duration(seconds: 13));

      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
  Future<UserNotifications> usernotification() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    try {
      var response = await http
          .post(url.usernotifications, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserNotifications resultdata = UserNotifications.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  //   @override
  Future<KycDetails> userkycdetails() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.userkycdetails, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        KycDetails resultdata = KycDetails.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  Future<ResponseMessage> useraddkyc(
      {bvn,
      facebook,
      twitter,
      insta,
      telegram,
      email,
      country,
      state,
      address,
      biztype,
      regtype,
      passimage,
      passimgname,
      regimage,
      regimgname,
      hregimage,
      hregimgname,
      bizccimage,
      bizccimgname,accbank,accno,lname,fname,phoneno,dob}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['bvn'] = bvn.toString();
    map['facebook'] = facebook.toString();
    map['twitter'] = twitter.toString();
    map['insta'] = insta.toString();
    map['telegram'] = telegram.toString();
    map['email'] = email.toString();
    map['country'] = country.toString();
    map['state'] = state.toString();
    map['address'] = address.toString();
    map['biztype'] = biztype.toString();
    map['regtype'] = regtype.toString();
    map['passimage'] = passimage.toString();
    map['passimgname'] = passimgname.toString();
    map['regimage'] = regimage.toString();
    map['regimgname'] = regimgname.toString();
    map['hregimage'] = hregimage.toString();
    map['hregimgname'] = hregimgname.toString();
    map['bizccimage'] = bizccimage.toString();
    map['accbank'] = accbank.toString();
    map['accno'] = accno.toString();
    map['lname'] = lname.toString();
    map['fname'] = fname.toString();
    map['phoneno'] = phoneno.toString();
    map['dob'] = dob.toString();

    try {
      var response = await http
          .post(url.useraddkyc, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        ResponseMessage resultdata = ResponseMessage.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
}
