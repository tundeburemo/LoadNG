import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadng/model/sendreceive/userwalletlist.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/apis/spendreceive.dart';
import 'package:loadng/locator.dart';
import 'dart:io';
import "package:loadng/model/system/route_argument.dart";
import 'package:loadng/styles/AppText.dart';



var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
var spendreceiveapi = locator<SpendReceiveApi>();

class MyWalletLists extends StatefulWidget {
  static String tag = '/mysrwallets';

  @override
  MyWalletListsState createState() => MyWalletListsState();
}

class MyWalletListsState extends State<MyWalletLists> {
  Future allwalletlist;
String walletdropdownname;
  List<String> listofcoins = [];

  @override
  void initState() {
    internetcheck();
    super.initState();
  }

  internetcheck() async {
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    if (theinternet && theinternet2) {
      setState(() {
        allwalletlist = spendreceiveapi.usersrwallets();
      });
      var getwalletdata = await spendreceiveapi.allsrcoins();
var thetotal = getwalletdata.coins.length;
var i=0;
for(i=0;i<thetotal;i++){
  if(!listofcoins.contains(getwalletdata.coins[i].name)){
if(mounted){
      setState(() {
    listofcoins.add(getwalletdata.coins[i].name);
  });
}
  }
}
    } else {
      functionfile.showerror(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cardHight = (width - 32) * (9 / 16);
    return Scaffold(
      appBar: appBar(context, "My Wallets", actions: [
        Container(
            padding: EdgeInsets.only(right: AppFontSize.spacing_standard_new),
            child: Row(children: <Widget>[
              Icon(
                Icons.add_circle_outline,
                size: 16,
                color: AppColors.appColorPrimary,
              ),
              GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return DraggableScrollableSheet(
                              initialChildSize: 0.59,
                              maxChildSize: 1,
                              minChildSize: 0.5,
                              builder: (BuildContext context,
                                  ScrollController scrollController) {
                                return StatefulBuilder(builder:
                                    (BuildContext context,
                                        StateSetter setStates) {
                                  return SingleChildScrollView(
                                      child: Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                AppFontSize.spacing_standard),
                                            topRight: Radius.circular(
                                                AppFontSize.spacing_standard))),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Container(
                                          width: double.infinity,
                                          decoration: boxDecoration(
                                              showShadow: true,
                                              bgColor: Color(0xffBBd2fc)
                                                  .withOpacity(0.3),
                                              radius:
                                                  AppFontSize.spacing_standard),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                decoration: boxDecoration(
                                                    showShadow: true,
                                                    bgColor: Color(0xffBBd2fc),
                                                    radius: AppFontSize
                                                        .spacing_standard),
                                                child: Image.asset(
                                                  AppImage.appLogoblack,
                                                  width: 40,
                                                  height: 40,
                                                ).paddingAll(AppFontSize
                                                    .spacing_standard_new),
                                              ).paddingRight(AppFontSize
                                                  .spacing_standard_new),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: <Widget>[
                                                    text("Add",
                                                        textColor: AppColors
                                                            .appColorPrimary,
                                                        fontFamily: AppFontSize
                                                            .montbold),
                                                    text("New Wallet Account",
                                                            fontSize: AppFontSize
                                                                .textSizeMedium,
                                                            textColor: AppColors
                                                                .appColorPrimary,
                                                            fontFamily:
                                                                AppFontSize
                                                                    .montbold)
                                                        .paddingTop(AppFontSize
                                                            .spacing_control_half),
                                                  ],
                                                ),
                                              ),
                                              // toolBarTitle("NEW").paddingTop(AppFontSize.spacing_standard_new),
                                            ],
                                          ).paddingAll(
                                              AppFontSize.spacing_standard),
                                        ).paddingBottom(
                                            AppFontSize.spacing_standard_new),
                                        Container(
                                          width: double.infinity,
                                          decoration: boxDecoration(
                                              showShadow: true,
                                              radius:
                                                  AppFontSize.spacing_standard),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              text("Coin Type",
                                                  textColor:
                                                      AppColors.appColorPrimary,
                                                  fontFamily:
                                                      AppFontSize.montlight),
                                              Card(
                                                      color: AppColors
                                                          .t12_edittext_background,
                                                      child: DropdownButton(
                                                        isExpanded: true,
                                                        // dropdownColor: AppColors.appColorPrimaryDarkLight,
                                                        value:
                                                            walletdropdownname,
                                                        style: boldTextStyle(),
                                                        icon: Icon(
                                                          Icons
                                                              .keyboard_arrow_down,
                                                          color: AppColors
                                                              .appColorPrimary,
                                                        ),
                                                        underline: 0.height,
                                                        onChanged: (newValue) {
                                                          setStates(() {
                                                            toast(newValue);
                                                            walletdropdownname =
                                                                newValue;
                                                          });
                                                        },
                                                        items: listofcoins
                                                            .map((category) {
                                                          return DropdownMenuItem(
                                                            child: Text(
                                                                    category,
                                                                    style:
                                                                        primaryTextStyle())
                                                                .paddingLeft(8),
                                                            value: category,
                                                          );
                                                        }).toList(),
                                                      ))
                                                  .paddingTop(AppFontSize
                                                      .spacing_standard),
                                              SizedBox(
                                                width: double.infinity,
                                                child: MaterialButton(
                                                  padding: EdgeInsets.only(
                                                      top: AppFontSize
                                                          .spacing_standard_new,
                                                      bottom: AppFontSize
                                                          .spacing_standard_new),
                                                  child: text("Add Now",
                                                      textColor: Colors.white,
                                                      fontFamily: AppFontSize
                                                          .fontMedium),
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: new BorderRadius
                                                              .circular(
                                                          AppFontSize
                                                              .spacing_standard)),
                                                  color:
                                                      AppColors.appColorPrimary,
                                                  onPressed: () => {
                                                    addnewwallet(
                                                        walletname: walletdropdownname)
                                                  },
                                                ),
                                              ).paddingTop(AppFontSize
                                                  .spacing_standard_new)
                                            ],
                                          ).paddingAll(
                                              AppFontSize.spacing_standard_new),
                                        )
                                      ],
                                    ).paddingAll(
                                        AppFontSize.spacing_standard_new),
                                  ));
                                });
                              });
                        });
                  },
                  child: text("Add Wallet",
                          fontSize: AppFontSize.textSizeMedium,
                          textColor: AppColors.appColorPrimary,
                          fontFamily: AppFontSize.fontMedium)
                      .paddingLeft(AppFontSize.spacing_control_half))
            ]))
      ]),
      body: Container(
        height: double.infinity,
        child: FutureBuilder<UserwalletList>(
          future: allwalletlist,
          builder: (context, gtserv) {
            switch (gtserv.connectionState) {
              case ConnectionState.none:
                return Center(
                    child: text(AppTexts.connectiondelay,
                        textColor: AppColors.appDarkRed,
                        fontFamily: AppFontSize.montbold,
                        fontSize: AppFontSize.textSizeSMedium,
                        isCentered: true));
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
                    'Wallet not found, try again!',
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ));
                } else if (gtserv.hasData) {
                  if (gtserv.data.coins == null || gtserv.data.coins.isEmpty) {
                    return Center(
                        child: Text('No Wallet added yet',
                            style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.w800,
                            )));
                  } else {
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.only(
                            left: AppFontSize.spacing_standard_new,
                            right: AppFontSize.spacing_standard_new,
                            top: AppFontSize.spacing_standard_new),
                        itemCount: gtserv.data.coins.length,
                        itemBuilder: (BuildContext context, int index) {
                          var walletdata = gtserv.data.coins[index];
                          var coint= walletdata.cointype.toUpperCase();
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            height: cardHight,
                            margin: EdgeInsets.only(
                                bottom: AppFontSize.spacing_standard_new),
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: AppColors.t12_gradient_colors[
                                              index %
                                                  AppColors.t12_gradient_colors
                                                      .length],
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(
                                              AppFontSize.spacing_standard))),
                                  width: double.infinity,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        text("${walletdata.productname}",
                                            textColor:
                                                Colors.white.withOpacity(0.7),
                                            fontSize:
                                                AppFontSize.textSizeMedium),
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
                                          "${walletdata.walletbal} $coint",
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
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              // text("BANK NAME",
                                              //     textColor: Colors.white.withOpacity(0.7),
                                              //     fontSize: AppFontSize.textSizeMedium),
                                              Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: AppColors
                                                              .t12_gradient_colors[
                                                          index %
                                                              AppColors
                                                                  .t12_gradient_colors
                                                                  .length],
                                                      begin:
                                                          Alignment.bottomRight,
                                                      end: Alignment.topLeft),
                                                ),
                                                child: FlatButton(
                                                  onPressed: () {
                                             Navigator.of(context).pushNamed('/sendcoin',arguments: new RouteArgument(argumentsList: ["${walletdata.useraddress}", "${walletdata.img}","${walletdata.productname}","${walletdata.productrackid}","${walletdata.cointype}"])); 
                                                  },
                                                  splashColor:
                                                      Colors.transparent,
                                                  child: Text(
                                                    'Send',
                                                    style: primaryTextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                          Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              // text("BANK NAME",
                                              //     textColor: Colors.white.withOpacity(0.7),
                                              //     fontSize: AppFontSize.textSizeMedium),
                                              Container(
                                                height: 35,
                                                decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: AppColors
                                                              .t12_gradient_colors[
                                                          index %
                                                              AppColors
                                                                  .t12_gradient_colors
                                                                  .length],
                                                      begin:
                                                          Alignment.bottomRight,
                                                      end: Alignment.topLeft),
                                                ),
                                                child: FlatButton(
                                                  onPressed: () {
                                                    sellcoinnow2(wallettid:walletdata.productrackid);

                                                  },
                                                  splashColor:
                                                      Colors.transparent,
                                                  child: Text(
                                                    'Sell',
                                                    style: primaryTextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(width: 5),
                                        // Column(
                                        //   crossAxisAlignment:
                                        //       CrossAxisAlignment.start,
                                        //   children: <Widget>[
                                            // text("USERNAME",
                                            //     textColor: Colors.white.withOpacity(0.7),
                                            //     fontSize: AppFontSize.textSizeMedium),
                                            Container(
                                              height: 35, 
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: AppColors
                                                            .t12_gradient_colors[
                                                        index %
                                                            AppColors
                                                                .t12_gradient_colors
                                                                .length],
                                                    begin:
                                                        Alignment.bottomRight,
                                                    end: Alignment.topLeft),
                                              ),
                                              child: FlatButton(
                                                onPressed: () {
                               Navigator.of(context).pushNamed('/receivecoin',arguments: new RouteArgument(argumentsList: ["${walletdata.useraddress}", "${walletdata.img}","${walletdata.productname}","${walletdata.productrackid}"])); 
                                                },
                                                splashColor: Colors.transparent,
                                                child: Text(
                                                  'Receive',
                                                  style: primaryTextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            )
                                        //   ],
                                        // ).paddingRight(
                                        //     AppFontSize.spacing_standard_new),
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


    addnewwallet({walletname}) async {
  functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (walletname.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a coin type',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {
          var sendwalletid=" ";
var getwalletdata = await spendreceiveapi.allsrcoins();
var thetotal = getwalletdata.coins.length;
var i=0;
for(i=0;i<thetotal;i++){
    if(getwalletdata.coins[i].name==walletname){
    sendwalletid= getwalletdata.coins[i].trackid;
    break;
  }
}

          var v = await spendreceiveapi.useraddsrwallet(trackid:sendwalletid
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
                 toast("Wallet added Successfully",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
                      Navigator.of(context).pushNamed('/mysrwallets');
              
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

  
 sellcoinnow2({wallettid}) async {
  functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (wallettid.isEmpty) {
          Navigator.of(context).pop();
          toast('Please choose a coin type',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {

          var v = await spendreceiveapi.usersellcoin(trackid:wallettid,amt:0
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
                 toast("Wallet added Successfully",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
                      Navigator.of(context).pushNamed('/mysrwallets');
              
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
