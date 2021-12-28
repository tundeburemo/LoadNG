
import 'package:flutter/material.dart';
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
class SellBizSuit extends StatefulWidget {
  static var tag = "/SellBizSuit";
  String name;
  String image;
  String rate;
  int thecolors;
  int thetype;
  String theaddress;
  String thebnkaccno;
  String thebankname;
  String thecoinname;
  String thecolorcode;
  final RouteArgument routeArgument;

  SellBizSuit({Key key,@required this.routeArgument }) {
    name= this.routeArgument.argumentsList[0] as String;
    image=this.routeArgument.argumentsList[1] as String;
    rate =this.routeArgument.argumentsList[2] as String;
    thecolors =this.routeArgument.argumentsList[3] as int;
    thetype=this.routeArgument.argumentsList[4] as int;
    theaddress=this.routeArgument.argumentsList[5] as String;
    thebnkaccno=this.routeArgument.argumentsList[6] as String;
    thebankname=this.routeArgument.argumentsList[7] as String;
    thecoinname=this.routeArgument.argumentsList[8] as String;
    thecolorcode=this.routeArgument.argumentsList[9] as String;
  }
  @override
  SellBizSuitState createState() => SellBizSuitState();
}
// 9014
class SellBizSuitState extends State<SellBizSuit> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
      TextEditingController _wallet;

  var wallet=" ";
  var transid=" ";
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _key,
      appBar: appBar(context,"Sell ${widget.thecoinname}"), 
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap:(){

      Navigator.of(context).pushNamed('/UpdateBizSuit',
                                  arguments: new RouteArgument(argumentsList: [
                                     widget.name,
    widget.thetype,
    widget.thebnkaccno,
    widget.thebankname,
    widget.thecolorcode,
                                  ]));
              },
               child: Align(
                 alignment:Alignment.topRight,
                 child: Padding(
                   padding: const EdgeInsets.only(right:18.0),
                   child: Container(
                                        height:32,
                                        decoration: BoxDecoration(
                                          border:Border.all(width: 1,color:Color(0xfffae6fb)),
                                          borderRadius:BorderRadius.circular(10),
                                        color:Color(0xfffae6fb),
                              
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: text("Edit Wallet",
                              textColor: Colors.black26,
                              fontFamily: AppFontSize.montbold,
                              fontSize:9.0),
                                        ),
                                      ),
                 ),
               ),
             ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
              decoration: boxDecoration(showShadow: true,bgColor: Color(widget.thecolors)),
              child: Column(
                children: <Widget>[
                  Container(
                        decoration: boxDecoration(showShadow: true,bgColor: Color(widget.thecolors),radius: AppFontSize.spacing_standard),
                    child: Image.asset(widget.image,width: 50,height: 50,).paddingAll(AppFontSize.spacing_standard_new),
                  ),
                  toolBarTitle("Rate: ${widget.rate}").paddingTop(AppFontSize.spacing_standard_new),
                  text("${widget.thecoinname}",fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeSMedium).paddingTop(AppFontSize.spacing_standard),
                  text("${widget.name}",fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeSMedium).paddingTop(AppFontSize.spacing_standard),

        text(" Below is your dedicated ${widget.thecoinname} wallet address. You can send to the wallet anytime and you would be paid automattically into ${widget.thebnkaccno}/${widget.thebankname} .",maxLine: 13,isCentered: true,fontSize: AppFontSize.textSizeSmallest,fontFamily: AppFontSize.spinnaker).paddingTop(AppFontSize.spacing_control),

                ],
              ).paddingAll(AppFontSize.spacing_standard_new),
            ),
text("Wallet Address(Tap To Copy)",textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeSMedium),
GestureDetector(
  onTap: () {
                              Clipboard.setData(
                                new ClipboardData(
                                    text: '$wallet'),
                              );
                              toast("$wallet Address Copied to Clipboard");
                            },
  child: Container(
    color: AppColors.t12_edittext_background,
  child: Text("$wallet",style:TextStyle(color: AppColors.shadowdarkblack2,fontSize: 15.0),maxLines: 3,softWrap: true,textAlign: TextAlign.center,).paddingAll(10))),
                Container(
              width: double.infinity,
              margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
              decoration: boxDecoration(showShadow: true,bgColor: Color(0xfff1f4fb)),
              child: Column(
                children: <Widget>[
                  Container(
                        decoration: boxDecoration(showShadow: true,bgColor: Color(0xfff1f4fb),radius: AppFontSize.spacing_standard),
                    child:
                    (wallet!=null&&wallet!=" "?
                     QrImage(
  data: "$wallet",
  version: QrVersions.auto,
  size: 200.0,
):Container(child:text("Sorry QR Code not available now",textColor: AppColors.shadowdarkblack2), )),
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
      child:Container(
    decoration: boxDecoration(showShadow: true,radius: AppFontSize.spacing_standard),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset(AppImage.t12_tick,width: 90,height: 90,).paddingTop(50),
        toolBarTitle("Processing").paddingTop(AppFontSize.spacing_large),
        text("Your selected bank account shall be credited automatically after 1 confirmation. Click history below to monitor your incoming transactions.",maxLine: 8,isCentered: true,fontSize: AppFontSize.textSizeMedium,fontFamily: AppFontSize.spinnaker).paddingTop(AppFontSize.spacing_control),
        // text("Transaction ID: $transid",textColor: AppColors.shadowdarkblack,fontSize: AppFontSize.textSizeMedium).paddingTop(AppFontSize.spacing_standard_new).paddingBottom(70),
        SizedBox(
          width: double.infinity,
          child: MaterialButton(
            padding: EdgeInsets.only(top: AppFontSize.spacing_standard_new,bottom: AppFontSize.spacing_standard_new),
            child: text("GO TO HISTORY",
                textColor: Colors.white, fontFamily: AppFontSize.fontMedium,maxLine: 2),
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(AppFontSize.spacing_standard)),
            color: AppColors.t12_primary_color,
            onPressed: ()  {
              Navigator.pop(context);
              Navigator.of(context).pushNamed('/userhistory'); 
            },
          ),
        ).paddingAll(AppFontSize.spacing_standard_new)
      ],
    ).paddingAll(AppFontSize.spacing_standard_new),
  ),
      ));

                            },
                            child: Container(
                              // margin: EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text("I Have Sent", textColor: AppColors.realblack, isCentered: true),
                              decoration: boxDecoration(bgColor: Color(widget.thecolors), radius: 8),
                            ),
                          ),
          ],
        ),
      ),
    );
  }

    @override
  void initState() {
    _wallet = TextEditingController();
    getwall();
    super.initState();
  }
  getwall(){
  setState(() {
  _wallet.text=  widget.theaddress;
  wallet= widget.theaddress;
  });
  }

  @override
  void dispose() {
    _wallet.clear();
    super.dispose();
  }


}
