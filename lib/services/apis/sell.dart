import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loadng/services/baseapi/sellbaseapi.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/baseurl.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:loadng/locator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/model/sell/Walletsell.dart';
import 'package:loadng/model/sell/PmSell.dart';
import 'package:loadng/model/sell/PaxfulSell.dart';
import 'package:loadng/model/sell/NewcoinSell.dart';
import 'package:loadng/model/sell/biz2walletlist.dart';

var url = locator<BaseUrl>();
var custom = locator<CustomFunction>();

class SellApi extends SellBaseApi {

//   @override
Future<PaxfulSellModel> sellpaxful({amountselling,bankid}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['amountselling'] = amountselling;
    map['bankid'] = bankid.toString();

    try {
      var response = await http
          .post(url.sellpaxful, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        PaxfulSellModel resultdata = PaxfulSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<PmSellModel> sellpm({amountselling,bankid}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['amountselling'] = amountselling;
    map['bankid'] = bankid.toString();

    try {
      var response = await http 
          .post(url.sellpm, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        PmSellModel resultdata = PmSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<NewCoinSellModel> sellnewcoins({amountsent,bankid,hash,image,imgname,cointrackid}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['amountsent'] = amountsent.toString();
    map['bankid'] = bankid.toString();
    map['image'] = image;
    map['hash'] = hash;
    map['imgname'] = imgname;
    map['cointrackid'] = cointrackid;


    try {
      var response = await http
          .post(url.sellnewcoins, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        NewCoinSellModel resultdata = NewCoinSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<WalletSellModel> sellbch() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();


    try {
      var response = await http
          .post(url.sellbch, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        WalletSellModel resultdata = WalletSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<WalletSellModel> selleth() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();


    try {
      var response = await http
          .post(url.selleth, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        WalletSellModel resultdata = WalletSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  //   @override
Future<WalletSellModel> selldai() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();


    try {
      var response = await http
          .post(url.selldai, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        WalletSellModel resultdata = WalletSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }


  //   @override
Future<WalletSellModel> selldoge() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();


    try {
      var response = await http
          .post(url.selldoge, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        WalletSellModel resultdata = WalletSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<WalletSellModel> sellltc() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();


    try {
      var response = await http
          .post(url.sellltc, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        WalletSellModel resultdata = WalletSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<WalletSellModel> sellunibc() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();


    try {
      var response = await http
          .post(url.sellunibc, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        WalletSellModel resultdata = WalletSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<WalletSellModel> sellusdc() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();


    try {
      var response = await http
          .post(url.sellusdc, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        WalletSellModel resultdata = WalletSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<WalletSellModel> sellblockc() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();


    try {
      var response = await http
          .post(url.sellbc, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        WalletSellModel resultdata = WalletSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }


//   @override
Future<WalletSellModel> sellbiz({cointype}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['trackid'] = cointype.toString();

    try {
      var response = await http
          .post(url.sellbiz, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        WalletSellModel resultdata = WalletSellModel.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
 
//   @override
Future<Biz2walletList> sellbiz2({cointype}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['trackid'] = cointype.toString();

    try {
      var response = await http
          .post(url.biz2sellcoin, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        Biz2walletList resultdata = Biz2walletList.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }




}