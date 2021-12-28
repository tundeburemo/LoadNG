import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/styles/AppTextStyle.dart';
import 'package:loadng/styles/AppImage.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'dart:io';
import 'package:loadng/services/apis/account.dart';
import 'package:loadng/services/apis/bank.dart';



var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
var bankapi = locator<BankApi>();

// ignore: must_be_immutable
class RegisterBank extends StatefulWidget {
 final RouteArgument routeArgument;
 String sentphone='';
 String sentemail='';
 String sentusername='';
  static String tag = '/RegisterBank'; 

  RegisterBank({Key key,@required this.routeArgument }) {
    sentphone= this.routeArgument.argumentsList[0] as String;
    sentemail=this.routeArgument.argumentsList[1] as String;
    sentusername=this.routeArgument.argumentsList[2] as String;
  }

  @override
  RegisterBankState createState() => RegisterBankState();
}
 

class RegisterBankState extends State<RegisterBank> {
      TextEditingController _uname;
  TextEditingController _accno, _accname;
  List<String> listOfCategory = ["Choose Bank Name"];
  String bankdropdownNames="Choose Bank Name";
@override
void initState() { 
    _uname= TextEditingController();
     _accno = TextEditingController();
    _accname = TextEditingController();
  getalldatas();
  super.initState();
  
}

getalldatas() async{
        await Future.delayed(Duration(seconds: 1));
    functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    if (theinternet && theinternet2) {
        // paytscak
      var getbanks2 = await bankapi.psbanklist();
       if(getbanks2!=null){
      var thetotal2 = getbanks2.banks.length;
      var j = 0;
    for (j = 0; j < thetotal2; j++) {
        if (!listOfCategory.contains(getbanks2.banks[j].bankname)) {
          if (mounted) {
            setState(() {
              listOfCategory.add(getbanks2.banks[j].bankname);
            });
          }
        }
      }
      Navigator.of(context).pop();
       }else{
               Navigator.of(context).pop();
      functionfile.showerror(context);
       }
    } else {
      Navigator.of(context).pop();
      functionfile.showerror(context);
    }
}
  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(AppColors.appWhite);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: height/0.8,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
             Image.asset(AppImage.appLogoblack, 
                  width: width / 2.5,
                  height: width / 3.0),
             AppTextStyle.text(AppTexts.welcometxt5, textColor: AppColors.realblack, fontFamily: AppFontSize.montbold, fontSize: 22.0),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, bottom: 12),
                child: AppTextStyle.text(AppTexts.welcomebnklongtxt,
                    textColor: AppColors.appSecondaryBackgroundColor,
                    fontFamily: AppFontSize.fontMedium,
                    fontSize: AppFontSize.textSizeMedium,
                    maxLine: 2,
                    isCentered: true),
              ),
              Container(
                margin: EdgeInsets.all(24),
                decoration: boxDecoration(
                    bgColor: AppColors.appWhite, showShadow: true, radius: 4),
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: AppColors.appTextColorPrimary, width: 0.5)),
                      child: Column(
                        children: <Widget>[
                      
               Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              onEditingComplete: (){
                                    FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              onTap: (){
                                    FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              controller: _accno,
                              keyboardType: TextInputType.text,
                              maxLength: 100,
                              style: TextStyle(
                                  fontSize: AppFontSize.textSizeLargeMedium,
                                  fontFamily: AppFontSize.fontRegular),
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 10, 16, 10),
                                hintText: AppTexts.theaccno,
                                hintStyle: TextStyle(color: AppColors.shadowdarkblack2,fontFamily: AppFontSize.montlight,fontWeight: FontWeight.w600,fontSize: AppFontSize.textSizeMedium),
                                border: InputBorder.none,
                              ),
                            ),


                          )
                        ],
                      ),
Divider(color:Colors.grey[300]),
                              Card(
                                  color: AppColors.t12_edittext_background,
                                  child: DropdownButton(
                                    isExpanded: true,
                                    // dropdownColor: AppColors.appColorPrimaryDarkLight,
                                    value: bankdropdownNames,
                                    style: boldTextStyle(),
                                    icon: Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColors.appColorPrimary,
                                    ),
                                    underline: 0.height,
                                    onChanged: (newValue) {
                                      setState(() {
                                        toast(newValue);
                                        bankdropdownNames = newValue;
                                      });

                                      getbankaccname(
                                          bankname: newValue,
                                          accno: _accno.text);
                                    },
                                    items: listOfCategory.map((category) {
                                      return DropdownMenuItem(
                                        child: Text(category,
                                                style: primaryTextStyle())
                                            .paddingLeft(8),
                                        value: category,
                                      );
                                    }).toList(),
                                  )).paddingTop(AppFontSize.spacing_standard),
Divider(color:Colors.grey[300]),

                                    Row(
                        children: <Widget>[
                          Expanded(
                            child: TextFormField(
                              controller: _accname,
                               onEditingComplete: (){
                                    FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              onTap: (){
                                    FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              },
                              keyboardType: TextInputType.text,
                              maxLength: 100,
                              readOnly: true,
                              style: TextStyle(
                                  fontSize: AppFontSize.textSizeSmall,
                                  fontFamily: AppFontSize.fontRegular,fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                counterText: "",
                                contentPadding:
                                    EdgeInsets.fromLTRB(16, 10, 16, 10),
                                hintText: AppTexts.theaccname,
                                hintStyle: TextStyle(color: AppColors.shadowdarkblack2,fontFamily: AppFontSize.montlight,fontWeight: FontWeight.w600,fontSize: AppFontSize.textSizeMedium),
                                border: InputBorder.none,
                              ),
                            ),


                          )
                        ],
                      ),
                  ])
                    ),
                    SizedBox(
                      height: 24,
                    ),
                   
                    GestureDetector(
                      onTap: () {
                        
         verifier(accbnk:bankdropdownNames,accname:_accname.text,accno:_accno.text);
             },
                      child: Container(
                        alignment: Alignment.center,    
                        height: width / 8,
                        child: AppTextStyle.text(AppTexts.signupcontinue,
                            textColor:AppColors.appWhite, isCentered: true),
                        decoration:
                           boxDecoration(bgColor:AppColors.appColorPrimary, radius: 8),
                      ),
                    ),
                  ],
                ),
              ),
              
                       Row( 
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                      text("Already Registered?", textColor: AppColors.black, fontSize: AppFontSize.textSizeLargeMedium, fontFamily: AppFontSize.montlight,isCentered: true),
                         GestureDetector(
                      onTap:(){
                          Navigator.of(context).pushNamed('/login');
                      },
                      child:
                       text(" Login Now!", textColor: AppColors.appColorPrimary, fontSize: AppFontSize.textSizeLargeMedium, fontFamily: AppFontSize.fontBold,isCentered: true)),
                  ])
                       
            ],
          ),
        ),
      ),
    );
  }


  

  @override
  void dispose() {
    _uname.clear();
        _accno.clear();
    _accname.clear();
    super.dispose();
  }

verifier({accbnk,accname,accno}) async {
  functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (accbnk.isEmpty) {
         Navigator.of(context).pop(); 
          toast('Please Select a bank name',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (accname.isEmpty) {
         Navigator.of(context).pop(); 
          toast('Please Select a bank name',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (accno.isEmpty) {
         Navigator.of(context).pop(); 
          toast('Please enter your account number',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {

                   var sendtbnkid = " ";
          var getbanks = await bankapi.psbanklist();
          var thetotal = getbanks.banks.length;
          var i = 0;
          for (i = 0; i < thetotal; i++) {
            if (getbanks.banks[i].bankname == accbnk) {
              sendtbnkid = getbanks.banks[i].bankcode;
              break;
            }
          }

     Navigator.of(context).pop(); 
            Navigator.of(context).pushNamed('/registerpassword',arguments: new RouteArgument(argumentsList: [widget.sentphone, widget.sentemail,widget.sentusername,accname,accno,sendtbnkid,accbnk]));  
        }
      } else {
     Navigator.of(context).pop(); 
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
      }
    } on SocketException catch (_) {
     Navigator.of(context).pop(); 
       toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
    }
  }

    getbankaccname({bankname, accno}) async {
    functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (bankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else if (accno.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter your account number',
              gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
        } else {
          var sendtbnkid = " ";
          var getbanks = await bankapi.psbanklist();
          var thetotal = getbanks.banks.length;
          var i = 0;
          for (i = 0; i < thetotal; i++) {
            if (getbanks.banks[i].bankname == bankname) {
              sendtbnkid = getbanks.banks[i].bankcode;
              break;
            }
          }

          var v = await bankapi
              .psbankname(bankcode: sendtbnkid, accno: accno)
              .timeout(Duration(seconds: 30), onTimeout: () {
            Navigator.of(context).pop();
            toast(AppTexts.nointerneterr,
                gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            return null;
          });

          if (v != null) {
            if (v.status == true) {
              Navigator.of(context).pop();
              toast("Bank name fetched Successfully",
                  gravity: ToastGravity.CENTER,
                  bgColor: AppColors.appDark_parrot_green);
              _accname.text = v.msg;
            } else {
              Navigator.of(context).pop();

              toast(v.msg,
                  gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
            }
          } else {
            Navigator.of(context).pop();

            toast(AppTexts.nointerneterr,
                gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
          }
        }
      } else {
        Navigator.of(context).pop();

        toast(AppTexts.nointerneterr,
            gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
      }
    } on SocketException catch (_) {
      Navigator.of(context).pop();

      toast(AppTexts.nointerneterr,
          gravity: ToastGravity.CENTER, bgColor: AppColors.appLightRed);
    }
  }
}
