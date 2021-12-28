import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/styles/AppText.dart';
import "package:loadng/model/system/route_argument.dart";
import 'dart:io';
import 'package:loadng/services/apis/bank.dart';
import 'package:loadng/services/apis/sell.dart';
import 'package:loadng/services/apis/buycoin.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:loadng/services/appSettings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:flutter/foundation.dart';


var sellapi = locator<SellApi>();
var buycoinapi = locator<BuyCoins>();
var functionfile = locator<CustomFunction>();
var bankapi = locator<BankApi>();

// ignore: must_be_immutable
class BuyCoinsPage extends StatefulWidget {
  static var tag = "/buycoinorder";
String name;
String image;
String rate;
String thetrackid;
int thecolor;
 final RouteArgument routeArgument;

  BuyCoinsPage({Key key,@required this.routeArgument }) {
    name= this.routeArgument.argumentsList[0] as String;
    image=this.routeArgument.argumentsList[1] as String;
     rate =this.routeArgument.argumentsList[2] as String;
     thecolor =0xfffff9d9;
     thetrackid =this.routeArgument.argumentsList[4];


  }
  @override
  BuyCoinsPageState createState() => BuyCoinsPageState();
}

class BuyCoinsPageState extends State<BuyCoinsPage> {
final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
TextEditingController _usdval,_nairaval,_address,_tfee,_usdtopay;
  Barcode result;
  QRViewController controller;
 var allpriority=<String>[];
 var usersavedaddress=<String>[];
 var addresstype=<String>["Saved Address","New Address"];
 var addresstypeno=0;//1 saved 2 new
 var chosenaddresstype;
 var chosenaddress;
 var prioritytrackid;
 var providusacc;
 var billbal;
 var accname;
 int checking=0;
  final oCcy = new NumberFormat("#,##0.00", "en_US");


  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller.pauseCamera();
    } else if (Platform.isIOS) {
      controller.resumeCamera();
    }
  }



    String dropdownNames;
  List<String> listOfCategory = [];

  @override
  Widget build(BuildContext context) {
      var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
   functionfile.changeStatusColor(Colors.transparent);

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
                       borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24)),
                gradient: LinearGradient(
                  begin:Alignment.topRight,
                  colors: <Color>[Color(widget.thecolor), AppColors.iconColorPrimary]),
              ),
        child:Stack(
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
            child: Container(
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
                                        Column(
                                  children: <Widget>[
                                     FittedBox(
                                            child:
                                          text("${widget.name}",fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeSMedium)),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.asset(
          widget.image,
            width: 80,
            height: 80,  
            fit: BoxFit.cover,
          )),  text("Rate: ${widget.rate}",fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeSMedium),]),
                                      //  CachedNetworkImage(
                                      //   imageUrl: t2_profile,
                                      //   width: 80,
                                      //   height: 80,
                                      // ),
                                    
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
                                          
                                          Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[ FittedBox(
                                            child:
                                          text("Balance",textColor: AppColors.shadowdarkblack, fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeSMedium)),
                                                             
                                          ]),
                                            text("NGN $billbal",textColor: AppColors.black,fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeSMedium),
                        GestureDetector(
    onTap: (){
              showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>   
        Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: SingleChildScrollView(child: Container(
        decoration: new BoxDecoration(
          color: AppColors.appWhite,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(color: Colors.black26, blurRadius: 10.0, offset: const Offset(0.0, 10.0)),
          ],
        ),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
         Container(
                color:Color(widget.thecolor),
           child:  ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
              child: Image.asset(
          widget.image,
            width: MediaQuery.of(context).size.width,
            height: 120,  
            fit: BoxFit.contain,
          ),
              // Image(width: MediaQuery.of(context).size.width, image: sentimg, height: 120, fit: BoxFit.cover),
            )),
            24.height,
            Text('Fund Wallet', style: boldTextStyle(color: AppColors.appColorPrimary, size: 18,fontFamily: AppFontSize.montbold)),
            16.height,
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Text("To fund your bills wallet for the purpose of buying Cryptocurrency on LoadNG. Kindly make a transfer to your dedicated LoadNG bank account below. Your LoadNG bills balance will be updated as soon as it is successful.\n\nAccount Bank-Providus Bank \nAccount Name-$accname \nAccount Number-$providusacc", style: secondaryTextStyle(color: AppColors.appTextColorSecondary)),
            ),
            16.height,
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: boxDecoration(color: AppColors.appDark_parrot_green, radius: 8, bgColor: AppColors.appDark_parrot_green),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              WidgetSpan(child: Padding(padding: EdgeInsets.only(right: 8.0), child: Icon(Icons.close, color: Colors.white, size: 18))),
                              TextSpan(text: "OK", style: TextStyle(fontSize: 16.0, color: Colors.white, fontFamily: AppFontSize.fontRegular)),
                            ],
                          ),
                        ),
                      ),
                    ).onTap((){
                      Navigator.pop(context);
                    }),
                  ),
                  16.width,
               
                ],
              ),
            ),
            16.height,
          ],
        ),
      )),
    )
                        );
    },
     child:Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.shadowdarkblack,
              ),
              child:text("FUND",
              textColor: AppColors.white,
                  fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeSMedium).paddingAll(5),
            )),
                                          
                                        
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
                            height: height/1.05,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                text("Naira Value", 
                                    textColor: AppColors.shadowdarkblack,
                                    fontFamily: AppFontSize.montlight,fontSize: AppFontSize.textSizeMedium),
                                formField(
                                  context,
                                  "Amount in naira",
                                  isPassword: false,
                                  controller: _nairaval,
                                  textcolor:AppColors.thickLcolor,
                                  prefixIcon: Icons.money,
                                  ontap: (){
                                 FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
                                  }
                                  // fontSize: AppFontSize.textSizeNormal,
                                ),
                                
SizedBox(height:5),
   text("Address Type",
                                    textColor:AppColors.shadowdarkblack,
                                    fontFamily: AppFontSize.montlight,fontSize: AppFontSize.textSizeMedium),
                                 Material(
                                       color:AppColors.t1_view_color,
                  child: DropdownButton(
                    isExpanded: true,
                    // dropdownColor: AppColors.appWhite,
                    value: chosenaddresstype,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.realblack,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                     
                      setState(() {
                        toast(newValue);
                        chosenaddresstype = newValue;
                         if(newValue=="Saved Address"){
                           _address.text="";
                           savedaddress();
                          addresstypeno=1;
                        }else{
                          addresstypeno=2;
                        }
                      });

                      
                    },
                    items: addresstype.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),
                                                
                                                 SizedBox(height:5),  
Offstage(offstage: addresstypeno==1 || addresstypeno==0,
  child: Column (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
     Row (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[ 
                                
                                text("Address", 
                                    textColor: AppColors.shadowdarkblack,
                                    fontFamily: AppFontSize.montlight,fontSize: AppFontSize.textSizeMedium),
                                GestureDetector(
    onTap: (){
      setState(() {
        checking=1;
      });
              showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>   Scaffold(body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
             // To ensure the Scanner view is properly sizes after rotation
             // we need to listen for Flutter SizeChanged notification and update controller
            child: NotificationListener<SizeChangedLayoutNotification>(
              onNotification: (notification) {
                Future.microtask(() => controller?.updateDimensions(qrKey,scanArea: scanArea));
                return false;
              },
              child: SizeChangedLayoutNotifier(
                key: const Key('qr-size-notifier'),
                child: QRView(
                  key: qrKey,
                  onQRViewCreated: _onQRViewCreated,
                   overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea,
                )
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Row (
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Scan a code'),
                            GestureDetector(
                              onTap:(){
             Navigator.of(context).pop();  

                              },
                              child:  Icon(Icons.close,size: 35)),
                                ]
                                ).paddingAll(AppFontSize.spacing_standard),
            ),
          )
        ],
      ),));
              },
              child: text("Scan",
                  fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeMedium),
            
            ),
  GestureDetector(
    onTap: () async{
                      functionfile.onHorizontalLoading1(context);

        if(_address.text==""|| _address.text.isEmpty || _address.text.isEmptyOrNull){
          Navigator.of(context).pop();
         toast('Input address value please.',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else{
var v = await buycoinapi.usersaveaddress(cointrackid:widget.thetrackid,address:_address.text
          ).timeout(Duration(seconds: 20), onTimeout: () {
          Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
          return null;
          });

        if(v!=null){
            if (v.status == true) {
          Navigator.of(context).pop();
              var dsentdata= v.msg;
         toast('$dsentdata',gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
            }else {
          Navigator.of(context).pop();
         toast('Error Saving address,please try again later.',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
            }else{
          Navigator.of(context).pop();
         toast('Error Saving address,please try again later.',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed); 
            }
        }
    },
     child:Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                // color: Color(widget.thecolor),
              ),
              child: text("Save",
                  fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeMedium),
            ))

                                     ] ),
                                formField(
                                  context,
                                  "New Address",
                                  isPassword: false,
                                  controller: _address,
                                  prefixIcon: Icons.map,
                                  ontap: (){
                                 FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
                                  }
                                  // fontSize: AppFontSize.textSizeNormal,
                                )])),
SizedBox(height:5),
Offstage(offstage: addresstypeno==2 || addresstypeno==0,
  child: Column (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
     text("Saved Address", 
                                    textColor: AppColors.shadowdarkblack,
                                    fontFamily: AppFontSize.montlight,fontSize: AppFontSize.textSizeMedium),
                              Material(
                                       color:AppColors.t1_view_color,
                  child: DropdownButton(
                    isExpanded: true,
                    // dropdownColor: AppColors.appWhite,
                    value: chosenaddress,
                    style: boldTextStyle(),
                    icon: Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.realblack,
                    ),
                    underline: 0.height,
                    onChanged: (newValue) {
                      setState(() {
                        toast(newValue);
                        chosenaddress = newValue;
                       
                      });

                      
                    },
                    items: usersavedaddress.map((category) {
                      return DropdownMenuItem(
                        child: Text(category, style: primaryTextStyle()).paddingLeft(8),
                        value: category,
                      );
                    }).toList(),
                  )).paddingTop(AppFontSize.spacing_standard),
                  ])),
SizedBox(height:5),


                                 text("Priority",
                                    textColor: AppColors.shadowdarkblack,
                                    fontFamily: AppFontSize.montlight,fontSize: AppFontSize.textSizeMedium),
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
                    onChanged: (newValue) async{
                      setState(() {
                        toast(newValue);
                        dropdownNames = newValue;
                      });
if(_nairaval.text.isEmptyOrNull){
         toast('Input Naira value.',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
}else{
                      var splitme=newValue.split('(');
var blockname=splitme[0];
var getprio = await buycoinapi.allprioritylist();
if(getprio!=null){
var thetotal = getprio.priority.length;
var i=0;
for(i=0;i<thetotal;i++){
    if(getprio.priority[i].name==blockname){
        setState(() {
    prioritytrackid= getprio.priority[i].trackid;
        });
    break;
  }
}
}

var v = await buycoinapi.priorityfeecal(prioritytrackid:prioritytrackid,cointrackid:widget.thetrackid,amt:_nairaval.text
          ).timeout(Duration(seconds: 20), onTimeout: () {
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
          return null;
          });

        if(v!=null){
            if (v.status == true) {
              // roll all data in
              var dsentdata= v.msg;
              var splitme=dsentdata.split('|');
              // tbtcfee = splitme[0];
              // tusdfee = splitme[1];
              // topaybtcfee = splitme[2];
              // topayusdfee = splitme[3];
setState(() {
  _usdval.text=splitme[3];
  _tfee.text=splitme[1];
});

            }
            }
}
                    },
                    items: allpriority.map((category) {
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
                                        children: <Widget>[   text("Transfer Fee",
                                    textColor: AppColors.shadowdarkblack,
                                    fontFamily: AppFontSize.montlight,fontSize: AppFontSize.textSizeMedium),
                                    text("(\$)",
                                    textColor: AppColors.shadowdarkblack,fontSize: AppFontSize.textSizeMedium),]),
                               Material(
                                       color:Color(widget.thecolor),
                  child:  EditText(
                                  textColor: AppColors.appColorleafcolor,
                                  editable:true,
                                  isPassword: false,
                                  mController: _tfee,
                                  fontSize: AppFontSize.textSizeXXLarge,
                                ),),

        SizedBox(height:5),         
                                                          Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[   text("Amount you would get",
                                    textColor: AppColors.shadowdarkblack,
                                    fontFamily: AppFontSize.montlight,fontSize: AppFontSize.textSizeMedium),
                                    text("(\$)",
                                    textColor: AppColors.shadowdarkblack,fontSize: AppFontSize.textSizeMedium),]),
                               Material(
                                       color:Color(widget.thecolor),
                  child:  EditText(
                                  textColor: AppColors.appColorleafcolor,
                                  editable:true,
                                  isPassword: false,
                                  mController: _usdval,
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
                var addresstaken="";
               if(_address.text.isEmptyOrNull||_address.text.isEmpty||_address.text==""){
                 addresstaken =chosenaddress;
               }else{
                 addresstaken=_address.text;
               }

            buycoinnow(nairavalue:_nairaval.text,priorityid:prioritytrackid,address:addresstaken);
              },
child: Container(
              alignment: Alignment.center,
              width: width,
              height: 50,
              decoration: BoxDecoration(
                color: Color(widget.thecolor),
              ),
              child: text("BUY NOW",
                  fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeMedium),
            ),
          )
          )
        ],
      ),
    ));
  }


    Future<void> userInfo() async {
            await Future.delayed(Duration(seconds: 1));
    // _key.currentState.openDrawer();
                      functionfile.onHorizontalLoading1(context);

  final prefs = await StreamingSharedPreferences.instance;
    var storeddetails = MyAppSettings(prefs);
    if(mounted){
    setState(() {
      providusacc=storeddetails.dprovidusaccno.getValue();
      billbal = oCcy.format(double.parse(storeddetails.dbillbal.getValue()));
      accname= storeddetails.dfullname.getValue();
    });
    }
var getbanks = await buycoinapi.allprioritylist();
if(getbanks!=null){
var thetotal = getbanks.priority.length;
var i=0;
for(i=0;i<thetotal;i++){
  if(!allpriority.contains(getbanks.priority[i].name)){
    if(mounted){
      setState(() {
    allpriority.add("${getbanks.priority[i].name}(Block ${getbanks.priority[i].block})");
  });
    }
  }
}

if(allpriority==[]){
  Navigator.of(context).pop(); 
    showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title:  Text('Reload for priority list',
                style:  TextStyle(color: Colors.black, fontSize: 20.0)),
            content:  Text(
                'Ooops! Kindly check your internet connection as the list of priority failed to load. Reload page to try again.'),
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
                    allpriority=[];
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
}  }else{
       Navigator.of(context).pop();
       functionfile.showerror(context);
    }

  }


      Future<void> savedaddress() async {
var getaddresses = await buycoinapi.allusersavedaddress(cointrackid:widget.thetrackid);
var thetotal = getaddresses.address.length;
var i=0;
setState(() {
        chosenaddress=getaddresses.address[0].address;
});
for(i=0;i<thetotal;i++){
  if(!usersavedaddress.contains(getaddresses.address[i].address)){
    if(mounted){
      setState(() {
    usersavedaddress.add("${getaddresses.address[i].address}");
  });
    }
  }
}

  }

 void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        var breakme=result.code.split(":");
        _address.text=breakme[1];
      });
         if(_address.text!=null&&_address.text.isNotEmpty&&checking==1){
      Navigator.of(context).pop(); 
         setState(() {
      checking=0;
    });
    }
 
    });
 
  }


    @override
  void initState() {
    _usdval = TextEditingController();
    _nairaval = TextEditingController();
    _address = TextEditingController();
    _tfee = TextEditingController();
    _usdtopay =TextEditingController();
    userInfo();
    super.initState();
  }

  @override
  void dispose() {
    _usdval.clear();
    _nairaval.clear();
    _address.clear();
    _usdtopay.clear();
    _tfee.clear();
    controller?.dispose();
    super.dispose();
  }

  
buycoinnow({nairavalue,priorityid,address}) async {
                      functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (address==null||address.isEmpty) {
          Navigator.of(context).pop();
          toast('Please enter an address',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (nairavalue==null||nairavalue.isEmpty||nairavalue==''||nairavalue==0) {
          Navigator.of(context).pop();
          toast('Please input naira value',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (priorityid==null||priorityid.isEmpty||priorityid==''||priorityid==0) {
          Navigator.of(context).pop();
          toast('Please choose priority',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {

          var v = await buycoinapi.buycoin(prioritytrackid: priorityid,cointrackid: widget.thetrackid,amt:nairavalue,address: address
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
             toast("Transaction Initiated Successfully",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);

Navigator.of(context).pushNamed('/userdashboard'); 

            }  else {
             Navigator.of(context).pop();  

               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
          }else{
             Navigator.of(context).pop();  
             toast("Error placing order, please try again later.",gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
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
