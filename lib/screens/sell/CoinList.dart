import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:loadng/services/apis/system.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadng/model/system/NewCoinsList.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/model/system/biz2coinlist.dart';
import 'dart:developer';

var systemapi = locator<SystemApi>();
var functionfile = locator<CustomFunction>();

class CoinsList extends StatefulWidget {
  static var tag = "/coinslist";

  @override
  CoinsListState createState() => CoinsListState();
}

class CoinsListState extends State<CoinsList> {
  int selectedPos = 1;
  var paxful = "0";
  var blockchain = "0";
  var uni = "0";
  var eth = "0";
  var litecoin = "0";
  var bch = "0";
  var usdc = "0";
  var dai="0";
  var doge="0";
  var pm = "0";
  var activepax = 0;
  @override
  void initState() {
    checkmyinternet();
    internetcheck();
    super.initState();
    selectedPos = 1;
  }

  Future allnewcoins;
  Future allbiz2coins;

  internetcheck() async {
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    if (theinternet && theinternet2) {
      userInfo();
      setState(() {
        allnewcoins = systemapi.newcoinslist();
        allbiz2coins =systemapi.biz2coinslist();
      });
    } else {
      functionfile.showerror(context);
    }
  }

  bool sendme = false;

  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(Colors.transparent);
    return Scaffold(
        backgroundColor: AppColors.t5LayoutBackgroundWhite,
        body: Container(
          alignment: Alignment.topLeft,
          child: ListView(
            children: <Widget>[
              TopBar(),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: text("Sell Coins",
                    textColor: AppColors.shadowdarkblack,
                    fontFamily: AppFontSize.montbold,
                    fontSize: AppFontSize.textSizeLarge),
              ),
              Container(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 12),
                child: GridView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(), //ScrollPhysics(),
                    itemCount: 10,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 16,
                        mainAxisSpacing: 16),
                    itemBuilder: (BuildContext context, int index) {
                      var thehexcode, thename, therate, theimage, thenavlink;
                      if (index == 0) {
                        thehexcode = 0xfffae6fb;
                        thename = "Paxful Bitcoin";
                        therate = "$paxful";
                        theimage = AppImage.paxful;
                        if (activepax == 0) {
                          thenavlink = "/sellpaxful";
                        } else {
                          thenavlink = "/sellpaxful2";
                        }
                      } else if (index == 1) {
                        thehexcode = 0xfffff0dd;
                        thename = "Blockchain BTC";
                        therate = "$blockchain";
                        theimage = AppImage.uni;
                        thenavlink = "/selluniversal";
                      } else if (index == 2) {
                        thehexcode = 0xfffff9d9;
                        thename = "Cashapp & Other BTC";
                        therate = "$uni";
                        theimage = AppImage.cashapp;
                        thenavlink = "/selluniversal";
                      } else if (index == 3) {
                        thehexcode = 0xffd9e1ff;
                        thename = "Ethereum";
                        therate = "$eth";
                        theimage = AppImage.eth;
                        thenavlink = "/selluniversal";
                      } else if (index == 4) {
                        thehexcode = 0xfffce5c0;
                        thename = "Litecoin";
                        therate = "$litecoin";
                        theimage = AppImage.ltc;
                        thenavlink = "/selluniversal";
                      } else if (index == 5) {
                        thehexcode = 0xffeeffdc;
                        thename = "Bitcoin Cash";
                        therate = "$bch";
                        theimage = AppImage.bch;
                        thenavlink = "/selluniversal";
                      } else if (index == 6) {
                        thehexcode = 0xffe6f2ff;
                        thename = "USDC";
                        therate = "$usdc";
                        theimage = AppImage.usd;
                        thenavlink = "/selluniversal";
                      } else if (index == 7) {
                        thehexcode = 0xfffbf1dd;
                        thename = "DAI";
                        therate = "$dai";
                        theimage = AppImage.dai;
                        thenavlink = "/selluniversal";
                      } else if (index == 8) {
                        thehexcode = 0xfffffdd5;
                        thename = "DOGE";
                        therate = "$doge";
                        theimage = AppImage.doge;
                        thenavlink = "/selluniversal";
                      }else if (index == 9) {
                        thehexcode = 0xffffc1c1;
                        thename = "Perfect Money";
                        therate = "$pm";
                        theimage = AppImage.pm;
                        thenavlink = "/sellpm";
                      }
                      return GestureDetector(
                          onTap: () {
                            internetcheck();
                            checkmyinternet();
                            if (sendme && therate != "0" && therate != 0) {
                              var txtdialog = " ";
                              if (index == 0) {
                                if (activepax == 0) {
                                  txtdialog =
                                      "LoadNG buys Paxful Bitcoin at the rate of $therate₦/\$ with instant payment. Kindly enter the amount you want to sell in USD value, choose the bank you want to get paid to, the system calculates the Naira equivalent and pays immediately.";
                                } else {
                                  txtdialog = 
                                      "LoadNG buys Paxful Bitcoin at the rate of $therate₦/\$ with instant payment. The system is about to generate a unique Paxful wallet address for you, note that the wallet is once and not generated again after first generation of the wallet. Kindly proceed to send Bitcoin to the address by scanning the barcode or copying the wallet address to Paxful website, the system credits your LoadNG wallet immediately after the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation";
                                }
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomInfo(
                                          sentimg: theimage,
                                          senttxt: txtdialog,
                                          thename: thename,
                                          therate: therate,
                                          thehexcode: thehexcode,
                                          thenavlink: thenavlink,
                                        ));
                              } else if (index == 1) {
                                // txtdialog="The LoadNG system is about to generate a unique wallet address for you. Kindly proceed to send Bitcoin to the address by scanning the barcode or copying the wallet address to the Bitcoin wallet you are sending from, the system credits your LoadNG wallet immediately the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation. You can send to your dedicated wallet address at anytime without even launching our app.";
                                txtdialog =
                                    "The LoadNG system is about to generate a unique wallet address for you. Kindly proceed to send Bitcoin to the address by scanning the barcode or copying the wallet address to the wallet you are sending from, the system credits your LoadNG wallet immediately after the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation. Make sure you use a wallet just once.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomInfo(
                                            sentimg: theimage,
                                            senttxt: txtdialog,
                                            thename: thename,
                                            therate: therate,
                                            thehexcode: thehexcode,
                                            thenavlink: thenavlink,
                                            thetype: 1));
                              } else if (index == 2) {
                                txtdialog =
                                    "The LoadNG system is about to generate a unique wallet address for you. Kindly proceed to send Bitcoin to the address by scanning the barcode or copying the wallet address to the  wallet you are sending from, the system credits your LoadNG wallet immediately after the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation. Make sure you use a wallet just once.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomInfo(
                                            sentimg: theimage,
                                            senttxt: txtdialog,
                                            thename: thename,
                                            therate: therate,
                                            thehexcode: thehexcode,
                                            thenavlink: thenavlink,
                                            thetype: 1));
                              } else if (index == 3) {
                                txtdialog =
                                    "The LoadNG system is about to generate a unique wallet address for you. Kindly proceed to send Ethereum to the address by scanning the barcode or copying the wallet address to the Ethereum wallet you are sending from, the system credits your LoadNG wallet immediately after the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation. Make sure you use a wallet just once.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomInfo(
                                            sentimg: theimage,
                                            senttxt: txtdialog,
                                            thename: thename,
                                            therate: therate,
                                            thehexcode: thehexcode,
                                            thenavlink: thenavlink,
                                            thetype: 2));
                              } else if (index == 4) {
                                txtdialog =
                                    "The LoadNG system is about to generate a unique wallet address for you. Kindly proceed to send Litecoin to the address by scanning the barcode or copying the wallet address to the Litecoin wallet you are sending from, the system credits your LoadNG wallet immediately after the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation. Make sure you use a wallet just once.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomInfo(
                                            sentimg: theimage,
                                            senttxt: txtdialog,
                                            thename: thename,
                                            therate: therate,
                                            thehexcode: thehexcode,
                                            thenavlink: thenavlink,
                                            thetype: 3));
                              } else if (index == 5) {
                                txtdialog =
                                    "The LoadNG system is about to generate a unique wallet address for you. Kindly proceed to send Bitcoin cash to the address by scanning the barcode or copying the wallet address to the Bitcoin cash wallet you are sending from, the system credits your LoadNG wallet immediately after the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation. Make sure you use a wallet just once.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomInfo(
                                            sentimg: theimage,
                                            senttxt: txtdialog,
                                            thename: thename,
                                            therate: therate,
                                            thehexcode: thehexcode,
                                            thenavlink: thenavlink,
                                            thetype: 4));
                              } else if (index == 6) {
                                txtdialog =
                                    "The LoadNG system is about to generate a unique wallet address for you. Kindly proceed to send USDC to the address by scanning the barcode or copying the wallet address to the USDC wallet you are sending from, the system credits your LoadNG wallet immediately after the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation. Make sure you use a wallet just once.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomInfo(
                                            sentimg: theimage,
                                            senttxt: txtdialog,
                                            thename: thename,
                                            therate: therate,
                                            thehexcode: thehexcode,
                                            thenavlink: thenavlink,
                                            thetype: 5));
                              } else if (index == 7) {
                                txtdialog =
                                    "The LoadNG system is about to generate a unique wallet address for you. Kindly proceed to send DAI coins to the address by scanning the barcode or copying the wallet address to the DAI wallet you are sending from, the system credits your LoadNG wallet immediately after the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation. Make sure you use a wallet just once.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomInfo(
                                            sentimg: theimage,
                                            senttxt: txtdialog,
                                            thename: thename,
                                            therate: therate,
                                            thehexcode: thehexcode,
                                            thenavlink: thenavlink,
                                            thetype: 6));
                              }else if (index == 8) {
                                txtdialog =
                                    "The LoadNG system is about to generate a unique wallet address for you. Kindly proceed to send DOGE coins to the address by scanning the barcode or copying the wallet address to the DOGE wallet you are sending from, the system credits your LoadNG wallet immediately after the transaction is recognized and withdraws it automatically to your bank account after at least 1 confirmation. Make sure you use a wallet just once.";
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        CustomInfo(
                                            sentimg: theimage,
                                            senttxt: txtdialog,
                                            thename: thename,
                                            therate: therate,
                                            thehexcode: thehexcode,
                                            thenavlink: thenavlink,
                                            thetype: 7));
                              } else if (index == 9) {
                                // pm
                                Navigator.of(context).pushNamed('$thenavlink',
                                    arguments: new RouteArgument(
                                        argumentsList: [
                                          "$thename",
                                          "$theimage",
                                          "$therate",
                                          thehexcode
                                        ]));
                              }
                            } else {
                              userInfo();
                              functionfile.showerror(context);
                            }
                          },
                          child: coinSellLayer(
                              thehexcode, theimage, thename, therate));
                    }),
              ),
              // sell biz2
                 Container(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                child: FutureBuilder<LatestCoinList>(
                  future: allbiz2coins,
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
                                child: SpinKitWave(
                                    color: AppColors.shadowdarkblack2),
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
                            ' ',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ));
                        } else if (gtserv.hasData) {
                          if (gtserv.data.coins == null ||
                              gtserv.data.coins.isEmpty) {
                            return Center(
                                child: Text(' ',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w800,
                                    )));
                          } else {
                            return GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics:
                                    NeverScrollableScrollPhysics(), //ScrollPhysics(),
                                itemCount: gtserv.data.coins.length, //9,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16),
                                itemBuilder: (BuildContext context, int index) {
                                  var coinlist = gtserv.data.coins[index];
                                  var thehexcode,
                                      thename,
                                      therate,
                                      theimage,
                                      thenavlink,thetrackid,theaddress;
                                      // 0xfcoinlist.colorcode);
                                    var de=  functionfile.hexToInt("${coinlist.colorcode}");
                                  thehexcode = de;
                                  thename = coinlist.name;
                                  therate = coinlist.rate;
                                  theimage = coinlist.img;
                                  thenavlink = "/sellbiz2";
                                  thetrackid= coinlist.trackid;
                                  theaddress= coinlist.address;
                          
 

                                  return GestureDetector(
                                      onTap: () {
                                        if (sendme &&
                                            therate != "0" &&
                                            therate != 0) {
                                          var txtdialog = " ";
                                          txtdialog = "The $thename wallet is a LoadNG Business Wallet, this means you could always send $thename to your dedicated address provided on the next screen.";
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomInfo(
                                                    sentimgtype: 1,
                                                      sentimg: theimage,
                                                      senttxt: txtdialog,
                                                      thename: thename,
                                                      therate: therate,
                                                      thehexcode: thehexcode,
                                                      thenavlink: thenavlink,
                                                      thetype: thetrackid,
                                                      theaddress:theaddress));
                                        } else {
                                          userInfo();
                                          functionfile.showerror(context);
                                        }
                                      },
                                      child: coinSellLayer(thehexcode, theimage,
                                          thename, therate,theimagetype:1));
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



              // sell new coins added
              Container(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                child: FutureBuilder<NewCoinsList>(
                  future: allnewcoins,
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
                                child: SpinKitWave(
                                    color: AppColors.shadowdarkblack2),
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
                            ' ',
                            style: TextStyle(
                                color: Colors.red, fontWeight: FontWeight.bold),
                          ));
                        } else if (gtserv.hasData) {
                          if (gtserv.data.coins == null ||
                              gtserv.data.coins.isEmpty) {
                            return Center(
                                child: Text(' ',
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w800,
                                    )));
                          } else {
                            return GridView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                physics:
                                    NeverScrollableScrollPhysics(), //ScrollPhysics(),
                                itemCount: gtserv.data.coins.length, //9,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 16,
                                        mainAxisSpacing: 16),
                                itemBuilder: (BuildContext context, int index) {
                                  var coinlist = gtserv.data.coins[index];
                                  var thehexcode,
                                      thename,
                                      therate,
                                      theimage,
                                      thenavlink,thetrackid,theaddress;
                                  thehexcode = 0xfffae6fb;
                                  thename = coinlist.name;
                                  therate = coinlist.rate;
                                  theimage = AppImage.others;
                                  thenavlink = "/SellNewCoins";
                                  thetrackid= coinlist.trackid;
                                  theaddress= coinlist.address;
 
 

                                  return GestureDetector(
                                      onTap: () {
                                        if (sendme &&
                                            therate != "0" &&
                                            therate != 0) {
                                          var txtdialog = " ";
                                          txtdialog = "Send any amount of $thename to the wallet address that would be shown on the next screen. Copy the transaction hash generated after the transfer, also screenshot the transaction details because all would be needed to initiate the transaction.";
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  CustomInfo(
                                                      sentimg: theimage,
                                                      senttxt: txtdialog,
                                                      thename: thename,
                                                      therate: therate,
                                                      thehexcode: thehexcode,
                                                      thenavlink: thenavlink,
                                                      thetype: thetrackid,
                                                      theaddress:theaddress));
                                        } else {
                                          userInfo();
                                          functionfile.showerror(context);
                                        }
                                      },
                                      child: coinSellLayer(thehexcode, theimage,
                                          thename, therate));
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
              )
            ],
          ),
        ));
  }

  Container coinSellLayer(thehexcode, theimage, thename, therate,{theimagetype=0}) {
    return Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      decoration: boxDecoration(
          radius: 16,
          showShadow: true,
          color: Color(thehexcode),
          bgColor: Color(thehexcode)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
theimagetype==1?
          Image.network(
            theimage,
            width: 50,
            height: 50,
          ):
             Image.asset(
            theimage,
            width: 50,
            height: 50,
          ),
          SizedBox(height: 5),
          text("$thename",
              textColor: AppColors.shadowdarkblack,
              fontSize: AppFontSize.textSizeSMedium,
              fontFamily: AppFontSize.montbold,
              maxLine: 3),
          text("$therate₦/\$",
              fontSize: AppFontSize.textSizeMedium,
              fontFamily: AppFontSize.cooperaterunded),
        ],
      ),
    );
  }

  Future<void> userInfo() async {

    if (mounted) {
      var getrate = await systemapi.allsellrate();
      if (getrate != null) {
        if(mounted){
        setState(() {
          paxful = getrate.paxful;
          blockchain = getrate.blockchain;
          uni = getrate.universal;
          eth = getrate.eth;
          bch = getrate.bch;
          usdc = getrate.usdc;
          litecoin = getrate.ltc;
          dai = getrate.dai;
          doge = getrate.doge;
          pm = getrate.pm.toString();
        });
        }
      }
    }

    final prefs = await StreamingSharedPreferences.instance;
    var storeddetails = MyAppSettings(prefs);
    if (mounted) {
      setState(() {
        activepax = storeddetails.activepax.getValue();
      });
    }

  }

  checkmyinternet() {
    functionfile.isInternet().then((value) =>
        functionfile.checkInternetAccess().then((value2) => value && value2
            ? setState(() {
                sendme = true;
              })
            : setState(() {
                sendme = false;
              })));
  }
}
