import 'package:loadng/model/MessageModel.dart';
import 'package:loadng/model/bizsuit/userwalletlist.dart';

abstract class BizSuitBaseApi {
Future<UserBizSuitWalletList> userwalletlist();//adduserid
Future<ResponseMessage> userupdatewallet({name,category,bankselectedid,wallid});//adduserid
Future<ResponseMessage> useraddwallet({name,category,wallets,newbankornot,bankselectedid,accbank,accno,accname});//adduserid
Future<ResponseMessage> userupdatemainwallet({bankselectedid});

}
