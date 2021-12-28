import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import "package:loadng/model/system/route_argument.dart";
import 'package:loadng/widgets/transactionhorizontal.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:loadng/locator.dart';


var functionfile = locator<CustomFunction>();


class TransactionDetails extends StatefulWidget {
  static String tag = '/transactiondetails';

 final RouteArgument routeArgument;
  String name;
  int id;
  dynamic ourrate;
  dynamic usdvalue;
  dynamic nairavalue;
  String orderid;
  dynamic statusnumber;
  String date;
  dynamic btcval;
  String payref;
  String paystatus;
  String statustext;
  String address;
  String hashlink;
  String hash;
  List<String> images;
  int thecolors;
  String image;


  TransactionDetails({Key key,@required this.routeArgument }) {
    name= this.routeArgument.argumentsList[0] as String;
    id=this.routeArgument.argumentsList[1];
    ourrate=this.routeArgument.argumentsList[2];
    usdvalue=this.routeArgument.argumentsList[3];
    nairavalue=this.routeArgument.argumentsList[4];
    orderid=this.routeArgument.argumentsList[5];
    statusnumber=this.routeArgument.argumentsList[6];
    date=this.routeArgument.argumentsList[7];
    btcval=this.routeArgument.argumentsList[8];
    payref=this.routeArgument.argumentsList[9];
    paystatus=this.routeArgument.argumentsList[10];
    statustext=this.routeArgument.argumentsList[11];
    address=this.routeArgument.argumentsList[12];
    hashlink=this.routeArgument.argumentsList[13];
    hash=this.routeArgument.argumentsList[14];
    images=this.routeArgument.argumentsList[15];
    thecolors=this.routeArgument.argumentsList[16];
    image=this.routeArgument.argumentsList[17];
  }

  @override
  TransactionDetailsState createState() => TransactionDetailsState();
}

class TransactionDetailsState extends State<TransactionDetails> {
  var wallet=" ";


@override
void initState() {  
  super.initState();
  
}

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var cardHight = (width - 32) * (9 / 16);
    return Scaffold(
      appBar: appBar(context, "Transaction details",),
      body: CustomScrollView(
                slivers: [
                      SliverToBoxAdapter(
                    child:                Container(
                          padding: EdgeInsets.only(top:5,left:5,right: 5),
    // margin: EdgeInsets.only(left: 16.0, right: 16, bottom: 16, top: 16),
        child:  Container(
                width: MediaQuery.of(context).size.width,
                height: cardHight,
                margin: EdgeInsets.only(bottom: AppFontSize.spacing_standard_new),
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient:LinearGradient(
                                        colors: AppColors.t12_gradient_colors[
                                            0 % AppColors.t12_gradient_colors.length],
                                        begin: Alignment.bottomRight,
                                        end:Alignment.topRight),
                          borderRadius: BorderRadius.all(
                              Radius.circular(AppFontSize.spacing_standard))),
                      width: double.infinity,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            text("${widget.name}",
                                textColor: Colors.white.withOpacity(0.7),
                                fontSize: AppFontSize.textSizeMedium),
                            Image.asset(
                              AppImage.appLogoWhite,
                              width: 100,
                              height: 40, 
                            )
                          ], 
                        ),
                        Expanded(
                            child:SizedBox(height: 10),
            //                  FittedBox(
            //   child: Text("${widget.address}",style: boldTextStyle(
            //         size: 20,
            //         color: Colors.white,
            //         letterSpacing: 3,
            //         wordSpacing: 2),
            //          textAlign: TextAlign.center,
            //   ),
            // ),
                        ),
              
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  text("\$${widget.usdvalue}",
                                      textColor: Colors.white.withOpacity(0.7),
                                      fontSize: AppFontSize.textSizeMedium),
                                      (widget.nairavalue!=" "&& widget.nairavalue!=0?
                                  text("₦${widget.nairavalue}",
                                      textColor: Colors.white,
                                      fontSize: AppFontSize.textSizeMedium,
                                      fontFamily: AppFontSize.fontMedium):Container()),
                                ],
                              ),
                            ),
                            (widget.btcval!=" "&&widget.btcval!=""?
                       Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  text("${widget.btcval}BTC",
                                      textColor: Colors.white.withOpacity(0.7),
                                      fontSize: AppFontSize.textSizeMedium),
                                ]
                            ):Container()),


                          ],
                        )
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new)
                  ],
                


      ),
    )),),


    // OrderID
     SliverToBoxAdapter(
                    child:   
 (widget.orderid!=" "&&widget.orderid.isNotEmpty?
    Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
text("OrderID(Tap To Copy)",textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeSMedium),
GestureDetector(
  onTap: () {
                              Clipboard.setData(
                                new ClipboardData(
                                    text: '${widget.orderid}'),
                              );
                              toast("${widget.orderid} hash Copied to Clipboard");
                            },
  child: Container(
    color: AppColors.t12_edittext_background,
  child: Text("${widget.orderid}",style:TextStyle(color: AppColors.shadowdarkblack2,fontSize: 15.0),maxLines: 3,softWrap: true,textAlign: TextAlign.center,).paddingAll(10))),

                              ]):Container())),

    
// hash
     SliverToBoxAdapter(
                    child:   
 (widget.hash!=" "&&widget.hash.isNotEmpty?
    Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
text("Transaction hash(Tap To Copy)",textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeSMedium),
GestureDetector(
  onTap: () {
                              Clipboard.setData(
                                new ClipboardData(
                                    text: '${widget.hash}'),
                              );
                              toast("${widget.hash} hash Copied to Clipboard");
                            },
  child: Container(
    color: AppColors.t12_edittext_background,
  child: Text("${widget.hash}",style:TextStyle(color: AppColors.shadowdarkblack2,fontSize: 15.0),maxLines: 3,softWrap: true,textAlign: TextAlign.center,).paddingAll(10))),
  GestureDetector(
  onTap: () {
     functionfile.launchURL("${widget.hashlink}");
  },
    child:Container(
                              // margin: EdgeInsets.only(right: 16),
                              alignment: Alignment.center,
                              height: width / 8,
                              child: text("Track Hash", textColor: AppColors.realblack, isCentered: true),
                              decoration: boxDecoration(bgColor: Color(widget.thecolors), radius: 8),
                            ))
                              ]):Container())),
                                  // details
     SliverToBoxAdapter(
                    child:   
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
                  (widget.ourrate!="0" && widget.ourrate!=0?
                  toolBarTitle("Rate: ${widget.ourrate}").paddingTop(AppFontSize.spacing_standard_new):Container())
                  ,

                text("Status: ${widget.statustext}",fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeSMedium).paddingTop(AppFontSize.spacing_standard),
                  text("${widget.date}",fontFamily: AppFontSize.spinnaker,fontSize: AppFontSize.textSizeSMedium).paddingTop(AppFontSize.spacing_standard),

                ],
              ).paddingAll(AppFontSize.spacing_standard_new),
            )),


    
// qr
     SliverToBoxAdapter(
                    child:   
 (widget.address!=" " && widget.address.isNotEmpty?
    Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                   text("Address (Tap To Copy)",textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeSMedium,isCentered: true),
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
                     QrImage(
  data: "${widget.address}",
  version: QrVersions.auto,
  size: 200.0,
)),
                ],
              ).paddingAll(AppFontSize.spacing_standard_new),
            ),
            // address
 
                              ]):Container())),

// payment data
     SliverToBoxAdapter(
                    child:  
                    ((widget.paystatus!=" "&&widget.paystatus.isNotEmpty)|| (widget.payref.isNotEmpty&&widget.payref!=" ")?
            Container(
                    margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                    decoration: boxDecoration(radius: 10, showShadow: true),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          
                          SizedBox(height: 8),
                          rowHeading("Payment"),
                            SizedBox(height: 16),
                                 Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child:sidetext("${widget.statustext}",fontFamily: AppFontSize.fontRegular),),
                           SizedBox(height: 8),
                        
                          (widget.payref!=" "?
Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                              Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ), 
                          SizedBox(height: 8),
                         text("Payment Ref (Tap To Copy)",textColor: AppColors.shadowdarkblack2,fontSize: AppFontSize.textSizeSMedium,isCentered: true),
GestureDetector(
  onTap: () {
                              Clipboard.setData(
                                new ClipboardData(
                                    text: '${widget.payref}'),
                              );
                              toast("${widget.payref} Reference Copied to Clipboard");
                            },
  child: Container(
    color: AppColors.t12_edittext_background,
  child: Text("${widget.payref}",style:TextStyle(color: AppColors.shadowdarkblack2,fontSize: 15.0),maxLines: 3,softWrap: true,textAlign: TextAlign.center,).paddingAll(10))),
                        ]):Container()),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ):Container())),


    
     SliverToBoxAdapter(
                    child:   
(widget.images!=[]&&widget.images.isNotEmpty?
   Container(
                                        height: 245,
                                        child: ListView.builder(
                                          shrinkWrap: true,
                                          physics: ClampingScrollPhysics(),
                                          itemCount: widget.images.length,
                                          itemBuilder: (context, index) {
                                            double _marginLeft = 0;
                                            (index == 0)
                                                ? _marginLeft = 10
                                                : _marginLeft = 0;
                                            var sodaqahtitle = widget.name;
                                            var sodaqahimg = widget.images[index];


                                            return GestureDetector(
                                                onTap: () {
 showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return  Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Container( 
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    height: 450,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage(sodaqahimg), fit: BoxFit.cover),
                      // borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                            color: Theme.of(context).hintColor.withOpacity(0.2), offset: Offset(0, 4), blurRadius: 9)
                      ], 
                    ),
                  )
                
          ),
    );
                        });
                                                },
                                                child: ViewHorizontalWidget(
                                                  marginLeft: _marginLeft,
                                                  index: index,
                                                  name: sodaqahtitle,
                                                  dataimage: sodaqahimg,
                                                ));
                                          },
                                          scrollDirection: Axis.horizontal,
                                        )):Container())




      )]));
  }



}
