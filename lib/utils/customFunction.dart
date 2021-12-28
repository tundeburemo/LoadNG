
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:loadng/styles/AppTextStyle.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'dart:async';
import 'dart:io';
import 'package:loadng/styles/AppColors.dart';


//******** FOR DEVELOPER LOGICAL FUNCTION CREATED HIMSELF, */
class CustomFunction{

  saveStaticInfo({userid, mail}) async {
    final prefs = await StreamingSharedPreferences.instance;
    prefs.setInt('userid', userid);
    prefs.setString('email', mail);
  }

int hexToInt(String hex)
{
  int val = 0;
  int len = hex.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = hex.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw new FormatException("Invalid hexadecimal value");
    }
  }
  return val;
}
  //Clear DATA
  clearData()async{
     SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.clear();
  }

  storeDetails({
    String uname,
    int id,
    String email,
    String phoneno,
    int mainbal,
    String billbal,
    String refillbal,
    String coins,
    String referby,
    String usertype,
    String userlevel,
    int providusaccno,
    String mainaccno,
    String mainaccname,
    String mainbnkname,
    int activatepin,
    String datejoined,
    String fullnname,
    int starcount,
    int canlogin

  }) async {
    final prefs = await StreamingSharedPreferences.instance;
    prefs.setInt('userid', id);
    prefs.setString('email', email);
    prefs.setInt('mainbal', mainbal);
    prefs.setString('refillbal', refillbal);
    prefs.setString('billbal', billbal);
    prefs.setString('usernname', uname);
    prefs.setString('usercoins',coins);
    prefs.setString('userphoneno',phoneno);
    prefs.setString('referby',referby);
    prefs.setInt('providusaccno',providusaccno);
    prefs.setString('userlevel',userlevel);
    prefs.setString('usertype',usertype);
    prefs.setString('mainaccno',mainaccno);
    prefs.setString('mainaccname',mainaccname);
    prefs.setString('mainbnkname',mainbnkname);
    prefs.setInt('activatepin',activatepin);
    prefs.setString('datejoined',datejoined);
    prefs.setString('fullnname',fullnname);
    prefs.setInt('starcount',starcount);
    prefs.setInt('canlogin',canlogin);


}



onHorizontalLoading1(context) {
      showDialog(
      barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(onWillPop: ()=>Future.value(false),
            child:AlertDialog(
            backgroundColor: AppColors.appWhite,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
            contentPadding: EdgeInsets.all(0.0),
            content: Padding(
              padding: EdgeInsets.only(top: 20, bottom: 20),
              child: Row(
                children: [
                  16.width,
                  CircularProgressIndicator(
                    backgroundColor: Color(0xffD6D6D6),
                    strokeWidth: 4,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blueGrey),
                  ),
                  16.width,
                  Text(
                    "Please Wait...\nWaiting time depends on\n your internet connection",
                    style: primaryTextStyle(color: AppColors.appColorPrimary,size: 12),
                  ),
                ],
              ),
            ),
       ) );
        },
      );
    }

//EMAIL VALIDATOR
bool validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return false;
    else
      return true;
}

errorUimessage({String errorMessage, int type, BuildContext context}){
   return  (errorMessage == null ? SizedBox.shrink() : Center(
     child: Row(
       mainAxisAlignment: MainAxisAlignment.center,
       children: <Widget>[
         (type == 1 ? Icon(Icons.check_circle, color: Colors.green,): Icon(Icons.error, color: Colors.red,)),
         SizedBox(width: 10,),
         Expanded(child: Text(errorMessage,
        textAlign: TextAlign.justify,
     overflow: TextOverflow.ellipsis,
         maxLines: 5,
           style: AppTextStyle.sellheader(context, (type == 1 ? Colors.green : Colors.red),)
           ),)
         

       ],),
   ));
  }

 dialogLoder(BuildContext context){
   return  ProgressDialog(context,type: ProgressDialogType.Normal, isDismissible: false,);
 }

 launchURL(String link) async {
    if (await canLaunch(link)) {
      await launch(link);
    } else {
      throw 'Could not launch $link';
    }
  } 

        void showerror(context) {
  showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title:  Text('INTERNET ERROR?',
                style:  TextStyle(color: Colors.black, fontSize: 20.0)),
            content:  Text(
                'Kindly check your internet connectivity. Make sure your device is connected to the internet.'),
            actions: <Widget>[
             FlatButton(
                onPressed: () =>
                    Navigator.pop(context), // this line dismisses the dialog
                child: new Text('OK', style: TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        );
  }

          void specialshowerror(context,heading,msg) {
  showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title:  Text('$heading',
                style:  TextStyle(color: Colors.black, fontSize: 20.0)),
            content:  Text(
                '$msg'),
            actions: <Widget>[
             FlatButton(
                onPressed: () =>
                    Navigator.pop(context), // this line dismisses the dialog
                child: new Text('OK', style: TextStyle(fontSize: 18.0)),
              )
            ],
          ),
        );
  }

// onbaord functions
changeStatusColor(Color color) async {
  try {
    await FlutterStatusbarcolor.setStatusBarColor(color, animate: true);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(
        useWhiteForeground(color));
  } on Exception catch (e) {
    print(e);
  }
}




// onbaord functions


// internet checker function
/// If any of the pings returns true then you have internet (for sure). If none do, you probably don't.
  Future<bool> checkInternetAccess() {
    /// We use a mix of IPV4 and IPV6 here in case some networks only accept one of the types.
    /// Only tested with an IPV4 only network so far (I don't have access to an IPV6 network).
    final List<InternetAddress> dnss = [
      InternetAddress('8.8.8.8', type: InternetAddressType.IPv4), // Google
      InternetAddress('8.8.4.4', type: InternetAddressType.IPv4), // Google
      InternetAddress('2001:4860:4860::8888', type: InternetAddressType.IPv6), // Google
      InternetAddress('1.1.1.1', type: InternetAddressType.IPv4), // CloudFlare
      InternetAddress('1.0.0.1', type: InternetAddressType.IPv4), // CloudFlare
      InternetAddress('2606:4700:4700::1111', type: InternetAddressType.IPv6), // CloudFlare
      InternetAddress('208.67.222.222', type: InternetAddressType.IPv4), // OpenDNS
      InternetAddress('208.67.220.220', type: InternetAddressType.IPv4), // OpenDNS
      InternetAddress('2620:0:ccc::2', type: InternetAddressType.IPv6), // OpenDNS
      InternetAddress('180.76.76.76', type: InternetAddressType.IPv4), // Baidu
      InternetAddress('2400:da00::6666', type: InternetAddressType.IPv6), // Baidu
    ];

    final Completer<bool> completer = Completer<bool>();

    int callsReturned = 0;
    void onCallReturned(bool isAlive) {
      if (completer.isCompleted) return;

      if (isAlive) {
        completer.complete(true);
      } else {
        callsReturned++;
        if (callsReturned >= dnss.length) {
          completer.complete(false);
        }
      }
    }

    dnss.forEach((dns) => _pingDns(dns).then(onCallReturned));

    return completer.future;
  }

  Future<bool> _pingDns(InternetAddress dnsAddress) async {
    const int dnsPort = 53; //A DNS server listens for requests on port 53 (both UDP and TCP). So all DNS requests are sent to port 53
    const Duration timeout = Duration(seconds: 2);

    Socket socket;
    try {
      socket = await Socket.connect(dnsAddress, dnsPort, timeout: timeout);
      socket?.destroy();
      return true;
    } on SocketException {
      socket?.destroy();
    }
    return false;
  }

  // internet chcker 1 ends

  // internet checker 2
     Future<bool> isInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Mobile data detected & internet connection confirmed.
        return true;
      } else {
        // Mobile data detected but no internet connection found.
        return false;
      }
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a WIFI network, make sure there is actually a net connection.
      if (await DataConnectionChecker().hasConnection) {
        // Wifi detected & internet connection confirmed.
        return true;
      } else {
        // Wifi detected but no internet connection found.
        return false;
      }
    } else {
      // Neither mobile data or WIFI detected, not internet connection found.
      return false;
    }
  }
  // internet checker 2 ends
}

