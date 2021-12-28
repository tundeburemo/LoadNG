import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/widgets/loginScreen.dart';
import 'package:loadng/locator.dart';
import "package:loadng/model/system/route_argument.dart";


var functionfile = locator<CustomFunction>();
// ignore: must_be_immutable
class PmWebviewinapp extends StatefulWidget {
  Uri url;
  String title;
  String navlink;
  final RouteArgument routeArgument;
  static String tag = '/inappwebviewpm'; 

 PmWebviewinapp({Key key,@required this.routeArgument }) {
    title= this.routeArgument.argumentsList[0] as String;
    url=this.routeArgument.argumentsList[1] as Uri;
    navlink=this.routeArgument.argumentsList[2] as String;
  }

  @override
  _PmWebviewinappState createState() => new _PmWebviewinappState();
}

class _PmWebviewinappState extends State<PmWebviewinapp> {

  InAppWebViewController webView;
  Uri url;
  double progress = 0;

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
    functionfile.changeStatusColor(AppColors.appWhite);
    return Scaffold( 
             appBar: appBarwithlink(context, "${widget.title}","${widget.navlink}"),
        body: Container(
          child: Column(children: <Widget>[ 
            Container(
                padding: EdgeInsets.all(10.0),
                child: progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container()),
            Expanded(
              child: Container(
                child: InAppWebView(
                  initialUrlRequest:URLRequest(
    url: Uri.parse("${widget.url}"),
    // method: 'POST',
    // body: Uint8List.fromList(utf8.encode("firstname=Foo&lastname=Bar")),
    // headers: {
    //   'Content-Type': 'application/x-www-form-urlencoded'
    // }
  ),
                  initialOptions: InAppWebViewGroupOptions(
                    crossPlatform: InAppWebViewOptions(
                      javaScriptCanOpenWindowsAutomatically: true,
                        // debuggingEnabled: true,

                    )
                  ),
                  onWebViewCreated: (InAppWebViewController controller) {
                    webView = controller;
                  },
                  onLoadStart: (InAppWebViewController controller, Uri url) {
                    setState(() {
                      this.url = url;
                    });

                    if(this.url.path=="beta/login"||this.url.path=="beta/index"||this.url.path=="beta/dashboard/wallet"||this.url.path.contains(new RegExp(r'wallet', caseSensitive: false))||this.url.path.contains(new RegExp(r'beta/login', caseSensitive: false))){
                      //  Navigator.of(context).pushNamed('/userdashboard');
                       Navigator.of(context).pushNamed('/pmhistory');
                      
                    }
                  },
                  onLoadStop: (InAppWebViewController controller, Uri url) async {
                    setState(() {
                      this.url = url;
                    });
                    
               if(this.url.path=="beta/login"||this.url.path=="beta/index"||this.url.path=="beta/dashboard/wallet"||this.url.path.contains(new RegExp(r'wallet', caseSensitive: false))||this.url.path.contains(new RegExp(r'beta/login', caseSensitive: false))){
                      //  Navigator.of(context).pushNamed('/userdashboard');
                       Navigator.of(context).pushNamed('/pmhistory');
                    }
                  },
                  onProgressChanged: (InAppWebViewController controller, int progress) {
                    setState(() {
                      this.progress = progress / 100;
                    });
                  },
                ),
              ),
            ),
        ])),
      );
  }
}