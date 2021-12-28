import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadng/model/bank/UserBankListModel.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/apis/bank.dart';
import 'package:loadng/locator.dart';
import 'dart:io';
import 'package:loadng/styles/AppText.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/services/appSettings.dart';



var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
var bankapi = locator<BankApi>();


class MyBanks extends StatefulWidget {
  static String tag = '/mybanks';

  @override
  MyBanksState createState() => MyBanksState();
}

class MyBanksState extends State<MyBanks> {
    TextEditingController _accno,_accname,_pass;
  Future allbanklist;
  String bankdropdownNames,paxbankname,withdrawbankname,bcbnkname,gcbankname,unibankname,pmbankname;
  List<String> listOfCategory = [];
  var mymainacc=" ";
 var allbanks=<String>[];

@override
void initState() {  
  internetcheck();
    _accno = TextEditingController();
    _accname=TextEditingController();
    _pass =TextEditingController();
  super.initState();
  
}

          internetcheck() async{
      var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

      if (theinternet && theinternet2) {
         setState(() {
allbanklist=bankapi.userbanklist();
         });
userInfo();
      }else{
      functionfile.showerror(context);
      }
  }

  @override
  void dispose() {
    _accno.clear();
    _accname.clear();
    _pass.clear();
    super.dispose();
  }
  Future<void> userInfo() async {

   final prefs = await StreamingSharedPreferences.instance;
      var storeddetails = MyAppSettings(prefs);

      if (mounted) {
        setState(() {
          mymainacc = storeddetails.dmainaccno.getValue();
        });
      }

    
    // paytscak
var getbanks = await bankapi.psbanklist();
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
  if(!listOfCategory.contains(getbanks.banks[i].bankname)){
if(mounted){
      setState(() {
    listOfCategory.add(getbanks.banks[i].bankname);
  });
}
  }
} 

var getuserbanks = await bankapi.userbanklist();
if(getuserbanks!=null){
var thetotalubank = getuserbanks.banks.length;
var j=0;
for(j=0;j<thetotalubank;j++){
  if(!allbanks.contains(getuserbanks.banks[j].bankaccno)){
    if(mounted){
      setState(() {
    allbanks.add(getuserbanks.banks[j].bankaccno);
  });
    }
  } 
}
}

 }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cardHight = (width - 32) * (9 / 16);
    return Scaffold(
      appBar: appBar(context, "My Banks", actions: [
        Container(
          padding: EdgeInsets.only(right: AppFontSize.spacing_standard_new),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.add_circle_outline,
                size: 16,
                color:AppColors.appColorPrimary,
              ).paddingLeft(AppFontSize.spacing_middle),
              GestureDetector(
      onTap:(){
        showBankAdd(context);
                  
              },
               child: text("Add Bank",
                      fontSize: AppFontSize.textSizeMedium,
                      textColor: AppColors.appColorPrimary,
                      fontFamily: AppFontSize.fontMedium)
                  .paddingLeft(AppFontSize.spacing_control_half)
              )
              
            ],
          ),
        )
      ]),
      body: Container(
        height: double.infinity,
        child:   FutureBuilder<UserBankList>(
                    future: allbanklist,
                    builder: (context, gtserv) {
                      
                      switch (gtserv.connectionState) {
                        case ConnectionState.none:
                          return Center(child: text(AppTexts.connectiondelay, textColor: AppColors.appDarkRed, fontFamily: AppFontSize.montbold, fontSize: AppFontSize.textSizeSMedium,isCentered: true)); 
                          break;
                        case ConnectionState.waiting:
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  child: SpinKitWave(color: AppColors.shadowdarkblack2),
                                ),
                              ),
                            ],
                          );
                          break;
                        case ConnectionState.active:
                          return Text('');
                          break;
                        case ConnectionState.done:
                          if (gtserv.hasError) {
                            return Center(
                                child: Text(
                              'Banks not found, try again!',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ));
                          } else if (gtserv.hasData) {
                            if (gtserv.data.banks==null || gtserv.data.banks.isEmpty) {
                              return Center(
                                  child: Text('No Banks added yet',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                      )));
                            } else {
                              return  ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            padding: EdgeInsets.only(
                left: AppFontSize.spacing_standard_new,
                right: AppFontSize.spacing_standard_new,
                top: AppFontSize.spacing_standard_new),
            itemCount: gtserv.data.banks.length,
            itemBuilder: (BuildContext context, int index) { 
              var bankdata = gtserv.data.banks[index];
              return Container(
                width: MediaQuery.of(context).size.width,
                height: cardHight,
                margin: EdgeInsets.only(bottom: AppFontSize.spacing_standard_new),
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient( 
                              colors: AppColors.t12_gradient_colors[
                                  index % AppColors.t12_gradient_colors.length],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppFontSize.spacing_standard))),
                      width: double.infinity,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text("${bankdata.bankaccno}",
                                textColor: Colors.white.withOpacity(0.7),
                                fontSize: AppFontSize.textSizeMedium),
                            Image.asset(
                              AppImage.appLogoWhite,
                              width: 100,
                              height: 40, 
                            )
                          ], 
                        ),
                        Expanded(
                            child: FittedBox(
              child: Text(
                "${bankdata.accname}",
                style: boldTextStyle(
                    size: 20,
                    color: Colors.white,
                    letterSpacing: 3,
                    wordSpacing: 2),
                textAlign: TextAlign.center,
              ),
            ),
                        ),
              
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  text("BANK NAME",
                                      textColor: Colors.white.withOpacity(0.7),
                                      fontSize: AppFontSize.textSizeMedium),
                                  text("${bankdata.bankname}",
                                      textColor: Colors.white,
                                      fontSize: AppFontSize.textSizeMedium,
                                      fontFamily: AppFontSize.fontMedium),
                                ],
                              ),
                            ),
                         
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // text("USERNAME",
                                //     textColor: Colors.white.withOpacity(0.7),
                                //     fontSize: AppFontSize.textSizeMedium),
                                        Container(
                                          height: 35,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                              colors: AppColors.t12_gradient_colors[
                                  index % AppColors.t12_gradient_colors.length],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
                ),
                child: FlatButton(
                  onPressed: () async{
                    // if bank is not set as main account remove else show error
if(bankdata.bankaccno==mymainacc){
     final prefs = await StreamingSharedPreferences.instance;
prefs.setString('mainaccno'," ");
    prefs.setString('mainaccname'," ");
    prefs.setString('mainbnkname'," ");
        //  toast('This Bank is set as your main account, kindly change your main account before you can delete it.',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
}else{
deletemybank(bankid:bankdata.bankid,accno:bankdata.bankaccno);
}
                  },
                  splashColor: Colors.transparent,
                  child: Text(
                    'Remove',
                    style: primaryTextStyle(color: Colors.white),
                  ),
                ),
              )
                              ],
                            ).paddingRight(AppFontSize.spacing_standard_new),
                          ],
                        )
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new)
                  ],
                ),
              );
            });
  }
                          } else {
                            return Text('');
                          }
                          break;
                      }
                      return Text('');
                    },
                  ),



      ),
    );
  }


  Future showBankAdd(BuildContext context) {

    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return FractionallySizedBox(
            heightFactor: 0.9,
            child: DraggableScrollableSheet(
              initialChildSize: 0.8,
              maxChildSize: 1,
              minChildSize: 0.25,
              builder:
                  (BuildContext context, ScrollController scrollController) {
                return StatefulBuilder(
                    builder: (BuildContext context, StateSetter setStates) {
                  return SingleChildScrollView(
                      child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(AppFontSize.spacing_standard),
                            topRight:
                                Radius.circular(AppFontSize.spacing_standard))),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          width: double.infinity,
                          decoration: boxDecoration(
                              showShadow: true,
                              bgColor: Color(0xffBBd2fc).withOpacity(0.3),
                              radius: AppFontSize.spacing_standard),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                decoration: boxDecoration(
                                    showShadow: true,
                                    bgColor: Color(0xffBBd2fc),
                                    radius: AppFontSize.spacing_standard),
                                child: Image.asset(
                                  AppImage.appLogoblack,
                                  width: 40,
                                  height: 40,
                                ).paddingAll(AppFontSize.spacing_standard_new),
                              ).paddingRight(AppFontSize.spacing_standard_new),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    text("Add",
                                        textColor: AppColors.appColorPrimary,
                                        fontFamily: AppFontSize.montbold),
                                    text("New Bank Account",
                                            fontSize:
                                                AppFontSize.textSizeMedium,
                                            textColor:
                                                AppColors.appColorPrimary,
                                            fontFamily: AppFontSize.montbold)
                                        .paddingTop(
                                            AppFontSize.spacing_control_half),
                                  ],
                                ),
                              ),
                              // toolBarTitle("NEW").paddingTop(AppFontSize.spacing_standard_new),
                            ],
                          ).paddingAll(AppFontSize.spacing_standard),
                        ).paddingBottom(AppFontSize.spacing_standard_new),
                        Container(
                          width: double.infinity,
                          decoration: boxDecoration(
                              showShadow: true,
                              radius: AppFontSize.spacing_standard),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              text("Account Number",
                                      textColor: AppColors.appColorPrimary,
                                      fontFamily: AppFontSize.montlight)
                                  .paddingTop(AppFontSize.spacing_standard),
                              formField(context, "Enter your account number",
                                  controller: _accno,
                                  prefixIcon: Icons.attach_money, ontap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                if (!currentFocus.hasPrimaryFocus) {
                                  currentFocus.unfocus();
                                }
                              }).paddingTop(AppFontSize.spacing_standard),
                              text("Choose Bank",
                                  textColor: AppColors.appColorPrimary,
                                  fontFamily: AppFontSize.montlight),
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
                                      setStates(() {
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
                              text("Account Name",
                                      textColor: AppColors.appColorPrimary,
                                      fontFamily: AppFontSize.montlight)
                                  .paddingTop(AppFontSize.spacing_standard),
                              formField(context, "Account Name",
                                      controller: _accname,
                                      prefixIcon:
                                          Icons.supervised_user_circle_sharp,
                                      isEnabled: false)
                                  .paddingTop(AppFontSize.spacing_standard),
                              SizedBox(
                                width: double.infinity,
                                child: MaterialButton(
                                  padding: EdgeInsets.only(
                                      top: AppFontSize.spacing_standard_new,
                                      bottom: AppFontSize.spacing_standard_new),
                                  child: text("Add Now",
                                      textColor: Colors.white,
                                      fontFamily: AppFontSize.fontMedium),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(
                                          AppFontSize.spacing_standard)),
                                  color: AppColors.appColorPrimary,
                                  onPressed: () => {
                                    addbankacc(
                                        bankname: bankdropdownNames,
                                        accno: _accno.text,
                                        accname: _accname.text,
                                        pass: _pass.text)
                                  },
                                ),
                              ).paddingTop(AppFontSize.spacing_standard_new)
                            ],
                          ).paddingAll(AppFontSize.spacing_standard_new),
                        )
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new),
                  ));
                });
              }));
        });
  }


  
deletemybank({bankid,accno}) async {
  functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (bankid==0) {
          Navigator.of(context).pop();
          toast('Please choose a bank account',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (accno.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank account',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }  else {
          var v = await bankapi.userdeletebank(bankid: bankid,accno:accno
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
                 toast("Bank Account Removed Successfully",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
            // Navigator.of(context).pushNamed('/useraccount');
                     allbanks=[];
listOfCategory = [];
internetcheck();
              
            }  else {
             Navigator.of(context).pop();  

               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
          }else{
             Navigator.of(context).pop();  

             toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
          }
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

getbankaccname({bankname,accno}) async {
  functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (bankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (accno.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter account number',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }  else {
          var sendtbnkid=" ";
var getbanks = await bankapi.psbanklist();
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
    if(getbanks.banks[i].bankname==bankname){
    sendtbnkid= getbanks.banks[i].bankcode;
    break;
  }
}

          var v = await bankapi.psbankname(bankcode:sendtbnkid,accno:accno
          ).timeout(Duration(seconds: 30), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
                 toast("Bank name fetched Successfully",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
            _accname.text=v.msg;
              
            }  else {
             Navigator.of(context).pop();  

               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
          }else{
             Navigator.of(context).pop();  

             toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
          }
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

  addbankacc({bankname,accno,accname,pass}) async {
    pass=" ";
  functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (bankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (accno.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter account number',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (accname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter account number',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }
        //  else if (pass.isEmpty) {
        //   Navigator.of(context).pop();
        //   toast('Please enter password',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        // }
         else {
          var sendtbnkid=" ";
var getbanks = await bankapi.psbanklist();
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
    if(getbanks.banks[i].bankname==bankname){
    sendtbnkid= getbanks.banks[i].bankcode;
    break;
  }
}

          var v = await bankapi.useraddbank(accbank:bankname,accname:accname,accno:accno,bankcode:sendtbnkid,pass:pass
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop(); 
              Navigator.of(context).pop(); 
                 toast("Bank added Successfully",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
                      // Navigator.of(context).pushNamed('/useraccount');
                      allbanks=[];
listOfCategory = [];
internetcheck();
            }  else {
             Navigator.of(context).pop();  

               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
          }else{
             Navigator.of(context).pop();  

             toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
          }
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


}
