import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadng/model/history/AllSellHistory.dart';
import 'package:loadng/services/apis/history.dart';
import 'package:loadng/services/apis/account.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:loadng/styles/AppText.dart';


var functionfile = locator<CustomFunction>();
var historyapi = locator<HistoryApi>();
var accountapi = locator<AccountApi>();


class UserPaxHistory extends StatefulWidget {
  static var tag = " ";

  @override
  UserPaxHistoryState createState() => UserPaxHistoryState();
}

class UserPaxHistoryState extends State<UserPaxHistory> {
  int selectedPos = 1;
  var dropdownNames;
  Future allhistory;
  

  @override
  void initState() {
    internetcheck();
    super.initState();
    selectedPos = 1;
  }

      internetcheck() async{
      var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

      if (theinternet && theinternet2) {
            setState(() {
          allhistory=historyapi.allpaxfulhistory(pg:1,search:" ");
            });
      }else{
      functionfile.showerror(context);
      }
  }

  @override
  Widget build(BuildContext context) {
   functionfile.changeStatusColor(Colors.transparent);
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      body: Container(
        alignment: Alignment.topLeft,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            appBarwithlink(context, "Paxful","/userdashboard"),
            Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, top: 20),
              child: text("History", textColor: AppColors.shadowdarkblack, fontFamily: AppFontSize.montlight, fontSize: AppFontSize.textSizeXLarge),
            ),
          Padding(
              padding: const EdgeInsets.only(top: 23),
              child: PopupMenuButton(
                      icon: Icon(
                        Icons.more_vert,
                        color: AppColors.shadowdarkblack,
                      ),
                       onSelected: (index){
if(index==1){
            Navigator.of(context).pushNamed('/userhistory');
}else if(index==2){
            Navigator.of(context).pushNamed('/paxhistory');
}else if(index==3){
            Navigator.of(context).pushNamed('/unihistory');
} else if(index==4){
            Navigator.of(context).pushNamed('/bchistory');
} else if(index==5){
            Navigator.of(context).pushNamed('/pmhistory');
}else if(index==6){
            Navigator.of(context).pushNamed('/otherhistory');
}
else if(index==7){
            Navigator.of(context).pushNamed('/bizhistory');
}else if(index==8){
            Navigator.of(context).pushNamed('/buycoinhistory');
}
   
                      },
                      itemBuilder: (context) {
                        var list = List<PopupMenuEntry<Object>>();
                         list.add(
                          PopupMenuItem(
                            child: Text("All"),
                            value: 1,
                          ),
                        );
                        list.add(
                          PopupMenuItem(
                            child: Text("Paxful"),
                            value: 2,
                          ),
                        );
                         list.add(
                          PopupMenuItem(
                            child:Container(child:Text("Universal")),
                             value: 3,
                          ),
                        );
                               list.add(
                          PopupMenuItem(
                            child: Text("Blockchain"),
                            value: 4,
                          ),
                        );
                                       list.add(
                          PopupMenuItem(
                            child: Text("Perfect Money"),
                            value: 5,
                          ),
                        );
                   list.add(
                          PopupMenuItem(
                            child:Text("Others"),
                            value: 6,
                          ),
                        );
                         list.add(
                          PopupMenuItem(
                            child:Text("Business"),
                            value: 7,
                          ),
                        );
                         list.add(
                          PopupMenuItem(
                            child:Text("Buy Coins"),
                            value: 8,
                          ),
                        );
                        return list;
                      },
                    )
          )
              
           
          ]),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20.0, right: 20),
                child: 
                         FutureBuilder<UserAllSellHistory>(
                    future:  allhistory,
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
                              'History not found, try again!',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ));
                          } else if (gtserv.hasData) {
                            if (gtserv.data.history==null || gtserv.data.history.isEmpty) {
                              return Center(
                                  child: Text('No History Available',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                      )));
                            } else {
        return      
                ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: gtserv.data.history.length,
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                             var myhistory =gtserv.data.history[index]; 
        var dnaira= myhistory.nairavalue;
        var  dusd= myhistory.usdvalue;
        var transimg =AppImage.others;
        var thestatusnum=myhistory.statusnumber;
        var realtransname= myhistory.name;
        var thehexcode = 0xfffae6fb;
        var transname= myhistory.name.toLowerCase();
        if(transname=="paxful btc"){
          transimg=AppImage.paxful;
        }else if(transname=="ethereum"){
          transimg=AppImage.eth;
        }else if(transname=="universal btc"){
          transimg=AppImage.uni;
        }else if(transname=="usd coin"){
          transimg=AppImage.usd;
        }else if(transname=="litecoin"){
          transimg=AppImage.ltc;
        }else if(transname=="bitcoin cash (bch)"){
          transimg=AppImage.bch;
        }else if(transname=="blockchain btc"){
          transimg=AppImage.cashapp;
        }else if(transname=="perfect money"){
          transimg=AppImage.pm;
        }     

          var cardcolor=Colors.black38;
  if(thestatusnum=="0"||thestatusnum==0){
    cardcolor = Colors.orangeAccent;
  }else if(thestatusnum=="1"||thestatusnum==1){
    cardcolor = Colors.green[300];
  }else if(thestatusnum=="2"||thestatusnum==2){
    cardcolor = AppColors.appColorPrimary;
  }else if(thestatusnum=="3"||thestatusnum==3){
    cardcolor = Colors.red[300];
  }else if(thestatusnum=="4"||thestatusnum==4){
    cardcolor = Colors.red[300];
  }else if(thestatusnum=="5"||thestatusnum==5){
    cardcolor = Colors.red[300];
  }else if(thestatusnum=="6"||thestatusnum==6){
    cardcolor = Colors.red[300];
  }


                      return Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 18, bottom: 18),
                            child: Row(
                              children: <Widget>[
                                // Column(
                                //   children: <Widget>[
                                //     text("OCt", fontSize: AppFontSize.textSizeSMedium),
                                //     text("12am", fontSize: AppFontSize.textSizeLargeMedium, textColor: AppColors.appColorPrimary),
                                //   ],
                                // ),
                                Image.asset(transimg,width:50,height: 50,).cornerRadiusWithClipRRect(AppFontSize.spacing_standard).paddingRight(AppFontSize.spacing_standard),
                                // Container(
                                //   decoration: boxDecoration(radius: 8, showShadow: true),
                                //   margin: EdgeInsets.only(left: 16, right: 16),
                                //   width: width / 7.2,
                                //   height: width / 7.2,
                                //   child:Image.asset(AppImage.paxful) ,//SvgPicture.asset(mListings[index].icon),
                                //   padding: EdgeInsets.all(width / 30),
                                // ),
                          
                               Expanded(
                                  child:    GestureDetector(
                               onTap: (){
                                 Navigator.of(context).pushNamed('/transactiondetails',arguments: new RouteArgument(argumentsList: [myhistory.name,myhistory.id,myhistory.ourrate,myhistory.usdvalue,myhistory.nairavalue,myhistory.orderid,myhistory.statusnumber,myhistory.date,myhistory.btcval,myhistory.payref,myhistory.paystatus,myhistory.statustext,myhistory.address,myhistory.hashlink,myhistory.hash,myhistory.images,thehexcode,transimg])); 
        //                       showDialog(
        // context: context,
        // builder: (BuildContext context) => HistoryDialog(name:realtransname,rate:myhistory.ourrate,usdval:dusd,nairaval:dnaira,status:myhistory.statustext,orderid:myhistory.orderid),);
                               },
                               child:Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          text("$realtransname", textColor: AppColors.appColorPrimary, fontSize: AppFontSize.textSizeSMedium, fontFamily: AppFontSize.montbold),
                                          text("\$$dusd", textColor: AppColors.appColorPrimary, fontSize: AppFontSize.textSizeSMedium, fontFamily: AppFontSize.fontSemibold)
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                         Row(
                                        children: <Widget>[
                                          text("${myhistory.statustext}", fontSize: AppFontSize.textSizeSMedium,fontFamily: AppFontSize.spinnaker,textColor: cardcolor),
                                           Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[ 
                                      text("₦",
                                              textColor: AppColors.appTextColorSecondary,
                                              fontFamily: AppFontSize.fontBold,
                                              fontSize: AppFontSize.textSizeSMedium)
                                          .paddingTop(AppFontSize.spacing_control),
                                  text("$dnaira",
                                              textColor: AppColors.appTextColorSecondary,
                                              fontFamily: AppFontSize.montbold,
                                              fontSize: AppFontSize.textSizeSMedium)
                                          .paddingTop(AppFontSize.spacing_control),
                                    ]),
                                        ],
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      ),
                                      
                                    ],
                                  ),
                                )
                                )
                              ],
                            ),
                          ),
                          Divider(
                            height: 0.5,
                            color:AppColors.cardBackgroundBlackDark,
                          )
                        ],
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
                  )  ),
            ),
          ],
        ),
      ),
    );
  }
}
