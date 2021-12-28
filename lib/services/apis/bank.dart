import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loadng/services/baseapi/bankbaseapi.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/baseurl.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/model/MessageModel.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/model/bank/PsBankList.dart';
import 'package:loadng/model/bank/UserBankListModel.dart';
import 'package:loadng/model/bank/UserBankTransList.dart';




var url = locator<BaseUrl>();
var custom = locator<CustomFunction>();

class BankApi extends BankBaseApi {

//   @override
 Future<ResponseMessage> useraddbank({accbank,accname,accno,bankcode,pass}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['accbank'] = accbank;
    map['accname'] = accname;
    map['accno'] = accno;
    map['bankcode'] = bankcode;
    map['pass'] = pass;

    try {
      var response = await http
          .post(url.addbank, body: map)
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
Future<UserBankList> userbanklist() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http.post(url.banklist, body: map).timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserBankList resultdata = UserBankList.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  //   @override
Future<UserBankTransList> userbanktranslist() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http.post(url.banktranslist, body: map).timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
       UserBankTransList resultdata = UserBankTransList.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
 
 

//   @override
Future<ResponseMessage> userdeletebank({bankid,accno}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['bankid'] = bankid.toString();
    map['accno'] = accno;


    try {
      var response = await http
          .post(url.deletbank, body: map)
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
Future<ResponseMessage> usersettransactionbank({paxfulbankid,unibankid,blockchainbankid,coinsbankid,pmbankid,giftcardbankid,pass}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['paxfulbankid'] = paxfulbankid;
    map['unibankid'] = unibankid;
    map['blockchainbankid'] = blockchainbankid;
    map['coinsbankid'] = coinsbankid;
    map['pmbankid'] = pmbankid;
    map['giftcardbankid'] = giftcardbankid;
    map['pass'] = pass;

    try {
      var response = await http
          .post(url.settrabsbank, body: map)
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
Future<PsBankList> psbanklist() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
 
    try {
      var response = await http
          .post(url.psbanklist, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        PsBankList resultdata = PsBankList.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }



//   @override
Future<ResponseMessage> psbankname({bankcode,accno}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['bankcode'] = bankcode;
    map['accno'] = accno;


    try {
      var response = await http
          .post(url.psaccname, body: map)
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