import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:loadng/services/apis/buycoin.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadng/model/system/NewCoinsList.dart';
import 'package:flutter/rendering.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:flutter/widgets.dart';



var buycoinapi = locator<BuyCoins>();
var functionfile = locator<CustomFunction>();

class BuyCoinList extends StatefulWidget {
  static var tag = "/buycoinslist";

  @override
  BuyCoinListState createState() => BuyCoinListState();
}

class BuyCoinListState extends State<BuyCoinList> {
  int selectedPos = 1;
 int providusacc;
  @override
  void initState() {
    checkmyinternet();
    internetcheck();
    userInfo();
    super.initState();
    selectedPos = 1;
  }

  Future allnewcoins;

  internetcheck() async {
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    if (theinternet && theinternet2) {
      setState(() {
        allnewcoins = buycoinapi.allbuycoins();
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
                appBarwithlink(context, "Buy Coins","/userdashboard"),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, top: 10),
                child: text("Buy",
                    textColor: AppColors.shadowdarkblack,
                    fontFamily: AppFontSize.montbold,
                    fontSize: AppFontSize.textSizeNormal),
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
                                  theimage = AppImage.cashapp;
                                  thenavlink = "/buycoinorder";
                                  thetrackid= coinlist.trackid;
                                  theaddress= coinlist.address;

 

                                  return GestureDetector(
                                      onTap: () {
if(providusacc==0||providusacc==null){
   showDialog( 
          context: context,
          builder: (context) => new AlertDialog(
            title:  Text('FILL KYC',
                style:  TextStyle(color: Colors.black, fontSize: 20.0)),
            content:  Text(
                'To buy coins on LoadNG, you must first fill out your KYC information and get it approved by clicking the button below.'),
            actions: <Widget>[
           Material(
              color:AppColors.shadowdarkblack2,
              child: FlatButton( 
                onPressed: () =>
                    Navigator.of(context).pushNamed('/useraccount'), // this line dismisses the dialog
                child: new Text('GO TO SETTINGS', style: TextStyle(fontSize: 14.0,color: Colors.white)),
              ))
            ],
          ),
        );
}else{

                                        if (sendme &&
                                            therate != "0" &&
                                            therate != 0) {
                                          var txtdialog = " ";
                                          txtdialog = "The LoadNG Buy Coins system allows you to buy Cryptocurrency into external wallets. Ensure you double-check the wallet you are sending to since all blockchain transactions are irreversible.";
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

  Container coinSellLayer(thehexcode, theimage, thename, therate) {
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
  final prefs = await StreamingSharedPreferences.instance;
    var storeddetails = MyAppSettings(prefs);
    if(mounted){
    setState(() {
      providusacc=storeddetails.dprovidusaccno.getValue();

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
