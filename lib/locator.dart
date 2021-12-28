import 'package:get_it/get_it.dart';
import 'package:loadng/services/apis/bizsuitapi.dart';
import 'package:loadng/utils/customFunction.dart';
import 'package:loadng/services/apis/account.dart';
import 'package:loadng/services/apis/bank.dart';
import 'package:loadng/services/apis/history.dart';
import 'package:loadng/services/apis/sell.dart';
import 'package:loadng/services/apis/system.dart';
import 'package:loadng/services/baseurl.dart';
import 'package:loadng/services/apis/spendreceive.dart';
import 'package:loadng/services/apis/buycoin.dart';




//Instead of creating instance of an Object, Multiple times
//Dependency inject solvpe it by creating this code.

GetIt locator = GetIt.instance;

//Register class for Dep. Injection.
void setupLocator() {
locator.registerLazySingleton(() => CustomFunction());
locator.registerLazySingleton(() => BaseUrl());
locator.registerLazySingleton(() => AccountApi());
locator.registerLazySingleton(() => BankApi());
locator.registerLazySingleton(() => HistoryApi());
locator.registerLazySingleton(() => SellApi());
locator.registerLazySingleton(() => SystemApi());
locator.registerLazySingleton(() => SpendReceiveApi());
locator.registerLazySingleton(() => BuyCoins());
locator.registerLazySingleton(() => BizSuitApi());





}
