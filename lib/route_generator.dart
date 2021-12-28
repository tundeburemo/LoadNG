import "package:loadng/model/system/route_argument.dart";
import "package:loadng/screens/OnboardScreen.dart";
import "package:loadng/screens/Dashboard.dart";
import 'package:loadng/screens/bizsuit/addwalllet.dart';
import 'package:loadng/screens/bizsuit/sellbizsuit.dart';
import 'package:loadng/screens/bizsuit/updatewallet.dart';
import 'package:loadng/screens/maintanance.dart';
import "package:loadng/screens/singletransactionpage.dart";
import "package:loadng/screens/sell/CoinList.dart";
import "package:loadng/screens/sell/sellpm.dart";
import "package:loadng/screens/Notification.dart";
import "package:loadng/screens/webviews/Inappwebview2.dart";
import "package:loadng/screens/webviews/Inappwebviewpm.dart";
import "package:loadng/screens/history/Userhistory.dart";
import "package:loadng/screens/history/Userbchistory.dart";
import "package:loadng/screens/history/Userotherhiistory.dart";
import "package:loadng/screens/history/Userpaxfulhistory.dart";
import "package:loadng/screens/history/Userunihistory.dart";
import "package:loadng/screens/history/Userbizhistory.dart";
import "package:loadng/screens/history/Userbuycoinhistory.dart";
import "package:loadng/screens/history/Userpmhistory.dart";
import "package:loadng/screens/auth/LoginScreen.dart";
import "package:loadng/screens/sell/sellpaxful.dart";
import "package:loadng/screens/sell/selluniversal.dart";
import "package:loadng/screens/sell/sellpaxfulnew.dart";
import "package:loadng/screens/sell/sellbiz.dart";
import "package:loadng/screens/sell/sellbiz2.dart";
import "package:loadng/screens/sell/bizCoinList.dart";
import "package:loadng/screens/sell/sellnewcoins.dart";
import "package:loadng/screens/password/ForgotPassword.dart";
import "package:loadng/screens/account/ChangePassword.dart";
import "package:loadng/screens/auth/VerifyPin.dart";
import "package:loadng/screens/account/ChangePin.dart";
import "package:loadng/screens/account/MyBanks.dart";
import "package:loadng/screens/account/MyBankTransList.dart";
import "package:loadng/screens/password/ResetPassword.dart";
import "package:loadng/screens/account/UserAccount.dart";
import "package:loadng/screens/account/kyc.dart";
import "package:loadng/screens/account/kycdetails.dart";
import "package:loadng/screens/account/UserStatistic.dart";
import "package:loadng/screens/account/UserProfile.dart";
import "package:loadng/screens/account/UserReferalList.dart";
import "package:loadng/screens/account/EditProfile.dart";
import "package:loadng/screens/register/RegisterPhoneNo.dart";
import "package:loadng/screens/register/RegisterEmail.dart";
import "package:loadng/screens/register/RegisterUsername.dart";
import "package:loadng/screens/register/Registerbank.dart";

import "package:loadng/screens/register/RegisterPassword.dart";
import "package:loadng/screens/spendreceive/MyWalletList.dart";
import "package:loadng/screens/spendreceive/Receivecoin.dart";
import "package:loadng/screens/spendreceive/SendCoin.dart";
import "package:loadng/screens/buycoin/buycoinlist.dart";
import "package:loadng/screens/buycoin/buycoins.dart";
import 'package:flutter/material.dart';

import 'screens/bizsuit/updatemainwallet.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
// Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => AppOnBoardScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => LogMeIn());
      case '/maintanance':
        return MaterialPageRoute(builder: (_) => MainTananceScreen());
      case '/forgot':
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case '/register':
        return MaterialPageRoute(builder: (_) => RegisterMe());
      case '/registeremail':
        return MaterialPageRoute(
            builder: (_) => RegisterEmail(sentphone: args));
      case '/registerusername':
        return MaterialPageRoute(
            builder: (_) =>
                RegisterUsername(routeArgument: args as RouteArgument));
                      case '/RegisterBank':
        return MaterialPageRoute(
            builder: (_) =>
                RegisterBank(routeArgument: args as RouteArgument));
      case '/registerpassword':
        return MaterialPageRoute(
            builder: (_) =>
                RegisterPassword(routeArgument: args as RouteArgument));
      case '/resetpass':
        return MaterialPageRoute(builder: (_) => ResetPassword());
      case '/changepass':
        return MaterialPageRoute(builder: (_) => ChangePassword());
      case '/changepin':
        return MaterialPageRoute(builder: (_) => ChangePin());
      case '/verifypin':
        return MaterialPageRoute(builder: (_) => VerifyPin());
      case '/userreferals':
        return MaterialPageRoute(builder: (_) => UserReferalList(routeArgument: args as RouteArgument));
      case '/mybanks':
        return MaterialPageRoute(builder: (_) => MyBanks());
      case '/useraccount':
        return MaterialPageRoute(builder: (_) => UserAccount());
      case '/userprofile':
        return MaterialPageRoute(builder: (_) => UserProfile());
      case '/usereditprofile':
        return MaterialPageRoute(builder: (_) => UserEditProfile());
      case '/userstatistics':
        return MaterialPageRoute(builder: (_) => UserStatistics());
      case '/userdashboard':
        return MaterialPageRoute(builder: (_) => UserDashboard());
      case '/userhistory':
        return MaterialPageRoute(builder: (_) => UserHistory());
      case '/usernotification':
        return MaterialPageRoute(builder: (_) => UserNotification());
      case '/coinslist':
        return MaterialPageRoute(builder: (_) => CoinsList());
      case '/bizcoinslist':
        return MaterialPageRoute(builder: (_) => BizCoinList());
            case '/inappwebview2':
        return MaterialPageRoute(
            builder: (_) => Webviewinapp2(routeArgument: args as RouteArgument));
      case '/inappwebviewpm':
        return MaterialPageRoute(
            builder: (_) =>
                PmWebviewinapp(routeArgument: args as RouteArgument));
      case '/sellpaxful':
        return MaterialPageRoute(
            builder: (_) => SellPaxful(routeArgument: args as RouteArgument));
      case '/sellbiz':
        return MaterialPageRoute(
            builder: (_) => SellBiz(routeArgument: args as RouteArgument));
      case '/sellbiz2':
        return MaterialPageRoute(
            builder: (_) => SellBiz2(routeArgument: args as RouteArgument));
      case '/SellBizSuit':
        return MaterialPageRoute(
            builder: (_) => SellBizSuit(routeArgument: args as RouteArgument));
      case '/UpdateBizSuit':
        return MaterialPageRoute(
            builder: (_) => UpdateWalletBizSuit(routeArgument: args as RouteArgument));
      case '/UpdateMainWalletBank':
        return MaterialPageRoute(
            builder: (_) => UpdateMainWalletBank());


  
      case '/AddBizSuitWallet':
        return MaterialPageRoute(
            builder: (_) => AddBizSuitWallet());
      case '/mysrwallets':
        return MaterialPageRoute(builder: (_) => MyWalletLists());
      case '/receivecoin':
        return MaterialPageRoute(
            builder: (_) =>
                ReceiveCoinPage(routeArgument: args as RouteArgument));
      case '/sendcoin':
        return MaterialPageRoute(
            builder: (_) => SendCoinPage(routeArgument: args as RouteArgument));
      case '/sellpaxful2':
        return MaterialPageRoute(
            builder: (_) =>
                SellPaxfulNew(routeArgument: args as RouteArgument));
      case '/SellNewCoins':
        return MaterialPageRoute(
            builder: (_) => SellNewCoins(routeArgument: args as RouteArgument));
      case '/sellpm':
        return MaterialPageRoute(
            builder: (_) => SellPm(routeArgument: args as RouteArgument));
      case '/selluniversal':
        return MaterialPageRoute(
            builder: (_) =>
                SellUniversal(routeArgument: args as RouteArgument));
      case '/paxhistory':
        return MaterialPageRoute(builder: (_) => UserPaxHistory());
      case '/unihistory':
        return MaterialPageRoute(builder: (_) => UserUniHistory());
      case '/bchistory':
        return MaterialPageRoute(builder: (_) => UserBcHistory());
      case '/otherhistory':
        return MaterialPageRoute(builder: (_) => UserOtherHistory());
      case '/pmhistory':
        return MaterialPageRoute(builder: (_) => UserPmHistory());
      case '/buycoinslist':
        return MaterialPageRoute(builder: (_) => BuyCoinList());
      case '/buycoinorder':
        return MaterialPageRoute(
            builder: (_) => BuyCoinsPage(routeArgument: args as RouteArgument));
      case '/transactiondetails':
        return MaterialPageRoute(
            builder: (_) =>
                TransactionDetails(routeArgument: args as RouteArgument));
      case '/bizhistory':
        return MaterialPageRoute(builder: (_) => UserBizHistory());
      case '/buycoinhistory':
        return MaterialPageRoute(builder: (_) => UserBuyCoinHistory());
              case '/kycform':
        return MaterialPageRoute(builder: (_) => KycForm());
                      case '/kycdetails':
        return MaterialPageRoute(builder: (_) => KYCdetails());
                              case '/mytransbanks':
        return MaterialPageRoute(builder: (_) => MyTransBankList());
//      case '/second':
//      // Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
//        // If args is not of the correct type, return an error page.
//        // You can also throw an exception while in development.
//        return _errorRoute();
//Onboard Screen Routing.
// case onboardRoute:
// return _getPageRoute(
//    routeName: settings.name,
//    viewToShow: OnboardScreen(),
//  );

      default:
// If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR, PAGE CURRENTLY NOT AVAILABLE'),
        ),
      );
    });
  }
}

//Page Route with Transition
// PageRoute _getPageRouteTransition({Widget viewToShow, PageTransitionType pageTransitionType}) {
//       return PageTransition(child: viewToShow, type: pageTransitionType, duration:  Duration(milliseconds: 100),
//       );
// }
