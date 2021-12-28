
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
import 'package:share/share.dart';
import 'package:loadng/services/apis/sell.dart';



var sellapi = locator<SellApi>();
var functionfile = locator<CustomFunction>();
var bankapi = locator<BankApi>();

// ignore: must_be_immutable
class ReceiveCoinPage extends StatefulWidget {
  static var tag = "/receivecoin";
String address;
String image;
String name;
String trackid;
 final RouteArgument routeArgument;

  ReceiveCoinPage({Key key,@required this.routeArgument }) {
    address= this.routeArgument.argumentsList[0] as String;
    image=this.routeArgument.argumentsList[1] as String;
    name =this.routeArgument.argumentsList[2] as String;
    trackid=this.routeArgument.argumentsList[3] as String;
  }
  @override
  ReceiveCoinPageState createState() => ReceiveCoinPageState();
}
// 9014
class ReceiveCoinPageState extends State<ReceiveCoinPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
      TextEditingController _wallet;

  var thecolors=0xffd9e1ff;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
        key: _key,
      appBar: appBar(context,"Receive ${widget.name}"), 
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: double.infinity,
              margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
              decoration: boxDecoration(showShadow: true,bgColor: Color(thecolors)),
              child: Column(
                children: <Widget>[
                  Container(
                        decoration: boxDecoration(showShadow: true,bgColor: Color(thecolors),radius: AppFontSize.spacing_standard),
                    child: Image.network(widget.image,width: 50,height: 50,).paddingAll(AppFontSize.spacing_standard_new),
                  ),
                  // toolBarTitle("Rate: ${widget.rate}").paddingTop(AppFontSize.spacing_standard_new),
                  text("${widget.name}",fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeSMedium).paddingTop(AppFontSize.spacing_standard),
        text(" Below Address is your dedicated ${widget.name} wallet.",maxLine: 9,isCentered: true,fontSize: AppFontSize.textSizeMedium,fontFamily: AppFontSize.spinnaker).paddingTop(AppFontSize.spacing_control),

                ],
              ).paddingAll(AppFontSize.spacing_standard_new),
            ),
text("Wallet Address(Tap To Copy)",textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeSMedium),
GestureDetector(
  onTap: () {
                              Clipboard.setData(
                                new ClipboardData(
                                    text: '${widget.address}'),
                              );
                              toast("${widget.address} Address Copied to Clipboard");
                            },
  child: Container(
    color: AppColors.t12_edittext_background,
  child: Text("${widget.address}",style:TextStyle(color: AppColors.shadowdarkblack2,fontSize: 15.0),maxLines: 3,softWrap: true,textAlign: TextAlign.center,).paddingAll(10))),
                Container(
              width: double.infinity,
              margin: EdgeInsets.all(AppFontSize.spacing_standard_new),
              decoration: boxDecoration(showShadow: true,bgColor: Color(0xfff1f4fb)),
              child: Column(
                children: <Widget>[
                  Container(
                        decoration: boxDecoration(showShadow: true,bgColor: Color(0xfff1f4fb),radius: AppFontSize.spacing_standard),
                    child:
                    (widget.address!=null&&widget.address!=" "?
                     QrImage(
  data: "${widget.address}",
  version: QrVersions.auto,
  size: 200.0,
):Container(child:text("Sorry QR Code not available now",textColor: AppColors.shadowdarkblack2), )),
                  ),
                ],
              ).paddingAll(AppFontSize.spacing_standard_new),
            ),

GestureDetector(
     onTap: () {
       Share.share('${widget.address}');
                            },
                            child: Container(
                              // margin: EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text("Share", textColor: AppColors.realblack, isCentered: true),
                              decoration: boxDecoration(bgColor: Color(thecolors), radius: 8),
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
    _wallet.text=widget.address;
    super.initState();
  }

  @override
  void dispose() {
    _wallet.clear();
    super.dispose();
  }



}
