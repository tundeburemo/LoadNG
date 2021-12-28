import 'package:flutter/material.dart';
import 'package:loadng/model/bizsuit/userwalletlist.dart';
import 'package:loadng/services/apis/bizsuitapi.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:loadng/services/apis/system.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadng/model/system/NewCoinsList.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/model/system/biz2coinlist.dart';


var systemapi = locator<SystemApi>();
var bizsuitapi = locator<BizSuitApi>();
var functionfile = locator<CustomFunction>();

class BizCoinList extends StatefulWidget {
  static var tag = "/bizcoinslist";

  @override
  BizCoinListState createState() => BizCoinListState();
}

class BizCoinListState extends State<BizCoinList> {
  int selectedPos = 1;
  @override
  void initState() {
    checkmyinternet();
    internetcheck();
    super.initState();
    selectedPos = 1;
  }

  Future allnewcoins;
  Future allbiz2coins;
  Future allbizsuitcoins;


  internetcheck() async {
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    if (theinternet && theinternet2) {
      setState(() {
        allnewcoins = systemapi.bizcoinslist();
         allbiz2coins =systemapi.biz2coinslist();
         allbizsuitcoins=bizsuitapi.userwalletlist();
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
                appBarwithlink(context, "LoadNG Business","/userdashboard"),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20.0,top: 10),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                  children: [
                    text("Sell Coins",
                        textColor: AppColors.shadowdarkblack,
                        fontFamily: AppFontSize.montbold,
                        fontSize: AppFontSize.textSizeNormal),
                                GestureDetector(
                                  onTap:(){
           Navigator.of(context).pushNamed('/AddBizSuitWallet');
                                  },
                                  child: Container(
                                    height:32,
                                    decoration: BoxDecoration(
                                      border:Border.all(width: 1,color:Color(0xfffae6fb)),
                                      borderRadius:BorderRadius.circular(10),
                                    color:Color(0xfffae6fb),
                                
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5.0),
                                      child: text("Add New Wallet",
                                                        textColor: Colors.black26,
                                                        fontFamily: AppFontSize.montbold,
                                                        fontSize:9.0),
                                    ),
                                  ),
                                ),
                  ],
                ),
              ),
          
              Container(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10,top:10),
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
                                      childAspectRatio: gtserv.data.coins.length==1?2.1:1.0,
                                        crossAxisCount:gtserv.data.coins.length==1?1: 2,
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
                                  theimage = AppImage.cashapp;
                                  thenavlink = "/sellbiz";
                                  thetrackid= coinlist.trackid;
                                  theaddress= coinlist.address;

 

                                  return GestureDetector(
                                      onTap: () {

                                        


                                        if (sendme &&
                                            therate != "0" &&
                                            therate != 0) {
                                          var txtdialog = " ";
                                          txtdialog = "LoadNG Business allows you to always send Cryptocurrency to a particular wallet without having to login to your LoadNG account everytime. The system identifies your inputs and pays you immediately with respect to the present rate on the system at that time. Thanks for using LoadNG.";
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
                                          functionfile.showerror(context);
                                        }
                                      
                                      },
                                      child: coinSellLayer(thehexcode, theimage,
                                          "Main Business Wallet", therate,coinname:thename ));
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
              ),// new coin
     Container(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20, bottom: 10),
                child: FutureBuilder<UserBizSuitWalletList>(
                  future: allbizsuitcoins,
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
                                      childAspectRatio: gtserv.data.coins.length==1?2.1:0.8,
                                        crossAxisCount:gtserv.data.coins.length==1?1: 2,
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
                                  thename = coinlist.nameofwallet;
                                  therate = coinlist.walletrate;
                                  theimage = AppImage.cashapp;
                                  thenavlink = "/SellBizSuit";
                                  thetrackid= coinlist.wallletid;
                                  theaddress= coinlist.address;
                                  var thebnkaccno=coinlist.bankaccno;
                                  var thebankname=coinlist.bankname;
                                  var thecoinname= coinlist.coinname;
                                  var thecolorcode= coinlist.colorcode;


                                  return GestureDetector(
                                      onTap: () {

                                        if (sendme &&
                                            therate != "0" &&
                                            therate != 0) {
                                          var txtdialog = " ";
                                          txtdialog = "LoadNG Business allows you to always send Cryptocurrency to a particular wallet without having to login to your LoadNG account everytime. The system identifies your inputs and pays you immediately with respect to the present rate on the system at that time. Thanks for using LoadNG.";
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
                                                      theaddress:theaddress,
                                                      thebnkaccno:thebnkaccno,
                                                      thebankname:thebankname,
                                                      thecoinname:thecoinname,
                                                      thecolorcode:thecolorcode
                                                      
                                                      ));
                                        } else {
                                          functionfile.showerror(context);
                                        }
                                      
                                      },
                                      child: coinSellLayer(thehexcode, theimage,
                                          thename, therate,coinname:thecoinname ));
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
                                      childAspectRatio: gtserv.data.coins.length==1?2.1:1.0,
                                        crossAxisCount:gtserv.data.coins.length==1?1: 2,
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
                                          internetcheck();
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




            ],
          ),
        ));
  }

  Container coinSellLayer(thehexcode, theimage, thename, therate,{theimagetype=0,coinname=""}) {
    return  Container(
      padding: EdgeInsets.only(left: 16, right: 16),
      decoration: boxDecoration(
          radius: 16,
          showShadow: true,
          color: Color(thehexcode),
          bgColor: Color(thehexcode)),
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
theimagetype==1?
        Center(child:  Image.network(
            theimage,
            width: 50,
            height: 50,
          )):
           Center(child:  Image.asset(
            theimage,
            width: 50,
            height: 50,
          )),
          SizedBox(height: 5),
         Center(child: 
         Column(
           children: [
             text("$thename",
                  textColor: AppColors.shadowdarkblack,
                  fontSize: AppFontSize.textSizeSMedium,
                  fontFamily: AppFontSize.montbold,
                  maxLine: 1,
                  isCentered: true),
                  coinname!=""?
                    text("$coinname",
                  textColor: AppColors.shadowdarkblack,
                  fontSize: AppFontSize.textSizeSmall,
                  fontFamily: AppFontSize.montbold,
                  maxLine: 1,
                  isCentered: true):Container(),
           ],
         )
              ),
          Center(child:text("$therate₦/\$",
              fontSize: AppFontSize.textSizeMedium,
              fontFamily: AppFontSize.cooperaterunded, isCentered: true)),
        ],
      )),
    );
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
