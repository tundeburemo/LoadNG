import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loadng/services/baseapi/historybaseapi.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/baseurl.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:loadng/locator.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/model/history/RecentHistory.dart';
import 'package:loadng/model/history/AllSellHistory.dart';
import 'package:loadng/model/history/pointhistory.dart';


var url = locator<BaseUrl>();
var custom = locator<CustomFunction>();

class HistoryApi extends HistoryBaseApi {

//   @override
Future<UserAllSellHistory> allsellhistory({pg,search}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;

    try {
      var response = await http
          .post(url.allsellhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<UserAllSellHistory> allblockchistory({pg,search}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;

    try {
      var response = await http
          .post(url.allblockcsellhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<UserAllSellHistory> allbizhistory({pg,search}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;

    try {
      var response = await http
          .post(url.allbizhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  //   @override
Future<UserAllSellHistory> allsrhistory({pg,search}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;

    try {
      var response = await http
          .post(url.allsrhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<UserAllSellHistory> allpaxfulhistory({pg,search}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;

    try {
      var response = await http
          .post(url.allpaxfulsellhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  //   @override
Future<UserAllSellHistory> allbuycoinhistory({pg,search}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;

    try {
      var response = await http
          .post(url.allbuycoinhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
 
//   @override
Future<UserAllSellHistory> allpmhistory({pg,search}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;

    try {
      var response = await http
          .post(url.allpmsellhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<UserAllSellHistory> allnewcoinshistory({pg,search}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;

    try {
      var response = await http
          .post(url.allnewcoinssellhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<UserAllSellHistory> alluniversalhistory({pg,search}) async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;

    try {
      var response = await http
          .post(url.alluniversalsellhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

  //   @override
Future<UserAllSellHistory> allwithdrawalhistory({pg,search}) async {
     final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();
    map['pg'] = pg.toString();
    map['search'] = search;
    try {
      var response = await http.post(url.pointwithdrawhistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        UserAllSellHistory resultdata = UserAllSellHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }


  //   @override
Future<PointHistory> pointhistory() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>();
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.pointincomehistory, body: map)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
       PointHistory resultdata = PointHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }

//   @override
Future<RecentHistory> allrecenthistory() async {
    final preferences = await StreamingSharedPreferences.instance;
    final settings = MyAppSettings(preferences);
    int userid = settings.did.getValue();
    var map = Map<String, dynamic>(); 
    map['userid'] = userid.toString();

    try {
      var response = await http
          .post(url.allrecentsellhistory, body: map)
          .timeout(Duration(seconds: 25));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        RecentHistory resultdata = RecentHistory.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }



}