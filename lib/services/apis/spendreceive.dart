import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loadng/services/baseapi/spendreceivebaseapi.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/baseurl.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:loadng/locator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/model/sendreceive/spendreceiveproducts.dart';
import 'package:loadng/model/sendreceive/userwalletlist.dart';
import 'package:loadng/model/MessageModel.dart';


var url = locator<BaseUrl>();
var custom = locator<CustomFunction>();

class SpendReceiveApi extends SpendReceiveBaseApi {

//   @override
Future<ResponseMessage> srfeecalculator({trackid,addresstosendto,feetosend}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['trackid'] = trackid.toString();
    map['addresstosendto'] = addresstosendto.toString();
    map['feetosend'] = feetosend;

    try {
      var response = await http
          .post(url.feecalculator, body: map)
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
Future<ResponseMessage> usersendcoin({trackid,addresstosendto,feetosend,useraddress,password}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['trackid'] = trackid.toString();
    map['addresstosendto'] = addresstosendto.toString();
    map['feetosend'] = feetosend;
    map['useraddress'] = useraddress;
    map['password'] = password;

    try {
      var response = await http
          .post(url.usersendcoin, body: map)
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
Future<UserwalletList> usersrwallets() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.userwalletlist, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
      UserwalletList resultdata = UserwalletList.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null; 
    }
  }

  //   @override
Future<AllSpendReceiveProducts> allsrcoins() async {
    try {
      var response = await http
          .post(url.allsrcoinlist)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        AllSpendReceiveProducts resultdata = AllSpendReceiveProducts.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null; 
    }
  }



//   @override
Future<ResponseMessage> useraddsrwallet({trackid}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['trackid'] = trackid.toString();

    try {
      var response = await http
          .post(url.useraddwallet, body: map)
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
Future<ResponseMessage> usersellcoin({trackid,amt}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['trackid'] = trackid.toString();
    map['amt'] = amt.toString();

    try {
      var response = await http.post(url.usersellcoin, body: map)
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