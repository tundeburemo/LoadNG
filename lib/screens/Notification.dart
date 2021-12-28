import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loadng/styles/AppFontSizes.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loadng/model/account/UserNotifications.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/locator.dart';
import 'package:loadng/styles/AppText.dart';


var functionfile = locator<CustomFunction>();
var accountapi = locator<AccountApi>();

class UserNotification extends StatefulWidget {
  static String tag = '/usernotification';

  @override
  UserNotificationState createState() => UserNotificationState();
}

class UserNotificationState extends State<UserNotification> { 
Future allnotifications;
  @override
  void initState() {
    internetcheck();
    // allnotifications
    super.initState();
  }

internetcheck() async{
      var theinternet = await functionfile.isInternet();
    var theinternet2 = await functionfile.checkInternetAccess();

      if (theinternet && theinternet2) {
        setState(() {
    allnotifications=accountapi.usernotification();
        });
      }else{
      functionfile.showerror(context);
      }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.appWhite,
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, width * 0.25),
        child: TopBar(titleName:"Notifications"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column( 
            children: <Widget>[
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: <Widget>[
              //     text("Today", fontFamily: AppFontSize.fontMedium, textColor: AppColors.appTextColorSecondary),
              //     text(
              //       "grocery_lbl_clear_all",
              //       textColor: AppColors.appTextColorSecondary,
              //     ),
              //   ],
              // ).paddingAll(AppFontSize.spacing_standard_new),
              FutureBuilder<UserNotifications>(
                    future: allnotifications,
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
                              'Notifications not found, try again!',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold),
                            ));
                          } else if (gtserv.hasData) {
                            if (gtserv.data.notifications==null || gtserv.data.notifications.isEmpty) {
                              return Center(
                                  child: Text('No Notification Available',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.w800,
                                      )));
                            } else {
                              return  ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: gtserv.data.notifications.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Notification(data:gtserv.data.notifications[index]);
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
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class Notification extends StatelessWidget {
 var data;

  // Notification(NotificationModel model, int pos) {
  //   this.model = model;
  // }

  
  Notification({this.data});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(AppFontSize.spacing_standard),
      margin: EdgeInsets.only(left: AppFontSize.spacing_standard_new, right: AppFontSize.spacing_standard_new, bottom: AppFontSize.spacing_standard_new),
      decoration: boxDecoration(showShadow: true),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(shape: BoxShape.circle, color:AppColors.appTextColorSecondary),
            width: width * 0.12,
            height: width * 0.12,
            padding: EdgeInsets.all(width * 0.02),
            child: Icon(
              Icons.notifications_none,
              color: AppColors.appWhite,
            ),
          ),
          SizedBox(
            width: AppFontSize.spacing_standard,
          ),
          Expanded(
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    text("${data.time}", textColor: AppColors.realblack,fontFamily: AppFontSize.cooperaterunded),
                  ],
                ),
                text("${data.message}",maxLine: 100, textColor:AppColors.appTextColorSecondary,fontFamily: AppFontSize.cooperaterunded,fontSize: AppFontSize.textSizeSMedium)
              ],
            ),
          )
        ],
      ),
    );
  }
}
