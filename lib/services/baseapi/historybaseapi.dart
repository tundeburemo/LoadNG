import 'package:loadng/model/history/RecentHistory.dart';
import 'package:loadng/model/history/AllSellHistory.dart';
import 'package:loadng/model/history/pointhistory.dart';


abstract class HistoryBaseApi {
Future<UserAllSellHistory> allsellhistory({pg,search});//adduserid
Future<UserAllSellHistory> allblockchistory({pg,search});//adduserid
Future<UserAllSellHistory> allpaxfulhistory({pg,search});//adduserid
Future<UserAllSellHistory> allpmhistory({pg,search});//adduserid
Future<UserAllSellHistory> allnewcoinshistory({pg,search});//adduserid
Future<UserAllSellHistory> alluniversalhistory({pg,search});//adduserid
Future<UserAllSellHistory> allbizhistory({pg,search});//adduserid
Future<UserAllSellHistory> allsrhistory({pg,search});//adduserid
Future<UserAllSellHistory> allbuycoinhistory({pg,search});//adduserid
Future<UserAllSellHistory> allwithdrawalhistory({pg,search});//adduserid
Future<PointHistory> pointhistory();//adduserid
Future<RecentHistory> allrecenthistory();//adduserid

}
