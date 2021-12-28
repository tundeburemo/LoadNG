
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadng/model/account/UserstatisticModel.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppText.dart';


var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();
class UserStatistics extends StatefulWidget {
  static String tag = '/userstatistics';
  @override
  UserStatisticsState createState() => UserStatisticsState();
}
class UserStatisticsState extends State<UserStatistics> {
  var selectedTab=0;
  Future allstatistics;
  @override
  void initState() {
    internetcheck();
    super.initState();
  }

              internetcheck() async{ 
      var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

      if (theinternet && theinternet2) {
         setState(() {
     allstatistics=accountapi.userstatistics();
         });
      }else{
      functionfile.showerror(context);
      }
  }
  
  @override 
  Widget build(BuildContext context) { 
    var width=MediaQuery.of(context).size.width;
    var categoryWidth=(width-56)/4;
    return Scaffold(
      appBar: appBar(context,"Statistics"),
      body: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(AppFontSize.spacing_standard),
                decoration: boxDecoration(showShadow: true,bgColor: selectedTab==0?AppColors.t12_primary_color:Colors.white,radius: AppFontSize.spacing_large),
                child: text("All",textColor: selectedTab==0?Colors.white:AppColors.t12_text_secondary,fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeMedium).paddingOnly(top: AppFontSize.spacing_standard,bottom: AppFontSize.spacing_standard,left: AppFontSize.spacing_large,right: AppFontSize.spacing_large).onTap((){
                  setState(() {
                    selectedTab=0;
                  });
                },borderRadius: BorderRadius.circular(AppFontSize.spacing_large)),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(AppFontSize.spacing_standard),
                  alignment: Alignment.center,
                  decoration: boxDecoration(showShadow: true,bgColor: selectedTab==1?AppColors.t12_primary_color:Colors.white,radius: AppFontSize.spacing_large),
                  child: text("Sell",textColor: selectedTab==1?Colors.white:AppColors.t12_text_secondary,fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeMedium).paddingOnly(top: AppFontSize.spacing_standard,bottom: AppFontSize.spacing_standard,left: AppFontSize.spacing_large,right: AppFontSize.spacing_large).onTap((){
                    setState(() {
                      selectedTab=1;
                    });
                  },borderRadius: BorderRadius.circular(AppFontSize.spacing_large)),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(AppFontSize.spacing_standard),
                  decoration: boxDecoration(showShadow: true,bgColor: selectedTab==2?AppColors.t12_primary_color:Colors.white,radius: AppFontSize.spacing_large),
                  child: text("Buy",textColor: selectedTab==2?Colors.white:AppColors.t12_text_secondary,fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeMedium).paddingOnly(top: AppFontSize.spacing_standard,bottom: AppFontSize.spacing_standard,left: AppFontSize.spacing_large,right: AppFontSize.spacing_large).onTap((){
                    setState(() {
                      selectedTab=2;
                    });
                  },borderRadius: BorderRadius.circular(AppFontSize.spacing_large)),
                ),
              )
            ],
          ).paddingOnly(left: AppFontSize.spacing_standard,right: AppFontSize.spacing_standard),

          (selectedTab==0?Expanded(child:SingleChildScrollView(child:
         Padding(
            padding: EdgeInsets.only(left: AppFontSize.spacing_standard_new,right: AppFontSize.spacing_standard_new),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                  FutureBuilder<UserstatisticModel>(
                    future: allstatistics,
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
                            if (gtserv.data==null) {
                              return Center(
                                  child: Text('No Data Available',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                      )));
                            } else {
                              return  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                   var mystat=gtserv.data;
                    return
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text("Paxful",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily: AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Total Paxful Transactions",transactionamt: "${mystat.totalpaxfultrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Successful Sold Paxful",transactionamt:"${mystat.totalsuccsellpax}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Successful Sold Paxful(₦)",transactionamt:"₦${mystat.totalsuccsellnairapax}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Successful Sold Paxful(\$)",transactionamt:"\$${mystat.totalsuccsellusdpax}",categoryWidth:categoryWidth),

              
              text("Universal",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Total Universal Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Successful Sold Universal",transactionamt:"${mystat.totalsuccselluni}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Successful Sold Universal(₦)",transactionamt:"₦${mystat.totalsuccsellnairauni}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Successful Sold Universal(\$)",transactionamt:"\$${mystat.totalsuccsellusduni}",categoryWidth:categoryWidth),
          
              text("Blockchain",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.uni,transactionname:"Total Blockchain Transactions",transactionamt:"${mystat.totalblockchaintrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.uni,transactionname:"Successful Sold Blockchain",transactionamt:"${mystat.totalsuccsellbc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.uni,transactionname:"Successful Sold Blockchain(₦)",transactionamt:"₦${mystat.totalsuccsellnairabc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.uni,transactionname:"Successful Sold Blockchain(\$)",transactionamt:"\$${mystat.totalsuccsellusdbc}",categoryWidth:categoryWidth),

              text("ETH",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.eth,transactionname:"Total ETH Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.eth,transactionname:"Successful Sold ETH",transactionamt:"${mystat.totalsuccselleth}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.eth,transactionname:"Successful Sold ETH(₦)",transactionamt:"₦${mystat.totalsuccsellnairaeth}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.eth,transactionname:"Successful Sold ETH(\$)",transactionamt:"\$${mystat.totalsuccsellusdeth}",categoryWidth:categoryWidth),

              text("USDC",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.usd,transactionname:"Total USDC Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.usd,transactionname:"Successful Sold USDC",transactionamt:"${mystat.totalsuccsellusdc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.usd,transactionname:"Successful Sold USDC(₦)",transactionamt:"₦${mystat.totalsuccsellnairusdc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.usd,transactionname:"Successful Sold USDC(\$)",transactionamt:"\$${mystat.totalsuccsellusdusdc}",categoryWidth:categoryWidth),

              text("LTC",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.ltc,transactionname:"Total LTC Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Successful Sold LTC",transactionamt:"${mystat.totalsuccsellltc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Successful Sold LTC(₦)",transactionamt:"₦${mystat.totalsuccsellnairaltc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Successful Sold LTC(\$)",transactionamt:"\$${mystat.totalsuccsellusdltc}",categoryWidth:categoryWidth),

              text("BCH",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.bch,transactionname:"Total BCH Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.bch,transactionname:"Successful Sold BCH",transactionamt:"${mystat.totalsuccsellbch}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.bch,transactionname:"Successful Sold BCH(₦)",transactionamt:"₦${mystat.totalsuccsellnairabch}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.bch,transactionname:"Successful Sold BCH(\$)",transactionamt:"\$${mystat.totalsuccsellusdbch}",categoryWidth:categoryWidth),

              text("Perfect Money",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.pm,transactionname:"Total Perfect Money Transactions",transactionamt:"${mystat.totalpmtrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.pm,transactionname:"Successful Sold Perfect Money",transactionamt:"${mystat.totalsuccsellpm}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.pm,transactionname:"Successful Sold Perfect Money(₦)",transactionamt:"₦${mystat.totalsuccsellnairapm}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.pm,transactionname:"Successful Sold Perfect Money(\$)",transactionamt:"\$${mystat.totalsuccsellusdpm}",categoryWidth:categoryWidth),

              text("All Sold",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily: AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Sold Transactions",transactionamt:"${mystat.totalsuccsellall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Sold Transactions",transactionamt:"${mystat.totalsuccsellall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Sold Transactions(₦)",transactionamt:"₦${mystat.totalsuccsellnairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Sold Transactions(\$)",transactionamt:"\$${mystat.totalsuccsellusdall}",categoryWidth:categoryWidth),


ListView.builder( 
        scrollDirection: Axis.vertical,
        itemCount: mystat.totalsuccbuyalljoin.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var buytans=mystat.totalsuccbuyalljoin[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text("${buytans.name}",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total CoinName Transactions",transactionamt:"${mystat.name}",categoryWidth:categoryWidth),

              // transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Bought CoinName",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Amount Purchased (NGN)",transactionamt:"₦${buytans.totalnaira}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Amount Purchased (USD)",transactionamt:"\$${buytans.totalusd}",categoryWidth:categoryWidth),

            ],
          );
        }),
              text("All Bought",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Bought Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Number of Buy Coin Transactions",transactionamt:"${mystat.totalsuccbuyall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Purchased (NGN)",transactionamt:"₦${mystat.totalsuccbuynairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Purchased (USD)",transactionamt:"\$${mystat.totalsuccbuyusdall}",categoryWidth:categoryWidth),
                         
            ]);
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
            ],
          )
          ))):Container()),

                    (selectedTab==1?Expanded(child:SingleChildScrollView(child:   Padding(
            padding: EdgeInsets.only(left: AppFontSize.spacing_standard_new,right: AppFontSize.spacing_standard_new),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                        FutureBuilder<UserstatisticModel>(
                    future: allstatistics,
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
                            if (gtserv.data==null) {
                              return Center(
                                  child: Text('No Data Available',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                      )));
                            } else {
                              return  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                   var mystat=gtserv.data;
                    return
            Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text("Paxful",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily: AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Total Paxful Transactions",transactionamt: "${mystat.totalpaxfultrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Successful Sold Paxful",transactionamt:"${mystat.totalsuccsellpax}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Successful Sold Paxful(₦)",transactionamt:"₦${mystat.totalsuccsellnairapax}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Successful Sold Paxful(\$)",transactionamt:"\$${mystat.totalsuccsellusdpax}",categoryWidth:categoryWidth),

              
              text("Universal",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Total Universal Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Successful Sold Universal",transactionamt:"${mystat.totalsuccselluni}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Successful Sold Universal(₦)",transactionamt:"₦${mystat.totalsuccsellnairauni}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Successful Sold Universal(\$)",transactionamt:"\$${mystat.totalsuccsellusduni}",categoryWidth:categoryWidth),
          
              text("Blockchain",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.uni,transactionname:"Total Blockchain Transactions",transactionamt:"${mystat.totalblockchaintrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.uni,transactionname:"Successful Sold Blockchain",transactionamt:"${mystat.totalsuccsellbc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.uni,transactionname:"Successful Sold Blockchain(₦)",transactionamt:"₦${mystat.totalsuccsellnairabc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.uni,transactionname:"Successful Sold Blockchain(\$)",transactionamt:"\$${mystat.totalsuccsellusdbc}",categoryWidth:categoryWidth),

              text("ETH",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.eth,transactionname:"Total ETH Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.eth,transactionname:"Successful Sold ETH",transactionamt:"${mystat.totalsuccselleth}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.eth,transactionname:"Successful Sold ETH(₦)",transactionamt:"₦${mystat.totalsuccsellnairaeth}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.eth,transactionname:"Successful Sold ETH(\$)",transactionamt:"\$${mystat.totalsuccsellusdeth}",categoryWidth:categoryWidth),

              text("USDC",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.usd,transactionname:"Total USDC Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.usd,transactionname:"Successful Sold USDC",transactionamt:"${mystat.totalsuccsellusdc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.usd,transactionname:"Successful Sold USDC(₦)",transactionamt:"₦${mystat.totalsuccsellnairusdc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.usd,transactionname:"Successful Sold USDC(\$)",transactionamt:"\$${mystat.totalsuccsellusdusdc}",categoryWidth:categoryWidth),

              text("LTC",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.ltc,transactionname:"Total LTC Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Successful Sold LTC",transactionamt:"${mystat.totalsuccsellltc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Successful Sold LTC(₦)",transactionamt:"₦${mystat.totalsuccsellnairaltc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Successful Sold LTC(\$)",transactionamt:"\$${mystat.totalsuccsellusdltc}",categoryWidth:categoryWidth),

              text("BCH",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.bch,transactionname:"Total BCH Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.bch,transactionname:"Successful Sold BCH",transactionamt:"${mystat.totalsuccsellbch}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.bch,transactionname:"Successful Sold BCH(₦)",transactionamt:"₦${mystat.totalsuccsellnairabch}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.bch,transactionname:"Successful Sold BCH(\$)",transactionamt:"\$${mystat.totalsuccsellusdbch}",categoryWidth:categoryWidth),

              text("Perfect Money",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.pm,transactionname:"Total Perfect Money Transactions",transactionamt:"${mystat.totalpmtrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.pm,transactionname:"Successful Sold Perfect Money",transactionamt:"${mystat.totalsuccsellpm}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.pm,transactionname:"Successful Sold Perfect Money(₦)",transactionamt:"₦${mystat.totalsuccsellnairapm}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.pm,transactionname:"Successful Sold Perfect Money(\$)",transactionamt:"\$${mystat.totalsuccsellusdpm}",categoryWidth:categoryWidth),

              text("All Sold",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily: AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Sold Transactions",transactionamt:"${mystat.totalsuccsellall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Sold Transactions",transactionamt:"${mystat.totalsuccsellall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Sold Transactions(₦)",transactionamt:"₦${mystat.totalsuccsellnairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Sold Transactions(\$)",transactionamt:"\$${mystat.totalsuccsellusdall}",categoryWidth:categoryWidth),

            ]);
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
            ],
          )
          ))):Container()),

             (selectedTab==2?Expanded(child:SingleChildScrollView(child:   Padding(
            padding: EdgeInsets.only(left: AppFontSize.spacing_standard_new,right: AppFontSize.spacing_standard_new),
            child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
                   FutureBuilder<UserstatisticModel>(
                    future: allstatistics,
                    builder: (context, gtserv) {
                      
                      switch (gtserv.connectionState) {
                        case ConnectionState.none:
                          return Text('No Internet Connection');
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
                            if (gtserv.data==null) {
                              return Center(
                                  child: Text('No Data Available',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                      )));
                            } else {
                              return  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 1,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                   var mystat=gtserv.data;
                    return
            Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
ListView.builder( 
        scrollDirection: Axis.vertical,
        itemCount: mystat.totalsuccbuyalljoin.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var buytans=mystat.totalsuccbuyalljoin[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text("${buytans.name}",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total CoinName Transactions",transactionamt:"${mystat.name}",categoryWidth:categoryWidth),

              // transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Bought CoinName",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Amount Purchased (NGN)",transactionamt:"₦${buytans.totalnaira}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Amount Purchased (USD)",transactionamt:"\$${buytans.totalusd}",categoryWidth:categoryWidth),

            ],
          );
        }),

              text("All Bought",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Bought Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Number of Buy Coin Transactions",transactionamt:"${mystat.totalsuccbuyall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Purchased (NGN)",transactionamt:"₦${mystat.totalsuccbuynairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Purchased (USD)",transactionamt:"\$${mystat.totalsuccbuyusdall}",categoryWidth:categoryWidth),
                         
            ]);
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
        
                         
            ],
          )
          ))):Container()),

        ],
      ),
    );
  }
}