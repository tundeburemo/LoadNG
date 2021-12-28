import 'package:loadng/model/sendreceive/spendreceiveproducts.dart';
import 'package:loadng/model/sendreceive/userwalletlist.dart';
import 'package:loadng/model/MessageModel.dart';


abstract class SpendReceiveBaseApi {
Future<UserwalletList> usersrwallets();//userid
Future<AllSpendReceiveProducts> allsrcoins();//nothing
Future<ResponseMessage> useraddsrwallet({trackid});//userid
Future<ResponseMessage> srfeecalculator({trackid,addresstosendto,feetosend});//userid
Future<ResponseMessage> usersendcoin({trackid,addresstosendto,feetosend,useraddress,password});//userid
Future<ResponseMessage> usersellcoin({trackid,amt});//userid

}
 