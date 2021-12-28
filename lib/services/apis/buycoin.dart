import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loadng/services/baseapi/buycoinbaseapi.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/baseurl.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/model/system/NewCoinsList.dart';
import 'package:loadng/model/MessageModel.dart';
import 'package:loadng/model/buycoin/savedaddress.dart';
import 'package:loadng/model/buycoin/prioritymodel.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';


var url = locator<BaseUrl>();
var custom = locator<CustomFunction>();

class BuyCoins extends BuyCoinBaseApi {
  //   @override
Future<NewCoinsList> allbuycoins() async {
    try {
      var response = await http
          .post(url.buycoinlist)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        NewCoinsList resultdata = NewCoinsList.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }



  //   @override
Future<ResponseMessage>  buycoin({prioritytrackid,cointrackid,amt,address}) async {
  final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['prioritytrackid'] = prioritytrackid.toString();
    map['cointrackid'] = cointrackid.toString();
    map['amt'] = amt.toString();
    map['address'] = address.toString();

    try {
      var response = await http.post(url.buycoin, body: map).timeout(Duration(seconds: 13));
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
Future<ResponseMessage> priorityfeecal({prioritytrackid,cointrackid,amt}) async {
   final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['prioritytrackid'] = prioritytrackid.toString();
    map['cointrackid'] = cointrackid.toString();
    map['amt'] = amt.toString();

    try {
      var response = await http.post(url.buycoinprioritycal, body: map).timeout(Duration(seconds: 13));
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
Future<ResponseMessage>  usersaveaddress({cointrackid,address}) async {
  final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['cointrackid'] = cointrackid.toString();
    map['address'] = address.toString();

    try {
      var response = await http.post(url.buycoinsaveaddress, body: map).timeout(Duration(seconds: 13));
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
Future<UserSavedAddress>  allusersavedaddress({cointrackid}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['cointrackid'] = cointrackid.toString();

    try {
      var response = await http.post(url.buycoinusersavedaddr, body: map).timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserSavedAddress resultdata = UserSavedAddress.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null; 
    }
  }
  //   @override
Future<BuyPriorityListModel> allprioritylist() async {
    try {
      var response = await http
          .post(url.buycoinpriority)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        BuyPriorityListModel resultdata = BuyPriorityListModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

}