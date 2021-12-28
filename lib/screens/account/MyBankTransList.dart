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
import 'package:loadng/model/bank/UserBankTransList.dart';




var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
var bankapi = locator<BankApi>();


class MyTransBankList extends StatefulWidget {
  static String tag = '/mytransbanks';

  @override
  MyTransBankListState createState() => MyTransBankListState();
}

class MyTransBankListState extends State<MyTransBankList> {
    TextEditingController _accno,_accname,_pass;
  Future allbanklist;
  String bankdropdownNames,paxbankname,withdrawbankname,bcbnkname,gcbankname,unibankname,pmbankname;
  List<String> listOfCategory = [];
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
allbanklist=bankapi.userbanktranslist();
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

var getuserbanks = await bankapi.userbanklist();
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

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cardHight = (width - 32) * (9 / 16);
    return Scaffold(
      appBar: appBar(context, "Banks", actions: [
        Container(
          padding: EdgeInsets.only(right: AppFontSize.spacing_standard_new),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.check_box,
                size: 16,
                color:AppColors.appColorPrimary,
              ),
              GestureDetector(
      onTap:()
    {
                   showModalBottomSheet(
                                              backgroundColor: Colors.transparent,
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return  DraggableScrollableSheet(
              initialChildSize: 0.85,
              maxChildSize: 1,
              minChildSize: 0.5,
              builder: (BuildContext context, ScrollController scrollController) {
                 return StatefulBuilder(
                  builder: (BuildContext context, StateSetter setStates) {
                 return 
             SingleChildScrollView( child: Container(
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.only(topLeft:Radius.circular(AppFontSize.spacing_standard),topRight: Radius.circular(AppFontSize.spacing_standard) )
                                                  ),
                                                  child: Column(
                                                     mainAxisSize: MainAxisSize.min,
                                                    children: <Widget>[
                                                    Container(
                                width: double.infinity,
                                decoration: boxDecoration(showShadow: true,bgColor: Color(0xffBBd2fc).withOpacity(0.3),radius: AppFontSize.spacing_standard),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      decoration: boxDecoration(showShadow: true,bgColor: Color(0xffBBd2fc),radius: AppFontSize.spacing_standard),
                                      child:Image.asset(AppImage.uni,width: 40,height: 40,).paddingAll(AppFontSize.spacing_standard_new),
                                    ).paddingRight(AppFontSize.spacing_standard_new),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: <Widget>[
                                          text("Set",fontFamily: AppFontSize.montbold,textColor: AppColors.appColorPrimary,),
                                          text("Bank Account",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.montbold).paddingTop(AppFontSize.spacing_control_half),
                                        ],
                                      ),
                                    ),
                                    // toolBarTitle("NEW").paddingTop(AppFontSize.spacing_standard_new),
                                  ],
                                ).paddingAll(AppFontSize.spacing_standard),
                              ).paddingBottom(AppFontSize.spacing_standard_new),

                               Container(
                                width: double.infinity,
                                decoration: boxDecoration(showShadow: true,radius: AppFontSize.spacing_standard),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                     text("Password",textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.montlight).paddingTop(AppFontSize.spacing_standard),
                                    formField(context,"Enter your password",controller: _pass, prefixIcon: Icons.shield,isPassword: true,ontap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
                                    } ).paddingTop(AppFontSize.spacing_standard),

                                    text("Paxful Transactions",textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.montlight),
                                     Card(
                                       color:AppColors.t12_edittext_background,
                  child: DropdownButton(
                    isExpanded: true,
                    // dropdownColor: AppColors.appColorPrimaryDarkLight,
                    value: paxbankname,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.appColorPrimary,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                      setStates(() {
                        toast(newValue);
                        paxbankname = newValue;
                      });
                    },
                    items: allbanks.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),
                                
                                    text("Universal Transactions",textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.montlight).paddingTop(AppFontSize.spacing_standard),
                                     Card(
                                       color:AppColors.t12_edittext_background,
                  child: DropdownButton(
                    isExpanded: true,
                    // dropdownColor: AppColors.appColorPrimaryDarkLight,
                    value: unibankname,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.appColorPrimary,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                      setStates(() {
                        toast(newValue);
                       unibankname = newValue;
                      });
                    },
                    items: allbanks.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),
                                    text("Blockchain Transactions",textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.montlight).paddingTop(AppFontSize.spacing_standard),
                                    Card(
                                       color:AppColors.t12_edittext_background,
                  child: DropdownButton(
                    isExpanded: true,
                    // dropdownColor: AppColors.appColorPrimaryDarkLight,
                    value: bcbnkname,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.appColorPrimary,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                      setStates(() {
                        toast(newValue);
                        bcbnkname = newValue;
                      });
                    },
                    items: allbanks.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),
                        text("Giftcard Transactions",textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.montlight).paddingTop(AppFontSize.spacing_standard),
                                    Card(
                                       color:AppColors.t12_edittext_background,
                  child: DropdownButton(
                    isExpanded: true,
                    // dropdownColor: AppColors.appColorPrimaryDarkLight,
                    value: gcbankname,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.appColorPrimary,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                      setStates(() {
                        toast(newValue);
                        gcbankname = newValue;
                      });
                    },
                    items: allbanks.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),
                        text("Perfect Money Transactions",textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.montlight).paddingTop(AppFontSize.spacing_standard),
                                    Card(
                                       color:AppColors.t12_edittext_background,
                  child: DropdownButton(
                    isExpanded: true, 
                    // dropdownColor: AppColors.appColorPrimaryDarkLight,
                    value: pmbankname,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.appColorPrimary,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                      setStates(() {
                        toast(newValue);
                        pmbankname = newValue;
                      });
                    },
                    items: allbanks.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),
                   text("Withdrawal Transactions",textColor: AppColors.appColorPrimary,fontFamily: AppFontSize.montlight).paddingTop(AppFontSize.spacing_standard),
                                    Card(
                                       color:AppColors.t12_edittext_background,
                  child: DropdownButton(
                    isExpanded: true,
                    // dropdownColor: AppColors.appColorPrimaryDarkLight,
                    value: withdrawbankname,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.appColorPrimary,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                      setStates(() {
                        toast(newValue);
                        withdrawbankname = newValue;
                      });
                    },
                    items: allbanks.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),

                                    SizedBox(
                                      width: double.infinity,
                                      child: MaterialButton(
                                        padding: EdgeInsets.only(top: AppFontSize.spacing_standard_new,bottom: AppFontSize.spacing_standard_new),
                                        child: text("Set Now",
                                            textColor: Colors.white, fontFamily: AppFontSize.fontMedium),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: new BorderRadius.circular(AppFontSize.spacing_standard)),
                                        color: AppColors.appColorPrimary,
                                        onPressed: () => {
                                       setbankacc(paxfulbankname: paxbankname,unibankname:unibankname,blockchainbankname:bcbnkname,coinsbankname:withdrawbankname,pmbankname:pmbankname,giftcardbankname:gcbankname,pass:_pass.text)
                                        },
                                      ),
                                    ).paddingTop(AppFontSize.spacing_standard_new)
                                  ],
                                ).paddingAll(AppFontSize.spacing_standard_new),
                              )

                                                    ],
                                                  ).paddingAll(AppFontSize.spacing_standard_new),
                                                 ) );
                                                 }); });
                                              });
              },
               child: text("Set Bank",
                      fontSize: AppFontSize.textSizeMedium,
                      textColor: AppColors.appColorPrimary,
                      fontFamily: AppFontSize.fontMedium)
                  .paddingLeft(AppFontSize.spacing_control_half)
              ),
            
            ],
          ),
        )
      ]),
      body: Container(
        height: double.infinity,
        child:   FutureBuilder<UserBankTransList>(
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
                  onPressed: () {
                  },
                  splashColor: Colors.transparent,
                  child: Text(
                    '${bankdata.systemname}',
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

setbankacc({paxfulbankname ,unibankname,blockchainbankname,coinsbankname,pmbankname,giftcardbankname,pass}) async {
  functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (paxfulbankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank for paxful transactions',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (unibankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank for universal transactions',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (blockchainbankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank for blockchain transactions',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (coinsbankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank for withdrawal transactions',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (giftcardbankname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a bank for giftcard transactions',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (pass.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter your password',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }  else {
          var giftcardbankid=0;var pmbankid=0;
          var paxfulbankid=0; var unibankid=0;var blockchainbankid=0; var coinsbankid=0;
var getbanks = await bankapi.userbanklist();
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
    if(getbanks.banks[i].bankaccno==paxfulbankname){
    paxfulbankid= getbanks.banks[i].bankid;
  }
  if(getbanks.banks[i].bankaccno==unibankname){
    unibankid= getbanks.banks[i].bankid;
  }
  if(getbanks.banks[i].bankaccno==blockchainbankname){
    blockchainbankid= getbanks.banks[i].bankid;
  }
  if(getbanks.banks[i].bankaccno==coinsbankname){
    coinsbankid= getbanks.banks[i].bankid;
  }
      if(getbanks.banks[i].bankaccno==giftcardbankname){
    giftcardbankid= getbanks.banks[i].bankid;
 
  }    if(getbanks.banks[i].bankaccno==giftcardbankname){
    pmbankid= getbanks.banks[i].bankid;
   
  }
}

          var v = await bankapi.usersettransactionbank(paxfulbankid:"$paxfulbankid",unibankid:"$unibankid" ,blockchainbankid:"$blockchainbankid" ,coinsbankid:"$coinsbankid" ,pmbankid: "$pmbankid",giftcardbankid:"$giftcardbankid",pass:pass
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
              Navigator.of(context).pop();
                 toast("Bank set for each transactions Successfully",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
                      Navigator.of(context).pushNamed('/useraccount');
              
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
