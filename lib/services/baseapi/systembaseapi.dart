import 'package:loadng/model/system/AllSellrate.dart';
import 'package:loadng/model/system/AllSellLiverate.dart';
import 'package:loadng/model/system/NewCoinsList.dart';
import 'package:loadng/model/system/biz2coinlist.dart';
import 'package:loadng/model/MessageModel.dart';


abstract class SystemBaseApi {
Future<AllRates> allsellrate();//nothing
Future<AllLiveRates> allliverate();//nothing
Future<NewCoinsList> newcoinslist();//nothing
Future<ResponseMessage> checkappnewversion({version,phonetype});//nothing
Future<ResponseMessage> checkactivepax();
 Future<LatestCoinList> biz2coinslist();
 Future<ResponseMessage> checkmaintanance();

}
