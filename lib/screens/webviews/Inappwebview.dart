// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import "package:loadng/model/system/route_argument.dart";


// // ignore: must_be_immutable
// class Webviewinapp extends StatefulWidget {
// String title;
// String selectedUrl;
//  final RouteArgument routeArgument;
//   static String tag = '/inappwebview'; 

//   Webviewinapp({Key key,@required this.routeArgument }) {
//     title= this.routeArgument.argumentsList[0] as String;
//     selectedUrl=this.routeArgument.argumentsList[1] as String;
//   }

//   @override
//   _WebViewState createState() => _WebViewState(
//       title: title, selectedUrl: selectedUrl);
// }

// class _WebViewState extends State<Webviewinapp> {
//   final flutterWebviewPlugin = new FlutterWebviewPlugin();
//   StreamSubscription _onDestroy;
//   StreamSubscription<String> _onUrlChanged;
//   StreamSubscription<WebViewStateChanged> _onStateChanged;
//   final String title;
//   final String selectedUrl;
//   _WebViewState({
//     @required this.title,
//     @required this.selectedUrl,
//   });

//   bool internet = true;
//   String token;
//   @override
//   void dispose() {
//     // Every listener should be canceled, the same should be done with this stream.
//     _onDestroy.cancel();
//     _onUrlChanged.cancel();
//     _onStateChanged.cancel();
//     flutterWebviewPlugin.dispose();
//     super.dispose();
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Future<int> a = CustomFunction().checkInternetConnection();
//     // a.then((value) {
//     //   if (value == 0) {
//     //     setState(() {
//     //       internet = false;
//     //     });
//     //   } else {
//     //     setState(() {
//     //       internet = true;
//     //     });
//     //   }
//     // });

//     flutterWebviewPlugin.close();

//     // Add a listener to on destroy WebView, so you can make came actions.
//     _onDestroy = flutterWebviewPlugin.onDestroy.listen((_) {});

//     _onStateChanged = flutterWebviewPlugin.onStateChanged
//         .listen((WebViewStateChanged state) {});

//     // Add a listener to on url changed
//     _onUrlChanged = flutterWebviewPlugin.onUrlChanged.listen((String url) {
//       if (mounted) { 
//         setState(() {
//           if (url.startsWith("https://app.load.ng/beta/dashboard/wallet.php")) {
//             Navigator.of(context).pushNamed('/userdashboard');
//             flutterWebviewPlugin.close();
//             // RegExp regExp = new RegExp("status=(.*)");
//             // token = regExp.firstMatch(url)?.group(1);
//             // if (token[0] == "t") {
//             //   Navigator.pop(context, '1');
//             //   flutterWebviewPlugin.close();
//             // } else {
//             //   Navigator.pop(context, '0');
//             //   flutterWebviewPlugin.close();
//             // }
//           }


//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop: () async => true,
//         child: (!internet
//             ? Scaffold(
//                 body: Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     Text(
//                       'No Internet Connection, Please retry.',
//                       style: TextStyle(
//                           fontStyle: FontStyle.italic,
//                           color: Colors.red,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     //Image.asset('assets/lite.png', fit: BoxFit.cover,),
//                     Padding(
//                       padding: const EdgeInsets.all(50.0),
//                       child: MaterialButton(
//                         elevation: 6.0,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(55.0)),
//                         ),
//                         onPressed: () {
//                           retry();
//                         },
//                         minWidth: double.infinity,
//                         height: 50,
//                         child: Text(
//                           'Retry'.toUpperCase(),
//                         ),
//                         color: Colors.redAccent,
//                         textColor: Colors.white,
//                       ),
//                     ),
//                   ],
//                 ),
//               ))
//             : SafeArea(
//                 child: WebviewScaffold(
//                   supportMultipleWindows: true,
//                   withJavascript: true,
//                   url: selectedUrl,
//                   appBar: AppBar(
//                     title: Text(
//                       title,
//                       style: TextStyle(color: Colors.white),
//                     ),
//                     elevation: 0,
//                     centerTitle: true,
//                   ),
//                   // withZoom: false,
//                   // withLocalStorage: true,
//                   // hidden: true,
//                   initialChild: Container(
//                     child: Center(
//                       child: SpinKitDoubleBounce(color: Colors.cyan[900]),
//                     ),
//                   ),
//                 ),
//               )));
//   }

//   retry() async { 
//              Navigator.of(context).pushNamed('/inappwebview',arguments: new RouteArgument(argumentsList: ["LoadNG Support", "https://tawk.to/chat/5d49d339e5ae967ef80ec6b5/default"]));  
//   }
// }
