import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loadng/services/baseapi/systembaseapi.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/baseurl.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/model/system/AllSellrate.dart';
import 'package:loadng/model/system/AllSellLiverate.dart';
import 'package:loadng/model/system/NewCoinsList.dart';
import 'package:loadng/model/MessageModel.dart';
import 'package:loadng/model/system/biz2coinlist.dart';
import 'package:nb_utils/nb_utils.dart';


var url = locator<BaseUrl>();
var custom = locator<CustomFunction>();

class SystemApi extends SystemBaseApi {
  //   @override
Future<AllRates> allsellrate() async {
    try {
      var response = await http
          .post(url.getallsellrate)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        AllRates resultdata = AllRates.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  } 

  //   @override
Future<AllLiveRates> allliverate() async {
    try {
      var response = await http
          .post(url.getallliverate)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        AllLiveRates resultdata = AllLiveRates.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }
    } catch (err) {
      return null;
    }
  }
 
  //   @override
Future<NewCoinsList> newcoinslist() async {
    try {
      var response = await http
          .post(url.getnewcoinslist)
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
 

 Future<LatestCoinList> biz2coinslist() async {
    try {
      var response = await http
          .post(url.biz2coinlist)
          .timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      if (convert.toString().isNotEmpty && convert.toString() != null) {
        LatestCoinList resultdata = LatestCoinList.fromJson(convert);
        return resultdata;
      } else {
        return null;
      }  
    } catch (err) {
      return null;
    }
  } 

  //   @override
  Future<NewCoinsList> bizcoinslist() async {
    try {
      var response = await http
          .post(url.getbizcoinslist)
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
Future<ResponseMessage> checkappnewversion({version,phonetype}) async {
      var map = Map<String, dynamic>();
    map['version'] = version.toString();
    map['phonetype'] = phonetype.toString();

    try {
      var response = await http.post(url.newappversion, body: map).timeout(Duration(seconds: 13));
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
Future<ResponseMessage> checkmaintanance() async {
    try {
      var response = await http.post(url.maintanance).timeout(Duration(seconds: 13));
      var convert = json.decode(response.body);
      log(response.body);
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

Future<ResponseMessage> checkactivepax() async {
    try {
      var response = await http.post(url.activepax).timeout(Duration(seconds: 13));
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