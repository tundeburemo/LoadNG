import 'package:loadng/model/MessageModel.dart';
import 'package:loadng/model/account/Loginmodel.dart';
import 'package:loadng/model/account/RegisterModel.dart';
import 'package:loadng/model/account/UserstatisticModel.dart';
import 'package:loadng/model/account/UserReferals.dart';
import 'package:loadng/model/account/UserNotifications.dart';
import 'package:loadng/model/account/userkycdetails.dart';
import 'package:loadng/model/account/usersecdata.dart';



abstract class AccountBaseApi {
Future<UserLoginModel> loginApi({email,fcm,pass});
Future<UserRegisterModel> registerApi({uname,email,phoneno,referby,fcm,pass,accbank,accname,accno,bankcode});
Future<ResponseMessage> registerchecker({uname,email,phoneno});
Future<ResponseMessage> resetpasswordtoken({snum,email});
Future<ResponseMessage> resetpassword({snum,token,pass,cpass});
Future<UserLoginModel> userfulldetails();
Future<UserstatisticModel> userstatistics();
Future<UserReferalModel> userreferals();//adduserid
Future<ResponseMessage> useractivatedeactivatepin();
Future<ResponseMessage> userupdateprofile({name,phoneno,bankid});//adduserid
Future<ResponseMessage> userchangepin({pin,pass});//adduserid
Future<ResponseMessage> userchangepass({pass,oldpass});//adduserid
Future<ResponseMessage> userverifypin({pin});//adduserid
Future<UserNotifications> usernotification();
Future<ResponseMessage> useraddkyc({bvn,facebook,twitter,insta,telegram,email,country,state,address,biztype,regtype,passimage,passimgname,regimage,regimgname,hregimage,hregimgname,bizccimage,bizccimgname,accbank,accno,lname,fname,phoneno,dob});
Future<KycDetails> userkycdetails();
Future<UserSecData> usersecdetails();
Future<ResponseMessage> userwithdrawcoin();
}
