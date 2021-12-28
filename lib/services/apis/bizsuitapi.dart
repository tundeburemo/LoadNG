import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loadng/model/MessageModel.dart';
import 'package:loadng/model/bizsuit/userwalletlist.dart';
import 'package:loadng/services/baseapi/bizsuit.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/baseurl.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:loadng/locator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';




var url = locator<BaseUrl>();
var custom = locator<CustomFunction>();

class BizSuitApi extends BizSuitBaseApi {

//   @override
Future<UserBizSuitWalletList> userwalletlist() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.bizsuituserwalletlist, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
       UserBizSuitWalletList resultdata = UserBizSuitWalletList.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }


  //   @override
Future<ResponseMessage> userupdatewallet({name,category,bankselectedid,wallid}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['name'] =name.toString();
    map['category'] = category.toString();
    map['bankselectedid'] = bankselectedid.toString();
    map['wallid'] = wallid.toString();

    try {
      var response = await http
          .post(url.bizsuitupdatewallet, body: map)
          .timeout(Duration(seconds: 13));
          print(response.body);
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
Future<ResponseMessage> userupdatemainwallet({bankselectedid}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['bankselectedid'] = bankselectedid.toString();

    try {
      var response = await http
          .post(url.bizsuitupdatemainwallet, body: map)
          .timeout(Duration(seconds: 13));
          print(response.body);
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
Future<ResponseMessage> useraddwallet({name,category,wallets,newbankornot,bankselectedid,accbank,accno,accname}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['name'] =name.toString();
    map['category'] = category.toString();
    map['wallets'] = wallets.toString();
    map['newbankornot'] = newbankornot.toString();;
    map['bankselectedid'] = bankselectedid.toString();
    map['accbank'] = accbank.toString();
    map['accno'] = accno.toString();
    map['accname'] = accname.toString();
    try {
      var response = await http.post(url.bizsuitaddwalet, body: map).timeout(Duration(seconds: 13));
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