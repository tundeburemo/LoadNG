// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:loadng/utils/dots_indicator/dots_indicator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:loadng/styles/AppFontSizes.dart';
// import 'package:loadng/styles/AppColors.dart';
// import 'package:loadng/styles/AppImage.dart';
// import 'package:loadng/screens/Drawer.dart';
// import 'package:loadng/utils/customFunction.dart';
// import 'package:loadng/widgets/loginScreen.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/widgets.dart';
// import 'package:loadng/locator.dart';
// import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
// import 'package:loadng/services/appSettings.dart';
// import 'package:intl/intl.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:loadng/model/history/RecentHistory.dart';
// import 'package:loadng/services/apis/history.dart';
// import 'package:loadng/services/apis/account.dart';
// import 'package:pull_to_refresh/pull_to_refresh.dart';
// import 'package:loadng/services/apis/system.dart';
// import 'dart:io';
// import "package:loadng/model/system/route_argument.dart";
// import 'package:loadng/styles/AppText.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';

// var functionfile = locator<CustomFunction>();
// var historyapi = locator<HistoryApi>();
// var accountapi = locator<AccountApi>();
// var systemapi = locator<SystemApi>();

// class UserDashboard extends StatefulWidget {
//   static String tag = '/userdashboard';

//   @override
//   UserDashboardState createState() => UserDashboardState();
// }

// class UserDashboardState extends State<UserDashboard> {
//   final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//   bool _enablePullDown = true, chinternet = true;
//   RefreshController _refreshController;
//   final FirebaseMessaging _firebaseMessaging =  FirebaseMessaging.instance;
//   int currentPage = 0;
//   // final oCcy = new NumberFormat("#,##0.00", "en_US");
//   final oCcy = new NumberFormat("#,##0.00", "en_US"); 
//   var position = 0;
//   var username = " ";
//   var mainbal = " ";
//   var billbal;
//   var refillbal;
//   var coinbal;
//   var mainaccfast = " ";
//   var proviaccfast = 0;
//   var amnotban = "1";
//   var amiapporoved = 0;
//   var messtitle, notimesstitle;
//   var messbody, notimessbody;
//   var imageurl, notiimageurl;
//   int hvsubmitkyc=0;
//   Future allrecenthistory;
//   @override
//   void initState() {
//     _refreshController = RefreshController();
//     userInfo();
//     getMessage();
//     super.initState();
//   }

//   void showHelloWorld() {
//     showDialog(
//       context: context,
//       builder: (context) => new AlertDialog(
//         title: Text('New Version?',
//             style: TextStyle(color: Colors.black, fontSize: 20.0)),
//         content: Text(
//             'You are on old app version of LoadNG app, there is a new version of the app available on the store, kindly download the new app to stay updated with new features we just added.'),
//         actions: <Widget>[
//           FlatButton(
//             onPressed: () {
//               if (Platform.isAndroid) {
//                 functionfile.launchURL(
//                     'https://play.google.com/store/apps/details?id=loadng.com.loadng&hl=en_US');
//               } else if (Platform.isIOS) {
//                 functionfile.launchURL(
//                     'https://apps.apple.com/ng/app/loadng/id1537865343');
//               }
//             },
//             child: new Text('Download', style: TextStyle(fontSize: 18.0)),
//           ),
//           FlatButton(
//             onPressed: () =>
//                 Navigator.pop(context), // this line dismisses the dialog
//             child: new Text('No', style: TextStyle(fontSize: 18.0)),
//           )
//         ],
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     var cardHight = (width - 48) * (9 / 16);
//     var categoryWidth = (width - 56) / 4;
//     var sliderHeight = height * 0.3;
//     var slider = Container(
//       // height: cardHight,
//       margin: EdgeInsets.only(top: 98),
//       child: Column(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               height: cardHight,
//               child: PageView.builder(
//                 itemCount: 4,
//                 itemBuilder: (context, index) {
//                   // LoadNG wallet,Refill,Bill,Coin
//                   var walletname, walletbalance, nytype;
//                   if (index == 0) {
//                     walletname = "LoadNG";
//                     walletbalance = "$mainbal";
//                     nytype = 0;
//                   } else if (index == 1) {
//                     walletname = "Bills";
//                     walletbalance = "$billbal";
//                     nytype = 0;
//                   } else if (index == 2) {
//                     walletname = "Refill";
//                     walletbalance = "$refillbal";
//                     nytype = 0;
//                   } else if (index == 3) {
//                     walletname = "LoadNG Bonus";
//                     walletbalance = "$coinbal";
//                     nytype = 1;
//                   }
//                   return dashboardCards(
//                       walletname: walletname,
//                       cardHight: cardHight,
//                       index: index,
//                       walletbalance: walletbalance,
//                       type: nytype,
//                       mainacc: mainaccfast,
//                       username: username);
//                 },
//                 onPageChanged: (index) {
//                   setState(() {
//                     position = index;
//                   });
//                 },
//               ),
//             ),
//           ),
//           DotsIndicator(
//             dotsCount: 4,
//             position: position,
//             decorator: DotsDecorator(
//                 color: AppColors.t12_text_secondary.withOpacity(0.15),
//                 activeColor: AppColors.t12_primary_color,
//                 activeSize: Size.square(AppFontSize.spacing_middle),
//                 spacing: EdgeInsets.all(3)),
//           ).paddingAll(AppFontSize.spacing_standard)
//         ],
//       ).paddingBottom(AppFontSize.spacing_standard),
//     ).paddingOnly(
//         left: AppFontSize.spacing_standard_new,
//         right: AppFontSize.spacing_standard_new);
//     var category = Container(
//       alignment: Alignment.center,
//       height: categoryWidth + 6,
//       margin: EdgeInsets.only(top: AppFontSize.spacing_standard_new),
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: 4,
//         padding: EdgeInsets.only(
//             left: AppFontSize.spacing_standard,
//             right: AppFontSize.spacing_standard_new),
//         shrinkWrap: true,
//         itemBuilder: (context, index) {
//           var thename = " ",
//               theiconname = " ",
//               thecolor = AppColors.t12_cat1,
//               navlink;
//           if (index == 0) {
//             thename = "Sell Coins";
//             theiconname = AppImage.t12_sellcoins;
//             thecolor = AppColors.t12_cat1;
//             navlink = "/coinslist";
//           } else if (index == 1) {
//             thename = "Sell Coins (Business)";
//             theiconname = AppImage.t12_bill;
//             thecolor = AppColors.t12_cat4;
//             navlink = "/bizcoinslist";
//           } else if (index == 2) {
//             thename = "Sell Cards";
//             theiconname = AppImage.t12_card;
//             thecolor = AppColors.t12_cat2;
//             navlink = "";
//           } else if (index == 3) {
//             thename = "Buy Coins";
//             theiconname = AppImage.t12_transaction;
//             thecolor = AppColors.t12_cat3;
//             navlink = "/buycoinslist";
//           }
//           return GestureDetector(
//               onTap: () {
//                 if (navlink.isNotEmpty) {
//                   if (index == 1) {
//                     if (mainaccfast != " " &&
//                         mainaccfast.isNotEmpty &&
//                         mainaccfast != null) {
//                       var txtdialog =
//                           "LoadNG Business allows you to always send Cryptocurrency to a particular wallet without having to login to your LoadNG account everytime. The system identifies your inputs and pays you immediately with respect to the present rate on the system at that time.Thanks for using LoadNG.";
//                       var thehexcode = 0xfffff0dd;
//                       var theimage = AppImage.uni;
//                       showDialog(
//                           context: context,
//                           builder: (BuildContext context) => CustomInfo(
//                               sentimg: theimage,
//                               senttxt: txtdialog,
//                               thename: thename,
//                               therate: 1,
//                               thehexcode: thehexcode,
//                               thenavlink: navlink,
//                               thetype: 1,
//                               theaddress: 1));
//                     } else {
//                       showDialog(
//                         context: context,
//                         builder: (context) => new AlertDialog(
//                           title: Text('UPDATE ACCOUNT',
//                               style: TextStyle(
//                                   color: Colors.black, fontSize: 20.0)),
//                           content: Text(
//                               'Hello LoadNG User, sorry you need to add at least a bank under your bank settings in my account page as well as update your profile in my profile page before you can start using any of our services,sorry for any problem caused.'),
//                           actions: <Widget>[
//                             Material(
//                                 color: AppColors.shadowdarkblack2,
//                                 child: FlatButton(
//                                   onPressed: () => Navigator.of(context).pushNamed(
//                                       '/usereditprofile'), // this line dismisses the dialog
//                                   child: new Text('GO TO SETTINGS',
//                                       style: TextStyle(
//                                           fontSize: 14.0, color: Colors.white)),
//                                 ))
//                           ],
//                         ),
//                       );
//                     }
//                   } else {
//                     if (index != 3) {
//                       if (mainaccfast != " " &&
//                           mainaccfast.isNotEmpty &&
//                           mainaccfast != null) {
//                         Navigator.of(context).pushNamed('$navlink');
//                       } else {
//                         showDialog(
//                           context: context,
//                           builder: (context) => new AlertDialog(
//                             title: Text('UPDATE ACCOUNT',
//                                 style: TextStyle(
//                                     color: Colors.black, fontSize: 20.0)),
//                             content: Text(
//                                 'Hello LoadNG User, You have to fill in your bank account and profile details before you proceed to sell cryptocurrency on LoadNG. Kindly do that by clicking on the button below.'),
//                             actions: <Widget>[
//                               Material(
//                                   color: AppColors.shadowdarkblack2,
//                                   child: FlatButton(
//                                     onPressed: () => Navigator.of(context)
//                                         .pushNamed(
//                                             '/usereditprofile'), // this line dismisses the dialog
//                                     child: new Text('GO TO SETTINGS',
//                                         style: TextStyle(
//                                             fontSize: 14.0,
//                                             color: Colors.white)),
//                                   ))
//                             ],
//                           ),
//                         );
//                       }
//                     } else {
//                       if (proviaccfast != 0 && proviaccfast != null &&amiapporoved==2) {
//                         Navigator.of(context).pushNamed('$navlink');
//                       } else {
                     
//                      if (amiapporoved == 0 && hvsubmitkyc==0) {
//                           // not filled
//                           showDialog(
//                             context: context,
//                             builder: (context) => new AlertDialog(
//                               title: Text('FILL KYC',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 20.0)),
//                               content: Text(
//                                   'To buy coins on LoadNG, you have to fill your KYC details and have it aporoved, kindly do so by clicking the button below. '),
//                               actions: <Widget>[
//                                 Material(
//                                     color: AppColors.shadowdarkblack2,
//                                     child: FlatButton(
//                                       onPressed: () => Navigator.of(context)
//                                           .pushNamed(
//                                               '/kycform'), // this line dismisses the dialog
//                                       child: new Text('Fill KYC Details',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: Colors.white)),
//                                     ))
//                               ],
//                             ),
//                           );
//                         }else     if (hvsubmitkyc<=1) {
//                           //pending
//                           showDialog(
//                             context: context,
//                             builder: (context) => new AlertDialog(
//                               title: Text('KYC APPROVAL',
//                                   style: TextStyle(
//                                       color: Colors.black, fontSize: 20.0)),
//                               content: Text(
//                                   'To buy coins on LoadNG, your KYC needs to be approved, kindly wait while the system authenticate your KYC details.'),
//                               actions: <Widget>[
//                                 Material(
//                                     color: AppColors.shadowdarkblack2,
//                                     child: FlatButton(
//                                       onPressed: () => Navigator.pop(
//                                           context), // this line dismisses the dialog
//                                       child: new Text('OK',
//                                           style: TextStyle(
//                                               fontSize: 14.0,
//                                               color: Colors.white)),
//                                     ))
//                               ],
//                             ),
//                           );
//                         } 
//                       }
//                     }
//                   }
//                 } else {
//                   toast(AppTexts.featurenotavailable);
//                 }
//               },
//               child: Container(
//                 width: categoryWidth,
//                 margin: EdgeInsets.only(left: AppFontSize.spacing_standard),
//                 decoration: boxDecoration(
//                     bgColor: thecolor.withOpacity(0.2),
//                     radius: AppFontSize.spacing_standard),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Image.asset(
//                       theiconname,
//                       width: categoryWidth * 0.3,
//                       height: categoryWidth * 0.3,
//                       color: AppColors.appBackgroundColorDark,
//                     ),
//                     text("$thename",
//                             maxLine: 3,
//                             fontFamily: AppFontSize.spinnaker,
//                             fontSize: AppFontSize.textSizeSmall,
//                             textColor: AppColors.t12_text_color_primary)
//                         .paddingTop(AppFontSize.spacing_control_half)
//                   ],
//                 ),
//               ));
//         },
//       ),
//     );
//     var transaction = FutureBuilder<RecentHistory>(
//       future: allrecenthistory,
//       builder: (context, gtserv) {
//         switch (gtserv.connectionState) {
//           case ConnectionState.none:
//             return Center(
//                 child: text(AppTexts.connectiondelay,
//                     textColor: AppColors.appDarkRed,
//                     fontFamily: AppFontSize.montbold,
//                     fontSize: AppFontSize.textSizeSMedium,
//                     isCentered: true));
//             break;
//           case ConnectionState.waiting:
//             return Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Center(
//                   child: Container(
//                     alignment: Alignment.center,
//                     child: SpinKitWave(color: AppColors.shadowdarkblack2),
//                   ),
//                 ),
//               ],
//             );
//             break;
//           case ConnectionState.active:
//             return Text('');
//             break;
//           case ConnectionState.done:
//             if (gtserv.hasError) {
//               return Center(
//                   child: Text(
//                 'History not found, try again!',
//                 style:
//                     TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
//               ));
//             } else if (gtserv.hasData) {
//               if (gtserv.data.history == null || gtserv.data.history.isEmpty) {
//                 return Center(
//                     child: Text('No History Available',
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontWeight: FontWeight.w800,
//                         )));
//               } else {
//                 return ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: gtserv.data.history.length,
//                   physics: NeverScrollableScrollPhysics(),
//                   padding: EdgeInsets.only(
//                       left: AppFontSize.spacing_standard_new,
//                       right: AppFontSize.spacing_standard_new),
//                   shrinkWrap: true,
//                   itemBuilder: (context, index) {
//                     var myhistory = gtserv.data.history[index];
//                     var dusd = myhistory.nairavalue;
//                     var dnaira = myhistory.usdvalue;
//                     var transimg = AppImage.others;
//                     var transname = myhistory.name.toLowerCase();
//                     var thehexcode = 0xfffae6fb;
//                     if (transname == "paxful btc") {
//                       transimg = AppImage.paxful;
//                       thehexcode = 0xfffae6fb;
//                     } else if (transname == "ethereum") {
//                       thehexcode = 0xffd9e1ff;
//                       transimg = AppImage.eth;
//                     } else if (transname == "universal btc") {
//                       thehexcode = 0xfffff9d9;
//                       transimg = AppImage.uni;
//                     } else if (transname == "usd coin") {
//                       thehexcode = 0xffe6f2ff;
//                       transimg = AppImage.usd;
//                     } else if (transname == "litecoin") {
//                       thehexcode = 0xfffce5c0;
//                       transimg = AppImage.ltc;
//                     } else if (transname == "bitcoin cash (bch)") {
//                       thehexcode = 0xffeeffdc;
//                       transimg = AppImage.bch;
//                     } else if (transname == "blockchain btc") {
//                       thehexcode = 0xfffff0dd;
//                       transimg = AppImage.cashapp;
//                     } else if (transname == "perfect money") {
//                       thehexcode = 0xffffc1c1;
//                       transimg = AppImage.pm;
//                     } else if (transname == "bitcoin btc") {
//                       thehexcode = 0xfffae6fb;
//                       transimg = AppImage.paxful;
//                     }

//                     return Column(children: <Widget>[
//                       GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).pushNamed(
//                                 '/transactiondetails',
//                                 arguments: new RouteArgument(argumentsList: [
//                                   myhistory.name,
//                                   myhistory.id,
//                                   myhistory.ourrate,
//                                   myhistory.usdvalue,
//                                   myhistory.nairavalue,
//                                   myhistory.orderid,
//                                   myhistory.statusnumber,
//                                   myhistory.date,
//                                   myhistory.btcval,
//                                   myhistory.payref,
//                                   myhistory.paystatus,
//                                   myhistory.statustext,
//                                   myhistory.address,
//                                   myhistory.hashlink,
//                                   myhistory.hash,
//                                   myhistory.images,
//                                   thehexcode,
//                                   transimg
//                                 ]));
//                           },
//                           child: dashboardtransactionWidget(
//                               transactionimg: transimg,
//                               transactionname: "${myhistory.name}",
//                               transactionamt: "${myhistory.statustext}",
//                               categoryWidth: categoryWidth,
//                               rate: "$dusd",
//                               liverate: "\$$dnaira",
//                               thestatusnum: myhistory.statusnumber))
//                       // ),
//                     ]);
//                   },
//                 );
//               }
//             } else {
//               return Text('');
//             }
//             break;
//         }
//         return Text('');
//       },
//     );

//     return WillPopScope(
//         onWillPop: () {
//           return showDialog(
//                 context: context,
//                 builder: (context) => AlertDialog(
//                   title: Text('Are you sure?'),
//                   content: Text('Do you want to exit the App'),
//                   actions: <Widget>[
//                     FlatButton(
//                       onPressed: () => Navigator.of(context).pop(false),
//                       child: Text('No'),
//                     ),
//                     FlatButton(
//                       onPressed: () => exit(0),
//                       child: Text('Yes'),
//                     ),
//                   ],
//                 ),
//               ) ??
//               false;
//         },
//         child: Scaffold(
//           key: _key,
//           drawer: UserDrawer(),
//           body: NestedScrollView(
//             headerSliverBuilder:
//                 (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverAppBar(
//                     expandedHeight: sliderHeight + 120,
//                     floating: true,
//                     backgroundColor: Colors.white,
//                     pinned: true,
//                     titleSpacing: 0,
//                     automaticallyImplyLeading: false,
//                     actionsIconTheme: IconThemeData(
//                         opacity: 0.0, color: AppColors.t12_text_color_primary),
//                     title: Container(
//                       height: 60,
//                       padding: EdgeInsets.only(
//                           left: AppFontSize.spacing_standard_new),
//                       child: Row(
//                         children: <Widget>[
//                           Image.asset(
//                             AppImage.profile,
//                             width: 35,
//                             height: 35,
//                           ).cornerRadiusWithClipRRect(
//                               AppFontSize.spacing_standard),
//                           Expanded(
//                               child: toolBarTitle("Hi,$username",
//                                       textColor: AppColors.shadowdarkblack)
//                                   .paddingLeft(
//                                       AppFontSize.spacing_standard_new)),
//                           Row(
//                             children: <Widget>[
//                               Icon(
//                                 Icons.notifications,
//                                 color: AppColors.t12_text_color_primary,
//                                 size: 24,
//                               )
//                                   .paddingAll(AppFontSize.spacing_standard)
//                                   .onTap(() {
//                                 Navigator.of(context)
//                                     .pushNamed('/usernotification');
//                               }),
//                               Icon(
//                                 Icons.menu,
//                                 color: AppColors.t12_text_color_primary,
//                                 size: 24,
//                               )
//                                   .paddingAll(AppFontSize.spacing_standard)
//                                   .onTap(() {
//                                 _key.currentState.openDrawer();
//                               }),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                     flexibleSpace: SmartRefresher(
//                         enablePullDown: _enablePullDown,
//                         header: WaterDropHeader(
//                           waterDropColor: Colors.cyan[900],
//                           complete: Text('Complete',
//                               style: TextStyle(
//                                   color: Colors.teal,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold)),
//                           failed: Text('Failed',
//                               style:
//                                   TextStyle(color: Colors.red, fontSize: 18)),
//                         ),
//                         controller: _refreshController,
//                         onRefresh: _onRefresh,
//                         onLoading: _onLoading,
//                         child: SmartRefresher(
//                             enablePullDown: _enablePullDown,
//                             header: WaterDropHeader(
//                               waterDropColor: Colors.green,
//                               complete: Text('Complete',
//                                   style: TextStyle(
//                                       color: Colors.teal,
//                                       fontSize: 18,
//                                       fontWeight: FontWeight.bold)),
//                               failed: Text('Failed',
//                                   style: TextStyle(
//                                       color: Colors.red, fontSize: 18)),
//                             ),
//                             controller: _refreshController,
//                             onRefresh: _onRefresh,
//                             onLoading: _onLoading,
//                             child: FlexibleSpaceBar(
//                               background: slider,
//                             )))),
//               ];
//             },
//             body: SingleChildScrollView(
//               child: Column(
//                 children: <Widget>[
//                   category,
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       headingText("Recent History"),
//                       text("See all",
//                               textColor: AppColors.t12_primary_color,
//                               fontFamily: AppFontSize.spinnaker,
//                               fontSize: AppFontSize.textSizeMedium)
//                           .onTap(() {
//                         Navigator.of(context).pushNamed('/userhistory');
//                       })
//                     ],
//                   ).paddingOnly(
//                       left: AppFontSize.spacing_standard_new,
//                       right: AppFontSize.spacing_standard_new,
//                       top: 9),
//                   transaction
//                 ],
//               ),
//             ),
//           ),
//         ));
//     // ));
//   }

//   Future<void> userInfo() async {
//       var theinternet = await functionfile.isInternet();
//       var theinternet2 = await functionfile.checkInternetAccess();
//       if (theinternet && theinternet2) {
//       functionfile.onHorizontalLoading1(context);

//       final prefs2 = await StreamingSharedPreferences.instance;
//       var storeddetails2 = MyAppSettings(prefs2);
//        if (mounted) {
//       setState(() {
//       username = storeddetails2.dusername.getValue();
//       mainaccfast = storeddetails2.dmainaccno.getValue();
//       proviaccfast = storeddetails2.dprovidusaccno.getValue();
//       allrecenthistory = historyapi.allrecenthistory();
//       });
//        }
//       Navigator.pop(context);


//       var splitmsg;
//       var userdata = await accountapi.userfulldetails();
//       if (userdata != null) {
//       splitmsg = userdata.msg.split("|");
//       if (splitmsg[0] == "1") {
//       functionfile.storeDetails(
//       uname: userdata.username,
//       id: userdata.id,
//       email: userdata.email,
//       phoneno: userdata.phoneno,
//       mainbal: userdata.walletbal,
//       billbal: userdata.billbal,
//       refillbal: userdata.refillbal,
//       coins: userdata.coins,
//       referby: userdata.referby,
//       usertype: userdata.usertype,
//       userlevel: userdata.userlevel,
//       providusaccno: userdata.providusaccno,
//       mainaccno: userdata.mainaccno,
//       mainaccname: userdata.mainaccname,
//       mainbnkname: userdata.mainaccbankname,
//       activatepin: userdata.activatepin,
//       datejoined: userdata.datejoined,
//       fullnname: userdata.fullname,
//       starcount: userdata.userstarcount,
//       canlogin: 1,
//       );
//       }
//       setState(() {
//       amnotban = splitmsg[0];
//       });
//       }
//       final prefs = await StreamingSharedPreferences.instance;
//       var storeddetails = MyAppSettings(prefs);
//       if (mounted) {
//       setState(() {
//       username = storeddetails.dusername.getValue();
//       mainbal = oCcy.format(storeddetails.dwalletbal.getValue());
//       billbal = oCcy.format(double.parse(storeddetails.dbillbal.getValue()));
//       refillbal =
//       oCcy.format(double.parse(storeddetails.drefillbal.getValue()));
//       coinbal = oCcy.format(double.parse(storeddetails.dcoins.getValue()));
//       // coinbal=(storeddetails.dcoins.getValue().isNotEmpty&&storeddetails.dcoins.getValue()!=''? double.parse((storeddetails.dcoins.getValue())).toStringAsFixed(0):0);
//       mainaccfast = storeddetails.dmainaccno.getValue();
//       });
//       }



//       if (amnotban != "1") {
//       // Navigator.pop(context);
//       showDialog(
//       context: context,
//       builder: (context) => new AlertDialog(
//       title: Text('BANNED ACCOUNT',
//       style: TextStyle(color: Colors.black, fontSize: 20.0)),
//       content: Text(
//       'Sorry your accunt has been banned and you are not allowed to use any of our services again'),
//       actions: <Widget>[
//       Material(
//       color: AppColors.shadowdarkblack2,
//       child: FlatButton(
//       onPressed: () {
//       prefs.clear();
//       Navigator.pop(context);
//       Navigator.of(context).pushNamed('/');
//       exit(0); // this line dismisses the dialog
//       },
//       child: new Text('OK',
//       style: TextStyle(fontSize: 14.0, color: Colors.white)),
//       ))
//       ],
//       ),
//       );

//       prefs.clear();
//       Navigator.pop(context);
//       Navigator.of(context).pushNamed('/');
//       }

//       int myphone = 0;
//       if (Platform.isIOS) {
//       myphone = 1; //1=ios
//       } else if (Platform.isAndroid) {
//       myphone = 2; //2=android
//       }

//       var checker=0;
//       var checkeing = await systemapi.checkappnewversion(
//       version: storeddetails.currentversion.getValue(), phonetype: myphone);
//       if (checkeing != null) {
//       if (checkeing.status) {
//         checker=1;
//       // Navigator.pop(context);
//       showHelloWorld();
//       }
//       }

//       var checkeing2 = await systemapi.checkactivepax();
//       if (checkeing2 != null) {
//       prefs.setInt("activepax", int.parse(checkeing2.msg));
//       }
//       if (splitmsg != null) {
//       prefs.setInt("kycfilled", int.parse(splitmsg[1]));
//       prefs.setInt("kycapproved", int.parse(splitmsg[2]));

//       setState(() {
//       amiapporoved = int.parse(splitmsg[1]);
//       hvsubmitkyc=int.parse(splitmsg[2]);
//       }); 
//       } else {
//       prefs.setInt("kycfilled", 0); 
//       prefs.setInt("kycapproved", 0);

//       }
//       // if(username!=" "&&username!=null&&username.isNotEmpty&&amnotban=="1"&&checker==0){
//       // Navigator.of(context).pop();
//       // }

//     } else {
//        showDialog(
//           context: context,
//           builder: (context) => new AlertDialog(
//             title:  Text('Internet Error',
//                 style:  TextStyle(color: Colors.black, fontSize: 20.0)),
//             content:  Text(
//                 'Ooops! Kindly check your internet connection as the data for dashboard failed to load. Reload page to try again.'),
//             actions: <Widget>[
//                Row(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.center,
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.spaceBetween,
//                                         children: <Widget>[
//                                             FlatButton(
//                 onPressed: (){
//                     Navigator.pop(context);
//                      userInfo();
//                     },// this line dismisses the dialog
//                 child: new Text('Reload', style: TextStyle(fontSize: 18.0)),
//               ),

//              FlatButton(
//                 onPressed: () =>
//                     Navigator.pop(context), // this line dismisses the dialog
//                 child: new Text('OK', style: TextStyle(fontSize: 18.0)),
//               )
//                                         ])
             
//             ],
//           ),
//         );
//     }
//   }

//   void getMessage() {
//         //calling d configure actions
//         FirebaseMessaging.onMessage.listen((event) {
//          var message = event.data;
//           //  onMessage: (Map<String, dynamic> message) async {
//         //onMessage starts
//         //getting all data sent
//         messtitle = message["data"]["title"];
//         messbody = message["data"]["body"];
//         imageurl = message["data"]["image"];
//         notimesstitle = message["notification"]["title"];
//         notimessbody = message["notification"]["body"];
//         notiimageurl = message["notification"]["image"];

//         //once the app is opened and notification enters, it should pop up
//         showDialog(
//         context: context,
//         builder: (BuildContext context) => Dialog(
//         shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         ),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         child: Container(
//         decoration: boxDecoration(
//         showShadow: true, radius: AppFontSize.spacing_standard),
//         child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//         imageurl != null
//         ? Image.network(
//         imageurl,
//         width: 220,
//         height: 120,
//         ).paddingTop(50)
//         : notiimageurl != null
//         ? Image.network(
//         notiimageurl,
//         width: 220,
//         height: 120,
//         ).paddingTop(50)
//         : Container(),
//         toolBarTitle(
//         (messtitle != null
//         ? messtitle
//         : notimesstitle != null
//         ? notimesstitle
//         : " "),
//         textColor: AppColors.appDarkRed)
//         .paddingTop(AppFontSize.spacing_large),
//         text(
//         messbody != null
//         ? messbody
//         : notimessbody != null
//         ? notimessbody
//         : " ",
//         maxLine: 18,
//         isCentered: true,
//         fontSize: AppFontSize.textSizeSMedium,
//         fontFamily: AppFontSize.spinnaker)
//         .paddingTop(AppFontSize.spacing_control),
//         SizedBox(
//         width: double.infinity,
//         child: MaterialButton(
//         padding: EdgeInsets.only(
//         top: AppFontSize.spacing_standard_new,
//         bottom: AppFontSize.spacing_standard_new),
//         child: text("OK",
//         textColor: Colors.white,
//         fontFamily: AppFontSize.fontMedium,
//         maxLine: 2),
//         shape: RoundedRectangleBorder(
//         borderRadius: new BorderRadius.circular(
//         AppFontSize.spacing_standard)),
//         color: AppColors.t12_primary_color,
//         onPressed: () {
//         Navigator.pop(context);
//         },
//         ),
//         ).paddingAll(AppFontSize.spacing_standard_new)
//         ],
//         ).paddingAll(AppFontSize.spacing_standard_new),
//         ),
//         ));
//         // }, 
//         // })
//         //on message is when the application is in foreground
//       //  /on message end here
//         onResume: (Map<String, dynamic> message) async {
//         //on resume starts
//         //this called wen app is minimized, it in background
//         //getting all data sent
//         messtitle = message["data"]["title"];
//         messbody = message["data"]["body"];
//         imageurl = message["data"]["image"];
//         notimesstitle = message["notification"]["title"];
//         notimessbody = message["notification"]["body"];
//         notiimageurl = message["notification"]["image"];

//         //once the app is opened and notification enters, it should pop up
//         showDialog(
//         context: context,
//         builder: (BuildContext context) => Dialog(
//         shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         ),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         child: Container(
//         decoration: boxDecoration(
//         showShadow: true, radius: AppFontSize.spacing_standard),
//         child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//         imageurl != null
//         ? Image.network(
//         imageurl,
//         width: 220,
//         height: 120,
//         ).paddingTop(50)
//         : notiimageurl != null
//         ? Image.network(
//         notiimageurl,
//         width: 220,
//         height: 120,
//         ).paddingTop(50)
//         : Container(),
//         toolBarTitle(
//         (messtitle != null
//         ? messtitle
//         : notimesstitle != null
//         ? notimesstitle
//         : " "),
//         textColor: AppColors.appDarkRed)
//         .paddingTop(AppFontSize.spacing_large),
//         text(
//         messbody != null
//         ? messbody
//         : notimessbody != null
//         ? notimessbody
//         : " ",
//         maxLine: 18,
//         isCentered: true,
//         fontSize: AppFontSize.textSizeSMedium,
//         fontFamily: AppFontSize.spinnaker)
//         .paddingTop(AppFontSize.spacing_control),
//         SizedBox(
//         width: double.infinity,
//         child: MaterialButton(
//         padding: EdgeInsets.only(
//         top: AppFontSize.spacing_standard_new,
//         bottom: AppFontSize.spacing_standard_new),
//         child: text("OK",
//         textColor: Colors.white,
//         fontFamily: AppFontSize.fontMedium,
//         maxLine: 2),
//         shape: RoundedRectangleBorder(
//         borderRadius: new BorderRadius.circular(
//         AppFontSize.spacing_standard)),
//         color: AppColors.t12_primary_color,
//         onPressed: () {
//         Navigator.pop(context);
//         },
//         ),
//         ).paddingAll(AppFontSize.spacing_standard_new)
//         ],
//         ).paddingAll(AppFontSize.spacing_standard_new),
//         ),
//         ));
//         }, //on resume end here
//         onLaunch: (Map<String, dynamic> message) async {
//         //on lunch starts here
//         //this called when app is killed
//         //getting all data sent
//         messtitle = message["data"]["title"];
//         messbody = message["data"]["body"];
//         imageurl = message["data"]["image"];
//         notimesstitle = message["notification"]["title"];
//         notimessbody = message["notification"]["body"];
//         notiimageurl = message["notification"]["image"];

//         //once the app is opened and notification enters, it should pop up
//         showDialog(
//         context: context,
//         builder: (BuildContext context) => Dialog(
//         shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//         ),
//         elevation: 0.0,
//         backgroundColor: Colors.transparent,
//         child: Container(
//         decoration: boxDecoration(
//         showShadow: true, radius: AppFontSize.spacing_standard),
//         child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//         imageurl != null
//         ? Image.network(
//         imageurl,
//         width: 220,
//         height: 120,
//         ).paddingTop(50)
//         : notiimageurl != null
//         ? Image.network(
//         notiimageurl,
//         width: 220,
//         height: 120,
//         ).paddingTop(50)
//         : Container(),
//         toolBarTitle(
//         (messtitle != null
//         ? messtitle
//         : notimesstitle != null
//         ? notimesstitle
//         : " "),
//         textColor: AppColors.appDarkRed)
//         .paddingTop(AppFontSize.spacing_large),
//         text(
//         messbody != null
//         ? messbody
//         : notimessbody != null
//         ? notimessbody
//         : " ",
//         maxLine: 18,
//         isCentered: true,
//         fontSize: AppFontSize.textSizeSMedium,
//         fontFamily: AppFontSize.spinnaker)
//         .paddingTop(AppFontSize.spacing_control),
//         SizedBox(
//         width: double.infinity,
//         child: MaterialButton(
//         padding: EdgeInsets.only(
//         top: AppFontSize.spacing_standard_new,
//         bottom: AppFontSize.spacing_standard_new),
//         child: text("OK",
//         textColor: Colors.white,
//         fontFamily: AppFontSize.fontMedium,
//         maxLine: 2),
//         shape: RoundedRectangleBorder(
//         borderRadius: new BorderRadius.circular(
//         AppFontSize.spacing_standard)),
//         color: AppColors.t12_primary_color,
//         onPressed: () {
//         Navigator.pop(context);
//         },
//         ),
//         ).paddingAll(AppFontSize.spacing_standard_new)
//         ],
//         ).paddingAll(AppFontSize.spacing_standard_new),
//         ),
//         ));
//         } //on launch ends here
//         );
//   }

//   _onLoading() {
//     _refreshController.loadComplete();
//   }

//   _onRefresh() {
//     setState(() {
//       userInfo();
//       _refreshController.refreshCompleted();
//     });
//   }
// }
