import 'package:loadng/model/buycoin/savedaddress.dart';
import 'package:loadng/model/buycoin/prioritymodel.dart';
import 'package:loadng/model/system/NewCoinsList.dart';
import 'package:loadng/model/MessageModel.dart';


abstract class BuyCoinBaseApi {
Future<ResponseMessage> buycoin({prioritytrackid,cointrackid,amt,address});//userid
Future<NewCoinsList> allbuycoins();//nothing
Future<BuyPriorityListModel> allprioritylist();//nothing
Future<ResponseMessage> priorityfeecal({prioritytrackid,cointrackid,amt});//userid
Future<ResponseMessage> usersaveaddress({cointrackid,address});//userid
Future<UserSavedAddress> allusersavedaddress({cointrackid});//userid
}

