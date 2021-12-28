import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/styles/AppImage.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/services/apis/account.dart';


var accountapi = locator<AccountApi>();


var functionfile = locator<CustomFunction>();
class KYCdetails extends StatefulWidget {
    static var tag = "/kycdetails";
  KYCdetails({Key key}) : super(key: key);

  @override
  _KYCdetailsState createState() => _KYCdetailsState();
}

class _KYCdetailsState extends State<KYCdetails> {
var bvn=" ";
var facebooklink=" ";
var twitterlink=" ";
var telegramlink=" ";
var instagramlink=" ";
var biztype=" ";
var regtype=" ";
var firstname=" ";
var lastname=" ";
var email=" "; 
var phoneno=" ";
var dob=" ";
var fulladdress=" ";
var state=" ";
var country=" ";
var submittedtime=" ";
var passport=" ";
var regulationimg=" ";
var holdregulationimg=" ";
var businesscc=" ";
var kycstatus=" ";

  Widget counter(String counter, String counterName) {
    return Column(
      children: <Widget>[
        profile(counter),
        text(counterName,
            textColor: t1TextColorPrimary,
            fontSize: AppFontSize.textSizeMedium,
            fontFamily: AppFontSize.fontMedium)
      ],
    );
  }
  @override
  void initState() { 
    userInfo();
    super.initState();
    
  }
  @override
  Widget build(BuildContext context) {
    functionfile.changeStatusColor(Colors.transparent);
    final profileImg = new Container(
      margin: new EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child:
      (passport!=" "&&passport!=null? 
      Image.network(passport,width: 200,height: 120,):Container()),//CahedNetworkImageProvider("https"),
        // backgroundImage: CachedNetworkImageProvider(t1_ic_user1),
    
    );

    return Scaffold(
      backgroundColor: AppColors.t1_app_background,
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 90, left: 2, right: 2),
            physics: ScrollPhysics(),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  (kycstatus!=" "?
                  Text("KYC status: $kycstatus"):Container()),
                     Container(
              width: double.infinity,
              decoration:
                  boxDecoration(showShadow: true, radius: AppFontSize.spacing_standard),
              child: Stack(
                alignment: Alignment.topRight,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Container(
                            child: profileImg
                                .paddingAll(3)),
                        text("$firstname",
                                textColor: AppColors.t12_text_color_primary,
                                fontFamily: AppFontSize.montbold,
                                fontSize: AppFontSize.textSizeNormal)
                            .paddingTop(AppFontSize.spacing_control),
                        text("$lastname", fontSize: AppFontSize.textSizeMedium)
                            .paddingTop(AppFontSize.spacing_control_half),
                                text("$state, $country", fontSize: AppFontSize.textSizeMedium)
                            .paddingTop(AppFontSize.spacing_control_half),
                             
                      ],
                    ).paddingAll(AppFontSize.spacing_standard_new),
                    width: double.infinity,
                  ),
            
                ],
              ),
            ).paddingAll(AppFontSize.spacing_standard_new),
                                  SizedBox(height: 8),
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
                          rowHeading("Personal Details"),
                                SizedBox(height: 16),
                                 Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child:sidetext("$bvn"),),
                           SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ), 
                            SizedBox(height: 16),
                                 Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child:sidetext("$email"),),
                           SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ), 
                          SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$phoneno")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 8),
                             Padding(
                            padding: const EdgeInsets.fromLTRB(16,  0, 0, 0),child:sidetext("$dob")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
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
                          rowHeading("Regulatory"),
                          SizedBox(height: 16),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$biztype")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$regtype")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 16), 
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
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



                          rowHeading("Contact Details"),
                          SizedBox(height: 16),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$facebooklink")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                              SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$instagramlink")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                                     SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$telegramlink")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          
                         SizedBox(height: 8),
                            Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),child: sidetext("$twitterlink")),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
                            child: view(),
                          ),
                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
// var fulladdress=" ";
// var submittedtime=" ";

 (holdregulationimg!=" "&&holdregulationimg!=null?Container(
      margin: new EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child:Image.network(holdregulationimg),//CahedNetworkImageProvider("https"),
      ):Container()),

      (regulationimg!=" "&&regulationimg!=null? Container(
      margin: new EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child:Image.network(regulationimg),//CahedNetworkImageProvider("https"),
      ):Container()),
    (businesscc!="https://app.load.ng/beta//images/userbusinesscards/null"&&businesscc!=null&&businesscc!=" "?
           Container(
      margin: new EdgeInsets.symmetric(horizontal: 16.0),
      alignment: FractionalOffset.center,
      child:Image.network(businesscc),//CahedNetworkImageProvider("https"),
      ):Container()),

                ],
              ),
            ),
          ),
          TopBar(titleName: "My KYC"),
        ],
      ),
    );
  }


        Future<void> userInfo() async {
                 var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

      if (theinternet && theinternet2) {
         var kycdata = await accountapi.userkycdetails();
              if(kycdata!=null){
                    if(mounted){
    setState(() {
bvn =kycdata.bvn;
facebooklink =kycdata.facebooklink;
twitterlink =kycdata.twitterlink;
telegramlink =kycdata.telegramlink;
instagramlink =kycdata.instagramlink;
biztype =kycdata.biztype;
regtype =kycdata.regtype;
firstname =kycdata.firstname;
lastname =kycdata.lastname;
email=kycdata.email; 
phoneno =kycdata.phoneno;
dob=kycdata.dob;
fulladdress =kycdata.fulladdress;
state =kycdata.state;
country =kycdata.country;
submittedtime =kycdata.submittedtime;
passport=kycdata.passport;
regulationimg =kycdata.regulationimg;
holdregulationimg =kycdata.holdregulationimg;
businesscc =kycdata.businesscc;
kycstatus= kycdata.msg;

    });    
      }
      }else{
              functionfile.showerror(context);
      }
   
  }
}
}