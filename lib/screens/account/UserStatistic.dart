
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
              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Number of all Paxful transactions",transactionamt: "${mystat.totalpaxfultrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Number of successful Paxful transactions",transactionamt:"${mystat.totalsuccsellpax}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Naira value of successful Paxful transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairapax}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.paxful,transactionname:"USD value of successful Paxful transactions (USD) ",transactionamt:"\$${mystat.totalsuccsellusdpax}",categoryWidth:categoryWidth),

              text("Universal",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Total Universal Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Number of successful Universal transactions",transactionamt:"${mystat.totalsuccselluni}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Naira value of successful Universal transactions(NGN)",transactionamt:"₦${mystat.totalsuccsellnairauni}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"USD value of successful Universal transactions(USD)",transactionamt:"\$${mystat.totalsuccsellusduni}",categoryWidth:categoryWidth),
          
              text("Blockchain",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.uni,transactionname:"Number of all Blockchain Transactions",transactionamt:"${mystat.totalblockchaintrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.uni,transactionname:"Number of successful Blockchain transactions",transactionamt:"${mystat.totalsuccsellbc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.uni,transactionname:"Naira value of successful Blockchain transactions(NGN)",transactionamt:"₦${mystat.totalsuccsellnairabc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.uni,transactionname:"USD value of successful Blockchain transactions(USD)",transactionamt:"\$${mystat.totalsuccsellusdbc}",categoryWidth:categoryWidth),

              text("ETH",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.eth,transactionname:"Total ETH Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.eth,transactionname:"Number of successful ETH transactions",transactionamt:"${mystat.totalsuccselleth}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.eth,transactionname:"Naira value of successful ETH transactions(NGN)",transactionamt:"₦${mystat.totalsuccsellnairaeth}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.eth,transactionname:"USD value of successful ETH transactions(USD)",transactionamt:"\$${mystat.totalsuccsellusdeth}",categoryWidth:categoryWidth),

              text("USDC",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.usd,transactionname:"Total USDC Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.usd,transactionname:"Number of successful USDC transactions",transactionamt:"${mystat.totalsuccsellusdc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.usd,transactionname:"Naira value of successful USDC transactions(NGN)",transactionamt:"₦${mystat.totalsuccsellnairusdc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.usd,transactionname:"USD value of successful USDC transactions(USD)",transactionamt:"\$${mystat.totalsuccsellusdusdc}",categoryWidth:categoryWidth),

              text("LTC",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.ltc,transactionname:"Total LTC Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Number of successful LTC transactions",transactionamt:"${mystat.totalsuccsellltc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Naira value of successful LTC transactions(NGN)",transactionamt:"₦${mystat.totalsuccsellnairaltc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.ltc,transactionname:"USD value of successful LTC transactions(USD)",transactionamt:"\$${mystat.totalsuccsellusdltc}",categoryWidth:categoryWidth),

              text("BCH",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.bch,transactionname:"Total BCH Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.bch,transactionname:"Number of successful BCH transactions",transactionamt:"${mystat.totalsuccsellbch}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.bch,transactionname:"Naira value of successful BCH transactions(NGN)",transactionamt:"₦${mystat.totalsuccsellnairabch}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.bch,transactionname:"USD value of successful BCH transactions(USD)",transactionamt:"\$${mystat.totalsuccsellusdbch}",categoryWidth:categoryWidth),

              text("Perfect Money",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.pm,transactionname:"Number of all Perfect Money transactions",transactionamt:"${mystat.totalpmtrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.pm,transactionname:"Number of successful Perfect Money transactions",transactionamt:"${mystat.totalsuccsellpm}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.pm,transactionname:"Naira value of successful Perfect Money transactions(NGN)",transactionamt:"₦${mystat.totalsuccsellnairapm}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.pm,transactionname:"USD value of successful Perfect Money transactions(USD)",transactionamt:"\$${mystat.totalsuccsellusdpm}",categoryWidth:categoryWidth),

              text("All Sold",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily: AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Sold Transactions",transactionamt:"${mystat.totalsuccsellall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Number of successful transactions",transactionamt:"${mystat.totalsuccsellall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Naira value of successful transactions(NGN)",transactionamt:"₦${mystat.totalsuccsellnairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"USD value of successful transactions(USD)",transactionamt:"\$${mystat.totalsuccsellusdall}",categoryWidth:categoryWidth),


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



              
ListView.builder( 
        scrollDirection: Axis.vertical,
        itemCount: mystat.totalsuccgiftcalljoin.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var buytans=mystat.totalsuccgiftcalljoin[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text("${buytans.name}",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total CoinName Transactions",transactionamt:"${mystat.name}",categoryWidth:categoryWidth),

              // transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Bought CoinName",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Amount Sold (NGN)",transactionamt:"₦${buytans.totalnaira}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Amount Sold (USD)",transactionamt:"\$${buytans.totalusd}",categoryWidth:categoryWidth),

            ],
          );
        }),


        
              text("All Giftcard",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Bought Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Number of Giftcard Transactions",transactionamt:"${mystat.totalsuccgiftcall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Sold (NGN)",transactionamt:"₦${mystat.totalsuccgiftcnairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Sold (USD)",transactionamt:"\$${mystat.totalsuccgiftcusdall}",categoryWidth:categoryWidth),
                         

                                       
ListView.builder( 
        scrollDirection: Axis.vertical,
        itemCount: mystat.totalsuccbizalljoin.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var buytans=mystat.totalsuccbizalljoin[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text("${buytans.name}",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total CoinName Transactions",transactionamt:"${mystat.name}",categoryWidth:categoryWidth),

              // transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Bought CoinName",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Business Amount Sold (NGN)",transactionamt:"₦${buytans.totalnaira}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Business Amount Sold (USD)",transactionamt:"\$${buytans.totalusd}",categoryWidth:categoryWidth),

            ],
          );
        }),


        
              text("All LoadNG Business",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Bought Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Number of LoadNG Business Transactions",transactionamt:"${mystat.totalsuccbizall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Sold (NGN)",transactionamt:"₦${mystat.totalsuccbiznairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Sold (USD)",transactionamt:"\$${mystat.totalsuccbizusdall}",categoryWidth:categoryWidth),
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
              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Number of all Paxful transactions",transactionamt: "${mystat.totalpaxfultrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Number of successful Paxful transactions",transactionamt:"${mystat.totalsuccsellpax}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.paxful,transactionname:"Naira value of successful Paxful transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairapax}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.paxful,transactionname:"USD value of successful Paxful transactions (USD)",transactionamt:"\$${mystat.totalsuccsellusdpax}",categoryWidth:categoryWidth),

              
              text("Universal",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Total Universal Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Number of successful Universal transactions",transactionamt:"${mystat.totalsuccselluni}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"Naira value of successful Universal transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairauni}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.cashapp,transactionname:"USD value of successful Universal transactions (USD)",transactionamt:"\$${mystat.totalsuccsellusduni}",categoryWidth:categoryWidth),
          
              text("Blockchain",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.uni,transactionname:"Total Blockchain transactions",transactionamt:"${mystat.totalblockchaintrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.uni,transactionname:"Number of successful Blockchain transactions",transactionamt:"${mystat.totalsuccsellbc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.uni,transactionname:"Naira value of successful Blockchain transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairabc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.uni,transactionname:"USD value of successful Blockchain transactions (USD)",transactionamt:"\$${mystat.totalsuccsellusdbc}",categoryWidth:categoryWidth),

              text("ETH",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.eth,transactionname:"Total ETH Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.eth,transactionname:"Number of successful ETH transactions",transactionamt:"${mystat.totalsuccselleth}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.eth,transactionname:"Naira value of successful ETH transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairaeth}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.eth,transactionname:"USD value of successful ETH transactions (USD)",transactionamt:"\$${mystat.totalsuccsellusdeth}",categoryWidth:categoryWidth),

              text("USDC",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.usd,transactionname:"Total USDC Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.usd,transactionname:"Number of successful USDC transactions",transactionamt:"${mystat.totalsuccsellusdc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.usd,transactionname:"Naira value of successful USDC transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairusdc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.usd,transactionname:"USD value of successful transactions (USD)",transactionamt:"\$${mystat.totalsuccsellusdusdc}",categoryWidth:categoryWidth),

              text("LTC",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.ltc,transactionname:"Total LTC Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Number of successful LTC transactions",transactionamt:"${mystat.totalsuccsellltc}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.ltc,transactionname:"Naira value of successful LTC transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairaltc}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.ltc,transactionname:"USD value of successful LTC transactions (USD)",transactionamt:"\$${mystat.totalsuccsellusdltc}",categoryWidth:categoryWidth),

              text("BCH",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.bch,transactionname:"Total BCH Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.bch,transactionname:"Number of successful BCH transactions",transactionamt:"${mystat.totalsuccsellbch}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.bch,transactionname:"Naira value of successful BCH transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairabch}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.bch,transactionname:"USD value of successful BCH transactions (USD)",transactionamt:"\$${mystat.totalsuccsellusdbch}",categoryWidth:categoryWidth),

              text("Perfect Money",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              transactionWidget(transactionimg: AppImage.pm,transactionname:"Total Perfect Money transactions",transactionamt:"${mystat.totalpmtrans}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.pm,transactionname:"Number of successful Perfect Money transactions",transactionamt:"${mystat.totalsuccsellpm}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.pm,transactionname:"Naira value of successful Perfect Money transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairapm}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.pm,transactionname:"USD value of successful Perfect Money transactions (USD)",transactionamt:"\$${mystat.totalsuccsellusdpm}",categoryWidth:categoryWidth),

              text("All Sold",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily: AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Sold Transactions",transactionamt:"${mystat.totalsuccsellall}",categoryWidth:categoryWidth),
 
              transactionWidget(transactionimg: AppImage.others,transactionname:"Number of successful Transactions",transactionamt:"${mystat.totalsuccsellall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Naira value of successful transactions (NGN)",transactionamt:"₦${mystat.totalsuccsellnairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"USD value of successful transactions (USD)",transactionamt:"\$${mystat.totalsuccsellusdall}",categoryWidth:categoryWidth),
              
ListView.builder( 
        scrollDirection: Axis.vertical,
        itemCount: mystat.totalsuccgiftcalljoin.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var buytans=mystat.totalsuccgiftcalljoin[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text("${buytans.name}",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total CoinName Transactions",transactionamt:"${mystat.name}",categoryWidth:categoryWidth),

              // transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Bought CoinName",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Amount Sold (NGN)",transactionamt:"₦${buytans.totalnaira}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Amount Sold (USD)",transactionamt:"\$${buytans.totalusd}",categoryWidth:categoryWidth),

            ],
          );
        }),


        
              text("All Giftcard",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Bought Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Number of Giftcard Transactions",transactionamt:"${mystat.totalsuccgiftcall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Sold (NGN)",transactionamt:"₦${mystat.totalsuccgiftcnairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Sold (USD)",transactionamt:"\$${mystat.totalsuccgiftcusdall}",categoryWidth:categoryWidth),
                         

                                       
ListView.builder( 
        scrollDirection: Axis.vertical,
        itemCount: mystat.totalsuccbizalljoin.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var buytans=mystat.totalsuccbizalljoin[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              text("${buytans.name}",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total CoinName Transactions",transactionamt:"${mystat.name}",categoryWidth:categoryWidth),

              // transactionWidget(transactionimg: AppImage.others,transactionname:"Successful Bought CoinName",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Business Amount Sold (NGN)",transactionamt:"₦${buytans.totalnaira}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total ${buytans.name} Business Amount Sold (USD)",transactionamt:"\$${buytans.totalusd}",categoryWidth:categoryWidth),

            ],
          );
        }),


        
              text("All LoadNG Business",fontSize: AppFontSize.textSizeMedium,textColor: AppColors.t12_text_secondary,fontFamily:  AppFontSize.montbold).paddingOnly(top: 12,bottom: AppFontSize.spacing_standard),
              // transactionWidget(transactionimg: AppImage.others,transactionname:"Total Bought Transactions",transactionamt:"${mystat.}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Number of LoadNG Business Transactions",transactionamt:"${mystat.totalsuccbizall}",categoryWidth:categoryWidth),

              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Sold (NGN)",transactionamt:"₦${mystat.totalsuccbiznairaall}",categoryWidth:categoryWidth),
              
              transactionWidget(transactionimg: AppImage.others,transactionname:"Total Amount Sold (USD)",transactionamt:"\$${mystat.totalsuccbizusdall}",categoryWidth:categoryWidth),
              

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