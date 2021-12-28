import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import "package:loadng/model/system/route_argument.dart";
import 'dart:io';
import 'package:loadng/services/apis/bank.dart';
import 'package:loadng/services/apis/sell.dart';
import 'package:loadng/styles/AppText.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';





var sellapi = locator<SellApi>();
var functionfile = locator<CustomFunction>();
var bankapi = locator<BankApi>();

// ignore: must_be_immutable
class SellPaxful extends StatefulWidget {
  static var tag = "/sellpaxful";
String name;
String image;
String rate;
int thecolor;
 final RouteArgument routeArgument;

  SellPaxful({Key key,@required this.routeArgument }) {
    name= this.routeArgument.argumentsList[0] as String;
    image=this.routeArgument.argumentsList[1] as String;
     rate =this.routeArgument.argumentsList[2] as String;
     thecolor =this.routeArgument.argumentsList[3];

  }
  @override
  SellPaxfulState createState() => SellPaxfulState();
}

class SellPaxfulState extends State<SellPaxful> {
      final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
      bool _enablePullDown = true, chinternet = true;
  RefreshController _refreshController;
      TextEditingController _usdval,_nairaval;
 var allbanks=<String>[];
    String dropdownNames;

  @override
  Widget build(BuildContext context) {
   functionfile.changeStatusColor(Colors.transparent);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body:  Container( 
        decoration: BoxDecoration( 
                       borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                gradient: LinearGradient(
                  begin:Alignment.topRight,
                  colors: <Color>[Color(widget.thecolor), AppColors.iconColorPrimary]),
              ),
        child:  SmartRefresher(
          enablePullDown: _enablePullDown,
          header: WaterDropHeader(
            waterDropColor: Colors.cyan[900],
            complete: Text('Complete',
                style: TextStyle(
                    color: Colors.teal,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            failed: Text('Failed',
                style: TextStyle(color: Colors.red, fontSize: 18)),
          ),
          controller: _refreshController,
          onRefresh: _onRefresh,
          onLoading: _onLoading,
          child: Stack(
        children: <Widget>[
          // CachedNetworkImage(
          //   imageUrl: t2_profile_cover_page_54,
          //   width: width,
          //   height: height / 2.5,
          //   fit: BoxFit.cover,
          // ),
          // Image.asset(
          //   AppImage.loginbg,
          //   width: width,
          //   height: height / 2.5,  
          //   fit: BoxFit.cover,
          // ),
          
          SingleChildScrollView(
            child:
            
             Container(
              padding: EdgeInsets.only(top: height / 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
               
                  Container(
                    width: width,
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                gradient: LinearGradient(
                  begin:Alignment.topRight,
                    colors: <Color>[Color(widget.thecolor), AppColors.iconColorPrimary]),
              ),
                    // decoration: BoxDecoration(
                    //     color: AppColors.appColorPrimary,
                    //     borderRadius: BorderRadius.only(
                    //         topLeft: Radius.circular(24),
                    //         topRight: Radius.circular(24))),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(16),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 16,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
          widget.image,
            width: 80,
            height: 80,  
            fit: BoxFit.cover,
          ),
                                      //  CachedNetworkImage(
                                      //   imageUrl: t2_profile,
                                      //   width: 80,
                                      //   height: 80,
                                      // ),
                                    ),
                                    SizedBox(
                                      width: 24,
                                    ),
                                    Container(
                                      // width: 130,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                           FittedBox(
                                            child:
                                          text("${widget.name}",fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeMedium)),
                                          text("Rate: ${widget.rate}",fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeSMedium),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: width,
                          decoration: BoxDecoration(
                              color: AppColors.appWhite,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24),
                                  topRight: Radius.circular(24))),
                          child: Container(
                            width: width,
                            height: height/1.5,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                text("USD Value", 
                                    textColor: AppColors.primaryDark,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
                                formField(
                                  context,
                                  "USD VALUE",
                                  isPassword: false,
                                  controller: _usdval,
                                  prefixIcon: Icons.attach_money,
                                  ontap: (){
                                    if(_usdval.text.isNotEmpty&&_usdval.text!=' '&&_usdval.text!=''){
                                _nairaval.text=(double.parse(widget.rate) * double.parse(_usdval.text)).toString();
                                    }
                                 FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
                                  }
                                  // fontSize: AppFontSize.textSizeNormal,
                                ),
SizedBox(height:5),


                                 text("Account to pay",
                                    textColor: AppColors.primaryDark,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
                                 Material(
                                       color:AppColors.t1_view_color,
                  child: DropdownButton(
                    isExpanded: true,
                    // dropdownColor: AppColors.appWhite,
                    value: dropdownNames,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.realblack,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                      setState(() {
                        toast(newValue);
                        dropdownNames = newValue;
                                    if(_usdval.text.isNotEmpty&&_usdval.text!=' '&&_usdval.text!=''){
                                _nairaval.text=(double.parse(widget.rate) * double.parse(_usdval.text)).toString();
                                    }

                      });
                    },
                    items: allbanks.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),
                                                
                                                 SizedBox(height:5),         
                                                          Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[   text("Naira Value",
                                    textColor: AppColors.primaryDark,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
                                    text("(₦)",
                                    textColor: AppColors.primaryDark,fontSize: AppFontSize.textSizeMedium),]),
                               Material(
                                       color:Color(widget.thecolor),
                  child:  EditText(
                                  textColor: AppColors.appLightRed,
                                  editable:true,
                                  isPassword: false,
                                  mController: _nairaval,
                                  fontSize: AppFontSize.textSizeXXLarge,
                                ),),

                              
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          TopBar(titleName:"Sell ${widget.name}"),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: (){
                sellcoin(bankacc:dropdownNames,usdval:_usdval.text);
              },
child: Container(
              alignment: Alignment.center,
              width: width,
              height: 50,
              decoration: BoxDecoration(
                color: Color(widget.thecolor),
              ),
              child: text("SELL NOW",
                  fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeMedium),
            ),
          )
          )
        ],
      ),
    )
    
    ));
  }


    Future<void> userInfo() async {
          await Future.delayed(Duration(seconds: 1));
    // _key.currentState.openDrawer();
                      functionfile.onHorizontalLoading1(context);

var getbanks = await bankapi.userbanklist();
if(getbanks!=null){
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
  if(!allbanks.contains(getbanks.banks[i].bankaccno)){
    if(mounted){
      setState(() {
    allbanks.add("${getbanks.banks[i].bankaccno}/${getbanks.banks[i].bankname}");
  });
    }
  }
} 

if(allbanks==[]){
  Navigator.of(context).pop(); 
    showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title:  Text('Reload for bank list',
                style:  TextStyle(color: Colors.black, fontSize: 20.0)),
            content:  Text(
                'Ooops! Kindly check your internet connection as the list of your banks failed to load. Reload page to try again.'),
            actions: <Widget>[
               Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                            FlatButton(
                onPressed: (){
                    Navigator.pop(context);
                    allbanks=[];
                     userInfo();
                    },// this line dismisses the dialog
                child: new Text('Reload', style: TextStyle(fontSize: 18.0)),
              ),

             FlatButton(
                onPressed: () =>
                    Navigator.pop(context), // this line dismisses the dialog
                child: new Text('OK', style: TextStyle(fontSize: 18.0)),
              )
                                        ])
             
            ],
          ),
        );


}else{
  Navigator.of(context).pop(); 
}
  }else{
       Navigator.of(context).pop();
       functionfile.showerror(context);
    }
    }
    @override
  void initState() {
         _refreshController = RefreshController();
    _usdval = TextEditingController();
    _nairaval = TextEditingController();
    userInfo();
    super.initState();
  }

  @override
  void dispose() {
    _usdval.clear();
    _nairaval.clear();
    super.dispose();
  }

  
sellcoin({bankacc,usdval}) async {
                      functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (usdval.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter an amount',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (bankacc.isEmpty||bankacc==null||bankacc=='') {
          Navigator.of(context).pop();
          toast('Please choose a bank account',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {
var splitme=bankacc.split('/');
bankacc=splitme[0];
var sendtbnkid=0;
var getbanks = await bankapi.userbanklist();
if(getbanks!=null){
var thetotal = getbanks.banks.length;
var i=0;
for(i=0;i<thetotal;i++){
    if(getbanks.banks[i].bankaccno==bankacc){
    sendtbnkid= getbanks.banks[i].bankid;
    break;
  }
}

          var v = await sellapi.sellpaxful(amountselling:usdval,bankid:sendtbnkid
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
             toast("Transaction Initiated Successfully. Kindly wait while paxful loads...",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
 Uri theurl=Uri.parse("${v.selllink}");
Navigator.of(context).pushNamed('/inappwebview2',arguments: new RouteArgument(argumentsList: ["Paxful Payment",theurl ,"/paxhistory"])); 

      //  Navigator.push(context, MaterialPageRoute(builder: (context) => WebtwoTest(url:"${v.selllink}")));
            }  else {
             Navigator.of(context).pop();  

               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
          }else{
             Navigator.of(context).pop();  

             toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
          }
} else {
             Navigator.of(context).pop();  
         toast('Please Check your Internet Speed and retry',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
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

    _onLoading() {
    _refreshController.loadComplete();
  }
    _onRefresh() {
    setState(() {
      allbanks=[];
          userInfo();
          _refreshController.refreshCompleted();
      });
  }
}
