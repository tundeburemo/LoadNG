import 'package:flutter/material.dart';
import 'package:loadng/model/sell/biz2walletlist.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter/services.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:qr_flutter/qr_flutter.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/services/apis/bank.dart';
import 'package:loadng/services/apis/sell.dart';

var sellapi = locator<SellApi>();
var functionfile = locator<CustomFunction>();
var bankapi = locator<BankApi>();

// ignore: must_be_immutable
class SellBiz2 extends StatefulWidget {
  static var tag = "/sellbiz";
  String name;
  String image;
  String rate;
  int thecolors;
  String thetype;
  final RouteArgument routeArgument;

  SellBiz2({Key key, @required this.routeArgument}) {
    name = this.routeArgument.argumentsList[0] as String;
    image = this.routeArgument.argumentsList[1] as String;
    rate = this.routeArgument.argumentsList[2] as String;
    thecolors = this.routeArgument.argumentsList[3];
    thetype = this.routeArgument.argumentsList[4] as String;
  }
  @override
  SellBiz2State createState() => SellBiz2State();
}

// 9014
class SellBiz2State extends State<SellBiz2> with SingleTickerProviderStateMixin {
  TabController _controller;
  int _selectedInde=0;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  var totalcoins = 0;

  var coinwallet = " ";
  var coinname = "";
  var coinrate = "";
  var coincolor = 0xfffae6fb;
  var coinimg = "";
  var memo="";
  var alldatasentin;
  var allnamessent=[];
  List<Widget> alldatalist = [];

activatetab(totalcoins){
    _controller= new TabController(length: totalcoins, vsync: this);
 
  _controller.addListener(() {
    setState(() {
          _selectedInde=_controller.index;
        });
        // do wnt u wnt on d index here
  });
}
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return totalcoins >1
        ? 
  //        DefaultTabController(
  // length:  totalcoins,
  // child:  
  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appIconTint_mustard_yellow,//Color(widget.thecolors),
        centerTitle: true,
        bottom: TabBar(
          isScrollable: true,
          controller: _controller,
          indicatorColor: Colors.grey,
          labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
          onTap: (index) {
           // Tab index when user select it, it start from zero
          },
          tabs: [
            for(var datain in allnamessent)
                  Tab(text:datain),
                  // Tab(text:"USDT ERC"),
          ],
        ),
        title: Text('Sell ${widget.name}'),
      ),
      body: TabBarView(
          controller: _controller,
          
        children:alldatalist 
    ),
)
        : Scaffold(
            key: _key,
            appBar: appBar(context, "Sell $coinname"),
            body: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
                    decoration: boxDecoration(
                        showShadow: true, bgColor: Color(coincolor)),
                    child: Column(
                      children: <Widget>[
                        coinimg!=""?
                        Container(
                          decoration: boxDecoration(
                              showShadow: true,
                              bgColor: Color(coincolor),
                              radius: AppFontSize.spacing_standard),
                          child: 
                          Image.network(
                            coinimg,
                            width: 50,
                            height: 50,
                          ).paddingAll(AppFontSize.spacing_standard_new),
                        ):Container(),
                        toolBarTitle("Rate: $coinrate")
                            .paddingTop(AppFontSize.spacing_standard_new),
                        text("$coinname",
                                fontFamily: AppFontSize.spinnaker,
                                fontSize: AppFontSize.textSizeSMedium)
                            .paddingTop(AppFontSize.spacing_standard),
                        text(" Below is your dedicated $coinname wallet address. You can send to the wallet anytime.",
                                maxLine: 9,
                                isCentered: true,
                                fontSize: AppFontSize.textSizeMedium,
                                fontFamily: AppFontSize.spinnaker)
                            .paddingTop(AppFontSize.spacing_control),
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new),
                  ),
                  text("Wallet Address(Tap To Copy)",
                      textColor: AppColors.shadowdarkblack2,
                      fontSize: AppFontSize.textSizeSMedium),
                  GestureDetector(
                      onTap: () {
                        Clipboard.setData(
                          new ClipboardData(text: '$coinwallet'),
                        );
                        toast("$coinwallet Address Copied to Clipboard");
                      },
                      child: Container(
                          color: AppColors.t12_edittext_background,
                          child: Text(
                            "$coinwallet",
                            style: TextStyle(
                                color: AppColors.shadowdarkblack2,
                                fontSize: 15.0),
                            maxLines: 3,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ).paddingAll(10))),

                          memo.length>0&&memo.isNotEmpty?Column(
     children: [
       text("Wallet Memo(Tap To Copy)",
                          textColor: AppColors.shadowdarkblack2,
                          fontSize: AppFontSize.textSizeSMedium),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                          onTap: () {
                            // Clipboard.setData(
                            //   new ClipboardData(text: '$coinwallet'),
                            // );
                            // toast("$coinwallet Address Copied to Clipboard");
Clipboard.setData(
                              new ClipboardData(text: '$memo'),
                            );
                            toast("$memo Address memo Copied to Clipboard");
                            
                          },
                          child: Container(
                              color: AppColors.t12_edittext_background,
                              child: Text(
                                "$memo",
                                style: TextStyle(
                                    color: AppColors.shadowdarkblack2,
                                    fontSize: 15.0),
                                maxLines: 3,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ).paddingAll(10))),
     ],
   ):Container(),


                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
                    decoration: boxDecoration(
                        showShadow: true, bgColor: Color(coincolor)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: boxDecoration(
                              showShadow: true,
                              bgColor: Color(coincolor),
                              radius: AppFontSize.spacing_standard),
                          child: (coinwallet != null && coinwallet != " "
                              ? QrImage(
                                  data: "$coinwallet",
                                  version: QrVersions.auto,
                                  size: 200.0,
                                )
                              : Container(
                                  child: text("Sorry QR Code not available now",
                                      textColor: AppColors.shadowdarkblack2),
                                )),
                        ),
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  decoration: boxDecoration(
                                      showShadow: true,
                                      radius: AppFontSize.spacing_standard),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.asset(
                                        AppImage.t12_tick,
                                        width: 90,
                                        height: 90,
                                      ).paddingTop(50),
                                      toolBarTitle("Processing").paddingTop(
                                          AppFontSize.spacing_large),
                                      text("Your selected bank account shall be credited automatically after 1 confirmation. Click history below to monitor your incoming transactions.",
                                              maxLine: 8,
                                              isCentered: true,
                                              fontSize:
                                                  AppFontSize.textSizeMedium,
                                              fontFamily: AppFontSize.spinnaker)
                                          .paddingTop(
                                              AppFontSize.spacing_control),
                                      // text("Transaction ID: $transid",textColor: AppColors.shadowdarkblack,fontSize: AppFontSize.textSizeMedium).paddingTop(AppFontSize.spacing_standard_new).paddingBottom(70),
                                      SizedBox(
                                        width: double.infinity,
                                        child: MaterialButton(
                                          padding: EdgeInsets.only(
                                              top: AppFontSize
                                                  .spacing_standard_new,
                                              bottom: AppFontSize
                                                  .spacing_standard_new),
                                          child: text("GO TO HISTORY",
                                              textColor: Colors.white,
                                              fontFamily:
                                                  AppFontSize.fontMedium,
                                              maxLine: 2),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      AppFontSize
                                                          .spacing_standard)),
                                          color: AppColors.t12_primary_color,
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.of(context)
                                                .pushNamed('/userhistory');
                                          },
                                        ),
                                      ).paddingAll(
                                          AppFontSize.spacing_standard_new)
                                    ],
                                  ).paddingAll(
                                      AppFontSize.spacing_standard_new),
                                ),
                              ));
                    },
                    child: Container(
                      // margin: EdgeInsets.only(right: 16),
                      alignment: Alignment.center,
                      height: width / 8,
                      child: text("I Have Sent",
                          textColor: AppColors.realblack, isCentered: true),
                      decoration:
                          boxDecoration(bgColor: Color(coincolor), radius: 8),
                    ),
                  ),
                ],
              ),
            ),
          )
         ;
  }

  @override
  void initState() {
    userInfo();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> userInfo() async {
    await Future.delayed(Duration(seconds: 1));
    // _key.currentState.openDrawer();
     var width = MediaQuery.of(context).size.width;
    functionfile.onHorizontalLoading1(context);

    Biz2walletList getrate;
    if (mounted) {
   getrate = await sellapi.sellbiz2(cointype: widget.thetype);
 
      if (getrate == null) {
        Navigator.of(context).pop();
        functionfile.showerror(context);
      } else {

if(getrate.wallet!=null){
        setState(() {
          alldatasentin=getrate;
          totalcoins = getrate.wallet.length;
        });
        activatetab(totalcoins);
        if(totalcoins==1){
            setState(() {
            coinwallet =getrate.wallet[0].address;
            coinname = getrate.wallet[0].coinname;
            coinrate = "${getrate.wallet[0].rate}";
            coincolor = widget.thecolors;
            coinimg = getrate.wallet[0].theimage;
            memo= getrate.wallet[0].memo;
        });
        }else{ 
          for(var i=0;i< totalcoins;i++){
            allnamessent.add(getrate.wallet[i].coinname);
          coinwallet =getrate.wallet[i].address;
          coinname = getrate.wallet[i].coinname;
          coinrate = "${getrate.wallet[i].rate}";
          coincolor =  functionfile.hexToInt("${getrate.wallet[i].colorcode}");//widget.thecolors;
          coinimg = getrate.wallet[i].theimage;
            memo= getrate.wallet[i].memo.trim();
            alldatalist.add( Center(
              child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
                    decoration: boxDecoration(
                        showShadow: true, bgColor: Color(coincolor)),
                    child: Column(
                      children: <Widget>[
                        coinimg!=""?
                        Container(
                          decoration: boxDecoration(
                              showShadow: true,
                              bgColor: Color(coincolor),
                              radius: AppFontSize.spacing_standard),
                          child: 
                          Image.network(
                            coinimg,
                            width: 50,
                            height: 50,
                          ).paddingAll(AppFontSize.spacing_standard_new),
                        ):Container(),
                        toolBarTitle("Rate: $coinrate")
                            .paddingTop(AppFontSize.spacing_standard_new),
                        text("$coinname",
                                fontFamily: AppFontSize.spinnaker,
                                fontSize: AppFontSize.textSizeSMedium)
                            .paddingTop(AppFontSize.spacing_standard),
                        text(" Below is your dedicated $coinname wallet address. You can send to the wallet anytime.",
                                maxLine: 9,
                                isCentered: true,
                                textColor: Colors.black26,
                                fontSize: AppFontSize.textSizeMedium,
                                fontFamily: AppFontSize.spinnaker)
                            .paddingTop(AppFontSize.spacing_control),
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new),
                  ),
                  text("Wallet Address(Tap To Copy)",
                      textColor: AppColors.shadowdarkblack2,
                      fontSize: AppFontSize.textSizeSMedium),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                      onTap: () {
                        // Clipboard.setData(
                        //   new ClipboardData(text: '$coinwallet'),
                        // );
                        // toast("$coinwallet Address Copied to Clipboard");
Clipboard.setData(
                          new ClipboardData(text: '${alldatasentin.wallet[_selectedInde].address}'),
                        );
                        toast("${alldatasentin.wallet[_selectedInde].address} Address Copied to Clipboard");
                        
                      },
                      child: Container(
                          color: AppColors.t12_edittext_background,
                          child: Text(
                            "$coinwallet",
                            style: TextStyle(
                                color: AppColors.shadowdarkblack2,
                                fontSize: 15.0),
                            maxLines: 3,
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ).paddingAll(10))),

memo.length>0&&memo.isNotEmpty?Column(
     children: [
       text("Wallet Memo(Tap To Copy)",
                          textColor: AppColors.shadowdarkblack2,
                          fontSize: AppFontSize.textSizeSMedium),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                          onTap: () {
                            // Clipboard.setData(
                            //   new ClipboardData(text: '$coinwallet'),
                            // );
                            // toast("$coinwallet Address Copied to Clipboard");
Clipboard.setData(
                              new ClipboardData(text: '${alldatasentin.wallet[_selectedInde].memo}'),
                            );
                            toast("${alldatasentin.wallet[_selectedInde].memo} Address memo Copied to Clipboard");
                            
                          },
                          child: Container(
                              color: AppColors.t12_edittext_background,
                              child: Text(
                                "$memo",
                                style: TextStyle(
                                    color: AppColors.shadowdarkblack2,
                                    fontSize: 15.0),
                                maxLines: 3,
                                softWrap: true,
                                textAlign: TextAlign.center,
                              ).paddingAll(10))),
     ],
   ):Container(),


                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
                    decoration: boxDecoration(
                        showShadow: true, bgColor:Color(coincolor)),
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: boxDecoration(
                              showShadow: true,
                              bgColor: Color(coincolor),
                              radius: AppFontSize.spacing_standard),
                          child: (coinwallet != null && coinwallet != " "
                              ? QrImage(
                                  data: "$coinwallet",
                                  version: QrVersions.auto,
                                  size: 200.0,
                                )
                              : Container(
                                  child: text("Sorry QR Code not available now",
                                      textColor: AppColors.shadowdarkblack2),
                                )),
                        ),
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => Dialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 0.0,
                                backgroundColor: Colors.transparent,
                                child: Container(
                                  decoration: boxDecoration(
                                      showShadow: true,
                                      radius: AppFontSize.spacing_standard),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Image.asset(
                                        AppImage.t12_tick,
                                        width: 90,
                                        height: 90,
                                      ).paddingTop(50),
                                      toolBarTitle("Processing").paddingTop(
                                          AppFontSize.spacing_large),
                                      text("Your selected bank account shall be credited automatically after 1 confirmation. Click history below to monitor your incoming transactions.",
                                              maxLine: 8,
                                              isCentered: true,
                                              fontSize:
                                                  AppFontSize.textSizeMedium,
                                              fontFamily: AppFontSize.spinnaker)
                                          .paddingTop(
                                              AppFontSize.spacing_control),
                                      // text("Transaction ID: $transid",textColor: AppColors.shadowdarkblack,fontSize: AppFontSize.textSizeMedium).paddingTop(AppFontSize.spacing_standard_new).paddingBottom(70),
                                      SizedBox(
                                        width: double.infinity,
                                        child: MaterialButton(
                                          padding: EdgeInsets.only(
                                              top: AppFontSize
                                                  .spacing_standard_new,
                                              bottom: AppFontSize
                                                  .spacing_standard_new),
                                          child: text("GO TO HISTORY",
                                              textColor: Colors.white,
                                              fontFamily:
                                                  AppFontSize.fontMedium,
                                              maxLine: 2),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      AppFontSize
                                                          .spacing_standard)),
                                          color: AppColors.t12_primary_color,
                                          onPressed: () {
                                            Navigator.pop(context);
                                            Navigator.of(context)
                                                .pushNamed('/userhistory');
                                          },
                                        ),
                                      ).paddingAll(
                                          AppFontSize.spacing_standard_new)
                                    ],
                                  ).paddingAll(
                                      AppFontSize.spacing_standard_new),
                                ),
                              )); 
                    },
                    child: Container(
                      // margin: EdgeInsets.only(right: 16),
                      alignment: Alignment.center,
                      height: width / 8,
                      child: text("I Have Sent",
                          textColor: AppColors.realblack, isCentered: true),
                      decoration:
                          boxDecoration(bgColor: Color(coincolor), radius: 8),
                    ),
                  ),
                ],
              ),
            ),),);
          }
          


        }
          Navigator.of(context).pop();


        if (getrate.wallet.isEmpty ||
            getrate.wallet == null ||
            getrate.wallet == []) {
          Navigator.of(context).pop();
          var txtdialog = "Sorry Service Currently Not Available";
          showDialog(
              context: context,
              builder: (BuildContext context) => CustomInfo(
                  sentimg: widget.image,
                  senttxt: txtdialog,
                  thename: widget.name,
                  therate: widget.rate,
                  thehexcode: widget.thecolors,
                  thenavlink: "/coinslist",
                  thetype: 0));
        }
      }else{
 Navigator.of(context).pop();
        functionfile.showerror(context);
      }


      }
    }
  }
}
