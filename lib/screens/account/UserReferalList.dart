import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/services/apis/history.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/model/account/UserReferals.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:loadng/utils/dots_indicator/dots_indicator.dart';
import 'dart:io';
import 'package:loadng/model/history/AllSellHistory.dart';
import 'package:loadng/model/history/pointhistory.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import "package:loadng/model/system/route_argument.dart";


var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
var historyapi = locator<HistoryApi>();

class UserReferalList extends StatefulWidget {
   final RouteArgument routeArgument;
  static String tag = '/userreferals';
  int pageno=0;
   UserReferalList({Key key,@required this.routeArgument }) {
    pageno= this.routeArgument.argumentsList[0] as int;
  }
  @override
  UserReferalListState createState() => UserReferalListState();
}

class UserReferalListState extends State<UserReferalList> with SingleTickerProviderStateMixin {
  TabController _controller;
  //   int dindex=0;
  // UserReferalListState({dindex});
  int _selectedInde=0;
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  int currentIndexPage = 0;
  int pageLength;
  Future allreferals;
  Future allincome;
  Future allwithdrawal;
  var coinspaid=0;
  var totalrefrred=0;
    var username ="";
  var email= "";
  var mainacc= "";

activatetab(){
    _controller= new TabController(length: 3, vsync: this);

  _controller.addListener(() {
    setState(() {
          _selectedInde=_controller.index;
        });
        // do wnt u wnt on d index here
  });
}

  @override
  void initState() { 
    activatetab();
    internetcheck();
     _controller.index=widget.pageno;
    userInfo() ;
    super.initState();
    currentIndexPage = 0;
    pageLength = 3;
  }

            internetcheck() async{
      var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

      if (theinternet && theinternet2) {
         setState(() {
    allwithdrawal=historyapi.allwithdrawalhistory(pg:1,search:" ");
     allincome=historyapi.pointhistory();
    allreferals=accountapi.userreferals();

         });
      }else{
      functionfile.showerror(context);
      }
  }
  var position = 0;
  var totalpoint = "0";
  var reflink = "";
  var refpoint = 0;
  var salepoint = 0;
  var buypoint = 0;
 
  @override
  Widget build(BuildContext context) {
   functionfile.changeStatusColor(Colors.transparent);
       var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    var cardHight = (width - 48) * (9 / 16);
      var slider = Container(
      // height: cardHight,
      margin: EdgeInsets.only(top: 8),
      child: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              height: cardHight,
              child: PageView.builder(
                itemCount: 3,
                itemBuilder: (context, index) {
                  // LoadNG wallet,Refill,Bill,Coin
                  var walletname, walletbalance;
                  if (index == 0) {
                    walletname = "Total Points";
                    walletbalance = "$totalpoint";
                  } else if (index == 1) {
                    walletname = "Referral Points";
                    walletbalance = "$refpoint";
                  } else if (index == 2) {
                    walletname = "Sale Points";
                    walletbalance = "$salepoint";
                  } else if (index == 3) {
                    walletname = "Buy Points";
                    walletbalance = "$buypoint";
                  }
        
                  return referalCards(
                      walletname: walletname,
                      cardHight: cardHight,
                      index: index,
                      walletbalance: walletbalance,
                      context: context,
                      reflink:reflink,
                      ontap: () {
                              withdrawl(); 
                              } );
                },
                onPageChanged: (index) {
                  setState(() {
                    position = index;
                  });
                },
              ),
            ),
          ),
          DotsIndicator(
            dotsCount: 3,
            position: position,
            decorator: DotsDecorator(
                color: AppColors.t12_text_secondary.withOpacity(0.15),
                activeColor: AppColors.t12_primary_color,
                activeSize: Size.square(AppFontSize.spacing_middle),
                spacing: EdgeInsets.all(3)),
          ).paddingAll(AppFontSize.spacing_standard)
        ],
      )
    ).paddingOnly(
        left: AppFontSize.spacing_standard_new,
        right: AppFontSize.spacing_standard_new);

    return Scaffold(
        body:

        
        CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child:
         TopBar(titleName: "My Points",),

          ),

  SliverToBoxAdapter(
            child:
       Container(
         height:200,
         child:slider),

          ),

(reflink!=""?
            SliverToBoxAdapter(
            child:
           Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
         text("Referral Link(Tap To Copy)",textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeSMedium),

          GestureDetector(
  onTap: () {
                              Clipboard.setData(
                                new ClipboardData(
                                    text: '$reflink'),
                              );
                              toast("$reflink  Copied to Clipboard");
                            },
  child: Container(
    color: AppColors.t12_edittext_background,
  child: Text("$reflink",style:TextStyle(color: AppColors.shadowdarkblack2,fontSize: 11.0),maxLines: 3,softWrap: true,textAlign: TextAlign.center,).paddingAll(10))),
                              ])
          ):SliverToBoxAdapter(
            child: 
        Container())),
      
       
        
         SliverToBoxAdapter(
            child: 
        Container(
              width: MediaQuery.of(context).size.width,
    child:
       Column( 
         crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
      
              TabBar(
          isScrollable: true,
          controller: _controller,
          indicatorColor: Colors.grey,
          labelColor: Colors.black87,
          labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
          onTap: (index) {
           setState(() {
             _controller.index=index;
                        widget.pageno=index;
                      });
          },
          tabs: [
            Tab(text:"Income"),
            Tab(text:"Withdrawal"),
            Tab(text:"My Referrals"),
          ],
        ),
// dindex
(widget.pageno==0? 
            Container(
            child:  FutureBuilder<PointHistory>(
                    future:allincome,
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
                              'Point not found, try again!',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ));
                          } else if (gtserv.hasData) {
                            if (gtserv.data.data==null || gtserv.data.data.isEmpty) {
                              return Center(
                                  child: Text('No point yet',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                      )));
                            } else {
                              return  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: gtserv.data.data.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {


                    var userdata=gtserv.data.data[index];
                  
                    return  Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                width: double.infinity,
                child: DashboardList(
                  name: '${userdata.actiontxt}',
                  status: "${userdata.cointype}",
                  color: AppColors.appColorPrimary,
                  amount: '+ ${userdata.amt} Points',
                  // icon: Icons.call_made,//activate dis for not paid
                  // colors: Colors.red,
                  // iconcolor: Colors.red,
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
      // ),

 ):
             Container()
             ),
(widget.pageno==1?
               Container(
            child:  FutureBuilder<UserAllSellHistory>(
                    future: allwithdrawal,
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
                              'Data not found, try again!',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ));
                          } else if (gtserv.hasData) {
                            if (gtserv.data.history==null || gtserv.data.history.isEmpty) {
                              return Center(
                                  child: Text('No data yet',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                      )));
                            } else {
                              return  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: gtserv.data.history.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {


                    var userdata=gtserv.data.history[index];
                  
                    return  Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                width: double.infinity,
                child: DashboardList(
                  name: '${userdata.name}',
                  status: '${userdata.date}',
                  color: AppColors.appDarkRed,
                  amount: '- ${userdata.nairavalue} Points',
                  amountnaira:'~ ${userdata.usdvalue} ₦',
                  iconcolor:userdata.statusnumber==1?Colors.green:AppColors.appDarkRed,
                  colors: userdata.statusnumber==1?Colors.green:AppColors.appDarkRed,
                  // icon: Icons.call_made,//activate dis for not paid
                  // colors: Colors.red,
                  // iconcolor: Colors.red,
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

 ): 
             Container()
            ),

(widget.pageno==2?
             Container(
             child:  FutureBuilder<UserReferalModel>(
                    future: allreferals,
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
                              'Referrals not found, try again!',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ));
                          } else if (gtserv.hasData) {
                            if (gtserv.data.users==null || gtserv.data.users.isEmpty) {
                              return Center(
                                  child: Text('No referrals yet',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                      )));
                            } else {
                              return  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: gtserv.data.users.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {


                    var userdata=gtserv.data.users[index];
                    var paytxt="Not Paid";
                    if(userdata.paid==1){
                      paytxt="Payment Received";
                    }
                    return  Container(
                padding: EdgeInsets.symmetric(vertical: 5.0),
                width: double.infinity,
                child: DashboardList(
                  name: '${userdata.username}',
                  status: '$paytxt',
                  color: AppColors.appColorPrimary,
                  amount:userdata.paid==1? '+ ${userdata.amtpaid} Points':'+ 0 Point',
                  // icon: Icons.call_made,//activate dis for not paid
                  colors:userdata.paid==1?Colors.green : Colors.red,
                  iconcolor:userdata.paid==1? Colors.green: Colors.red,
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
 ): 
             Container()
            ),


        ],
      ),
  )
        )])
    );
  }

        Future<void> userInfo() async {
        final prefs = await StreamingSharedPreferences.instance;
    var storeddetails = MyAppSettings(prefs);
    if(mounted){
    setState(() {
      username= storeddetails.dusername.getValue();
    });
    var getbanks = await accountapi.userreferals();
    if(getbanks!=null){
setState(() {
     coinspaid=getbanks.totalpaid;
totalrefrred=getbanks.total; 
  });
    }
      var getnewdata = await accountapi.usersecdetails();
if(getnewdata!=null){
setState(() {
    totalpoint = getnewdata.maintotalpoints;
    refpoint = getnewdata.refpoint;
    salepoint = getnewdata.sellpoint;
    buypoint = getnewdata.buypoint;
    reflink =getnewdata.referallink;
   });
    }
    }

    

  }

  withdrawl() async {
     functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
   
          var v = await accountapi.userwithdrawcoin().timeout(Duration(seconds: 30), onTimeout: () {
            Navigator.of(context).pop(); 
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
                           
              Navigator.of(context).pop(); 
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
        showShadow: true, radius: AppFontSize.spacing_standard),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
     
        toolBarTitle("Message",
        textColor: AppColors.appLight_parrot_green)
        .paddingTop(AppFontSize.spacing_large),
        text(v.msg,
        maxLine: 18,
        isCentered: true,
        fontSize: AppFontSize.textSizeSMedium,
        fontFamily: AppFontSize.spinnaker)
        .paddingTop(AppFontSize.spacing_control),
        SizedBox(
        width: double.infinity,
        child: MaterialButton(
        padding: EdgeInsets.only(
        top: AppFontSize.spacing_standard_new,
        bottom: AppFontSize.spacing_standard_new),
        child: text("OK",
        textColor: Colors.white,
        fontFamily: AppFontSize.fontMedium,
        maxLine: 2),
        shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(
        AppFontSize.spacing_standard)),
        color: AppColors.t12_primary_color,
        onPressed: () {
        Navigator.pop(context);
        },
        ),
        ).paddingAll(AppFontSize.spacing_standard_new)
        ],
        ).paddingAll(AppFontSize.spacing_standard_new),
        ),
        ));
            // toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
       internetcheck();
       userInfo();
           
          }else{
            Navigator.of(context).pop(); 
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
        showShadow: true, radius: AppFontSize.spacing_standard),
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
     
        toolBarTitle("Message",
        textColor: AppColors.appLight_parrot_green)
        .paddingTop(AppFontSize.spacing_large),
        text(v.msg,
        maxLine: 18,
        isCentered: true,
        fontSize: AppFontSize.textSizeSMedium,
        fontFamily: AppFontSize.spinnaker)
        .paddingTop(AppFontSize.spacing_control),
        SizedBox(
        width: double.infinity,
        child: MaterialButton(
        padding: EdgeInsets.only(
        top: AppFontSize.spacing_standard_new,
        bottom: AppFontSize.spacing_standard_new),
        child: text("OK",
        textColor: Colors.white,
        fontFamily: AppFontSize.fontMedium,
        maxLine: 2),
        shape: RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(
        AppFontSize.spacing_standard)),
        color: AppColors.t12_primary_color,
        onPressed: () {
        Navigator.pop(context);
        },
        ),
        ).paddingAll(AppFontSize.spacing_standard_new)
        ],
        ).paddingAll(AppFontSize.spacing_standard_new),
        ),
        ));
            //  toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
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


