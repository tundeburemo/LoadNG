import 'package:loadng/model/MessageModel.dart';
import 'package:loadng/model/bank/PsBankList.dart';
import 'package:loadng/model/bank/UserBankListModel.dart';
import 'package:loadng/model/bank/UserBankTransList.dart';

abstract class BankBaseApi {
Future<ResponseMessage> useraddbank({accbank,accname,accno,bankcode,pass});//adduserid
Future<UserBankList> userbanklist();//adduserid
Future<UserBankTransList> userbanktranslist();//adduserid
Future<ResponseMessage> userdeletebank({bankid,accno});//adduserid
Future<ResponseMessage> usersettransactionbank({paxfulbankid,unibankid,blockchainbankid,coinsbankid,pmbankid,giftcardbankid,pass});//adduserid
Future<PsBankList> psbanklist();//adduserid
Future<ResponseMessage> psbankname({bankcode,accno});//adduserid

}
