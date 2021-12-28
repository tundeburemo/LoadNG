import 'package:loadng/model/sell/Walletsell.dart';
import 'package:loadng/model/sell/PmSell.dart';
import 'package:loadng/model/sell/PaxfulSell.dart';
import 'package:loadng/model/sell/NewcoinSell.dart';


abstract class SellBaseApi {
Future<PaxfulSellModel> sellpaxful({amountselling,bankid});//add userid
Future<PmSellModel> sellpm({amountselling,bankid});//add userid
Future<NewCoinSellModel> sellnewcoins({amountsent,bankid,hash,image,imgname,cointrackid});//add userid
Future<WalletSellModel> sellbch();//add userid
Future<WalletSellModel> selleth();//add userid
Future<WalletSellModel> sellltc();//add userid
Future<WalletSellModel> selldai();//add userid
Future<WalletSellModel> sellunibc();//add userid
Future<WalletSellModel> sellusdc();//add userid
Future<WalletSellModel> sellblockc();//add userid
Future<WalletSellModel> sellbiz({cointype});//add userid










}
