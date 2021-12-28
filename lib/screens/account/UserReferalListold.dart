// import 'package:flutter/material.dart';
// import 'package:loadng/utils/customFunction.dart';
// import 'package:loadng/locator.dart';
// import 'package:loadng/styles/AppFontSizes.dart';
// import 'package:loadng/styles/AppColors.dart';
// import 'package:loadng/widgets/loginScreen.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:loadng/model/account/UserReferals.dart';
// import 'package:loadng/services/apis/account.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
// import 'package:loadng/services/appSettings.dart';
// import 'package:loadng/styles/AppText.dart';
// import 'package:loadng/utils/dots_indicator/dots_indicator.dart';
// import 'dart:io';


// var functionfile = locator<CustomFunction>();
// var accountapi = locator<AccountApi>();

// class UserReferalList extends StatefulWidget {
//   static String tag = '/userreferals';

//   @override
//   UserReferalListState createState() => UserReferalListState();
// }

// class UserReferalListState extends State<UserReferalList> with SingleTickerProviderStateMixin {
//   TabController _controller;
//   int _selectedInde=0;
//   final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
//   int currentIndexPage = 0;
//   int pageLength;
//   Future allreferals;
//   var coinspaid=0;
//   var totalrefrred=0;
//     var username ="";
//   var email= "";
//   var mainacc= "";

// activatetab(){
//     _controller= new TabController(length: 3, vsync: this);

//   _controller.addListener(() {
//     setState(() {
//           _selectedInde=_controller.index;
//         });
//         // do wnt u wnt on d index here
//   });
// }

//   @override
//   void initState() { 
//     activatetab();
//     internetcheck();
//     userInfo() ;
//     super.initState();
//     currentIndexPage = 0;
//     pageLength = 3;
//   }

//             internetcheck() async{
//       var theinternet = await functionfile.isInternet();
//     var theinternet2 = await functionfile.checkInternetAccess();

//       if (theinternet && theinternet2) {
//          setState(() {
//     allreferals=accountapi.userreferals();
//          });
//       }else{
//       functionfile.showerror(context);
//       }
//   }
//   var position = 0;
//   var totalpoint = "0";
//   var reflink = "";
//   var refpoint = 0;
//   var salepoint = 0;
//   var buypoint = 0;
 
//   @override
//   Widget build(BuildContext context) {
//    functionfile.changeStatusColor(Colors.transparent);
//        var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;
//     var cardHight = (width - 48) * (9 / 16);
//       var slider = Container(
//       // height: cardHight,
//       margin: EdgeInsets.only(top: 8),
//       child: Column(
//         children: <Widget>[
//           Expanded(
//             child: Container(
//               height: cardHight,
//               child: PageView.builder(
//                 itemCount: 3,
//                 itemBuilder: (context, index) {
//                   // LoadNG wallet,Refill,Bill,Coin
//                   var walletname, walletbalance;
//                   if (index == 0) {
//                     walletname = "Total Points";
//                     walletbalance = "$totalpoint";
//                   } else if (index == 1) {
//                     walletname = "Referral Points";
//                     walletbalance = "$refpoint";
//                   } else if (index == 2) {
//                     walletname = "Sales Points";
//                     walletbalance = "$salepoint";
//                   } else if (index == 3) {
//                     walletname = "Buy points";
//                     walletbalance = "$buypoint";
//                   }
        
//                   return referalCards(
//                       walletname: walletname,
//                       cardHight: cardHight,
//                       index: index,
//                       walletbalance: walletbalance,
//                       context: context,
//                       reflink:reflink,
//                       ontap: () {
//                               withdrawl();
//                               } );
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
//       )
//     ).paddingOnly(
//         left: AppFontSize.spacing_standard_new,
//         right: AppFontSize.spacing_standard_new);

//     return Scaffold(
//         body:Container(
//     child: SingleChildScrollView(
//       child: Column( 
//          crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//          TopBar(titleName: "My Points",),
//        Container(
//          height:220,
//          child:slider),
//           // Column(
//           //   children: <Widget>[
//           //     Container(
//           //       height: 200,
//           //       width: double.infinity, 
//           //       child: PageView(
//           //         pageSnapping: true,
//           //         children: <Widget>[
//           //           Container(
//           //             child: ReferalCardDetails(
//           //               totalpaid: "$coinspaid",
//           //               totalrefered: "$totalrefrred",
//           //               username: "$username",  
//           //               color: AppColors.appColorPrimary,
//           //             ),
//           //           ),
                   
//           //         ],
//           //       ),
//           //     ),
//           //   ],
//           // ),
//                      TabBar(
//           isScrollable: true,
//           controller: _controller,
//           indicatorColor: Colors.grey,
//           labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),
//           onTap: (index) {
//            // Tab index when user select it, it start from zero
//           },
//           tabs: [
//                   Tab(text:"datain"),
//                    Tab(text:"datain"),
//                     Tab(text:"datain"),
//                   // Tab(text:"USDT ERC"),
//           ],
//         ),

//       Expanded(
//               child:   TabBarView(
//           controller: _controller,
          
//         children:[
//           Text("wwdd"),
//           Text("wwdd"),
//           Text("wwdd"),
//         ]
//     )),
              
        
//           // Container(
//           //   margin: EdgeInsets.only(left: 16, right: 16, bottom: 16),
//           //   child: Row(
//           //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           //     children: <Widget>[
//           //       Text('Referrals', style: secondaryTextStyle(size: 18, fontFamily: AppFontSize.montbold)),
             
//           //     ],
//           //   ),
//           // ),


//             // FutureBuilder<UserReferalModel>(
//             //         future: allreferals,
//             //         builder: (context, gtserv) {
                      
//             //           switch (gtserv.connectionState) {
//             //             case ConnectionState.none:
//             //               return Center(child: text(AppTexts.connectiondelay, textColor: AppColors.appDarkRed, fontFamily: AppFontSize.montbold, fontSize: AppFontSize.textSizeSMedium,isCentered: true)); 
//             //               break;
//             //             case ConnectionState.waiting:
//             //               return Column(
//             //                 mainAxisAlignment: MainAxisAlignment.center,
//             //                 crossAxisAlignment: CrossAxisAlignment.center,
//             //                 children: <Widget>[
//             //                   Center(
//             //                     child: Container(
//             //                       alignment: Alignment.center,
//             //                       child: SpinKitWave(color: AppColors.shadowdarkblack2),
//             //                     ),
//             //                   ),
//             //                 ],
//             //               );
//             //               break;
//             //             case ConnectionState.active:
//             //               return Text('');
//             //               break;
//             //             case ConnectionState.done:
//             //               if (gtserv.hasError) {
//             //                 return Center(
//             //                     child: Text(
//             //                   'Referrals not found, try again!',
//             //                   style: TextStyle(
//             //                       color: Colors.red,
//             //                       fontWeight: FontWeight.bold),
//             //                 ));
//             //               } else if (gtserv.hasData) {
//             //                 if (gtserv.data.users==null || gtserv.data.users.isEmpty) {
//             //                   return Center(
//             //                       child: Text('No referrals yet',
//             //                           style: TextStyle(
//             //                             color: Colors.red,
//             //                             fontWeight: FontWeight.w800,
//             //                           )));
//             //                 } else {
//             //                   return  ListView.builder(
//             //       scrollDirection: Axis.vertical,
//             //       itemCount: gtserv.data.users.length,
//             //       shrinkWrap: true,
//             //       physics: NeverScrollableScrollPhysics(),
//             //       itemBuilder: (context, index) {


//             //         var userdata=gtserv.data.users[index];
//             //         var paytxt="Not Paid";
//             //         if(userdata.paid==1){
//             //           paytxt="Payment Received";
//             //         }
//             //         return  Container(
//             //     padding: EdgeInsets.symmetric(vertical: 5.0),
//             //     width: double.infinity,
//             //     child: DashboardList(
//             //       name: '${userdata.username}',
//             //       status: '$paytxt',
//             //       color: AppColors.appColorPrimary,
//             //       amount: '+ ${userdata.amtpaid}Coins',
//             //       // icon: Icons.call_made,//activate dis for not paid
//             //       // colors: Colors.red,
//             //       // iconcolor: Colors.red,
//             //     ),
//             //   );
//             //       });
//             //                 }
//             //               } else {
//             //                 return Text('');
//             //               }
//             //               break;
//             //           }
//             //           return Text('');
//             //         },
//             //       ),
      
//         ],
//       ),
//     ),
//   )
//     );
//   }

//         Future<void> userInfo() async {
//         final prefs = await StreamingSharedPreferences.instance;
//     var storeddetails = MyAppSettings(prefs);
//     if(mounted){
//     setState(() {
//       username= storeddetails.dusername.getValue();
//     });
//     var getbanks = await accountapi.userreferals();
// setState(() {
//      coinspaid=getbanks.totalpaid;
// totalrefrred=getbanks.total; 
//   });
//       var getnewdata = await accountapi.usersecdetails();
// setState(() {
//     totalpoint = getnewdata.maintotalpoints;
//     refpoint = getnewdata.refpoint;
//     salepoint = getnewdata.sellpoint;
//     buypoint = getnewdata.buypoint;
//     reflink =getnewdata.referallink;
//    });
//     }

    

//   }

//   withdrawl() async {
//      functionfile.onHorizontalLoading1(context);
//     var theinternet = await functionfile.isInternet();
//     var theinternet2 = await functionfile.checkInternetAccess();

//     try {
//       if (theinternet && theinternet2) {
   
//           var v = await accountapi.userwithdrawcoin().timeout(Duration(seconds: 20), onTimeout: () {
//             Navigator.of(context).pop(); 
//          toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
//          return null;
//           });

//         if(v!=null){
//             if (v.status == true) {
                           
//               Navigator.of(context).pop(); 
//             toast("Your LoadNG Point Bonus has been successfully withdrawn and your bank account has been credited. Thanks for using LoadNG",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
//        userInfo();
           
//           }else{
//             Navigator.of(context).pop(); 
//              toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
//           }
//         }
//       } else {
//         Navigator.of(context).pop(); 
//          toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
//       }
//     } on SocketException catch (_) {
//       Navigator.of(context).pop(); 
//        toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
//     }
//   }

// }


