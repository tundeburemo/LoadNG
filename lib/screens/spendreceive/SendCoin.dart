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
import 'package:flutter/cupertino.dart';
import 'package:loadng/services/apis/spendreceive.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:loadng/styles/AppText.dart';

var spendreceiveapi = locator<SpendReceiveApi>();
var functionfile = locator<CustomFunction>();
var bankapi = locator<BankApi>();

// ignore: must_be_immutable
class SendCoinPage extends StatefulWidget {
  static var tag = "/sendcoin";
String address;
String image;
String name;
String trackid;
String cointype;
 final RouteArgument routeArgument;

  SendCoinPage({Key key,@required this.routeArgument }) {
    address= this.routeArgument.argumentsList[0] as String;
    image=this.routeArgument.argumentsList[1] as String;
    name =this.routeArgument.argumentsList[2] as String;
    trackid=this.routeArgument.argumentsList[3] as String;
    cointype=this.routeArgument.argumentsList[4] as String;
  }
  @override
  SendCoinPageState createState() => SendCoinPageState();
}

class SendCoinPageState extends State<SendCoinPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
      TextEditingController _feetosend,_pass,_addrestosendto,_tfare;
 var allbanks=<String>[];
    String dropdownNames;
  List<String> listOfCategory = [];
  var thecolor=0xffd9e1ff;
var coinshort="";
  Barcode result;
  QRViewController controller;
 int checking=0;


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

  @override
  Widget build(BuildContext context) {
          var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    coinshort=widget.cointype.toUpperCase();
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
                  colors: <Color>[Color(thecolor), AppColors.iconColorPrimary]),
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
                    colors: <Color>[Color(thecolor), AppColors.iconColorPrimary]),
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
                                      child: Image.network(
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
                                          // text("Rate: ${widget.rate}",fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeSMedium),
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
                            height: height/1.2,
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                   Row (
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[ 
                                       text("Address To send to", 
                                    textColor: AppColors.primaryDark,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
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
                              ]),
                                formField(
                                  context,
                                  "Address",
                                  isPassword: false,
                                  controller: _addrestosendto,
                                  prefixIcon: Icons.contact_mail,
                                  ontap: (){
                                 FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
                                  }
                                  // fontSize: AppFontSize.textSizeNormal,
                                ),
SizedBox(height:5),


                                text("Amount to send($coinshort)", 
                                    textColor: AppColors.primaryDark,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
                                formField(
                                  context,
                                  "Amount",
                                  isPassword: false,
                                  controller: _feetosend,
                                  prefixIcon: Icons.attach_money,
                                  ontap: ()async{
                                        if(_addrestosendto.text.isNotEmpty&&_addrestosendto.text!=' '&&_addrestosendto.text!=''&&_feetosend.text.isNotEmpty&&_feetosend.text!=' '&&_feetosend.text!=''){
                                     var v = await spendreceiveapi.srfeecalculator(trackid:widget.trackid,addresstosendto:_addrestosendto.text,feetosend:_feetosend.text
          ).timeout(Duration(seconds: 20), onTimeout: () {
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
              var ddata=v.msg;
              var splitter= ddata.split("|");
              setState(() {
                _tfare.text=splitter[1];

              });

                    //  "$finalfee|$feeusd|$orderworthy";//btctopay|usdform|usdtosend
            }  else {
               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
        }
                                        }
                FocusScopeNode currentFocus = FocusScope.of(context);
                 if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
                }
                                  }
                                  // fontSize: AppFontSize.textSizeNormal,
                                ),
SizedBox(height:5),
      text("Password", 
                                    textColor: AppColors.primaryDark,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
                                formField(
                                  context,
                                  "Password",
                                  isPassword: true,
                                  controller: _pass,
                                  prefixIcon: Icons.security,
                                  ontap: (){
                                 FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
                                  }
                                  // fontSize: AppFontSize.textSizeNormal,
                                ),
                                
                                SizedBox(height:5),         
                                                          Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[   text("Transfer Fee",
                                    textColor: AppColors.primaryDark,
                                    fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeMedium),
                                    text("(\$)",
                                    textColor: AppColors.primaryDark,fontSize: AppFontSize.textSizeMedium),]),
                               Material(
                                       color:Color(thecolor),
                  child:  EditText(
                                  textColor: AppColors.appLightRed,
                                  editable:true,
                                  isPassword: false,
                                  mController: _tfare,
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
          TopBar(titleName:"Send ${widget.name}"),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: (){
                sendcoin(trackid:widget.trackid,addresstosendto:_addrestosendto.text,feetosend:_feetosend.text,useraddress:widget.address,password:_pass.text);
              },
child: Container(
              alignment: Alignment.center,
              width: width,
              height: 50,
              decoration: BoxDecoration(
                color: Color(thecolor),
              ),
              child: text("SEND NOW",
                  fontFamily: AppFontSize.montbold,fontSize: AppFontSize.textSizeMedium),
            ),
          )
          )
        ],
      ),
    ));
  }



    @override
  void initState() {
   _feetosend = TextEditingController();
   _pass = TextEditingController();
   _addrestosendto= TextEditingController();
   _tfare= TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _tfare.clear();
    _feetosend.clear();
   _pass.clear();
   _addrestosendto.clear();
    controller?.dispose();
    super.dispose();
  }

 void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        var breakme=result.code.split(":");
        _addrestosendto.text=breakme[1];
      });
         if(_addrestosendto.text!=null&&_addrestosendto.text.isNotEmpty&&checking==1){
      Navigator.of(context).pop(); 
         setState(() {
      checking=0;
    });
    }
 
    });
 
  }


  
sendcoin({trackid,addresstosendto,feetosend,useraddress,password}) async {
                      functionfile.onHorizontalLoading1(context);
    var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

    try {
      if (theinternet && theinternet2) {
        if (trackid.isEmpty) {
          Navigator.of(context).pop();
          toast('Coin can not be empty',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        }else if (addresstosendto.isEmpty) {
          Navigator.of(context).pop();
          toast('Address to send to can not be null',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (feetosend.isEmpty) {
          Navigator.of(context).pop();
          toast('Amount to send can not be null',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else if (password.isEmpty) {
          Navigator.of(context).pop();
          toast('Password can not be null',gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
        } else {

          var v = await spendreceiveapi.usersendcoin(trackid:trackid,addresstosendto:addresstosendto,feetosend:feetosend,useraddress:useraddress,password:password
          ).timeout(Duration(seconds: 20), onTimeout: () {
            Navigator.of(context).pop();
         toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
         return null;
          });

        if(v!=null){
            if (v.status == true) {
             Navigator.of(context).pop();  
             toast("Coin Sent Successfully",gravity:ToastGravity.CENTER,bgColor: AppColors.appDark_parrot_green);
                         Navigator.of(context).pushNamed('/mysrwallets'); 
            }  else {
             Navigator.of(context).pop();  

               toast(v.msg,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
            }
          }else{
             Navigator.of(context).pop();  

             toast(AppTexts.nointerneterr,gravity:ToastGravity.CENTER,bgColor: AppColors.appLightRed);
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
