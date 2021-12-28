class BaseUrl {
  //live
  // static const basic = "http://10.0.2.2:8000/LoadNg/loadngusecureididffheIo/";
// test
  static const basic = "https://app.load.ng/beta/nEwloadngAppMandiefyuefyIOfyrdrseebno";

// ACCOUNT URLS 
final Uri login=Uri.parse("$basic/account/login.php");
final Uri register=Uri.parse("$basic/account/newregister.php");
final Uri registerchecker=Uri.parse("$basic/account/registerchecker.php");
final Uri getresettoken=Uri.parse("$basic/account/resetpasscode.php");
final Uri resetpassword=Uri.parse("$basic/account/resetpass.php");
final Uri userdetails=Uri.parse("$basic/account/userdetails.php");
final Uri userstatistic=Uri.parse("$basic/account/userstatisticnew.php"); 
final Uri userreferals=Uri.parse("$basic/account/userreferals.php");
final Uri useractivatedeactipin=Uri.parse("$basic/account/useractivatepin.php");
final Uri userupdateprofile=Uri.parse("$basic/account/userupdateaccount.php");
final Uri userchangepin=Uri.parse("$basic/account/userchangepin.php");
final Uri userchangepassword=Uri.parse("$basic/account/userchangepassword.php");
final Uri userpinverify=Uri.parse("$basic/account/userpinverify.php");
final Uri usernotifications=Uri.parse("$basic/account/usernotifications.php");
final Uri useraddkyc=Uri.parse("$basic/account/userkycform.php");
final Uri userkycdetails=Uri.parse("$basic/account/userkyc.php");
final Uri usersecdetails=Uri.parse("$basic/account/usersecdata.php");
final Uri userwithdrawcoin=Uri.parse("$basic/account/withdrawcoin.php");
final Uri maintanance=Uri.parse("$basic/maintanance.php");


// BANK API
final Uri addbank = Uri.parse("$basic/bank/addbanks.php");
final Uri banklist = Uri.parse("$basic/bank/userbanks.php");
final Uri banktranslist = Uri.parse("$basic/bank/usertransbanklist.php");
final Uri deletbank = Uri.parse("$basic/bank/userdeletebanks.php");
final Uri settrabsbank = Uri.parse("$basic/bank/usersettransbank.php");
final Uri psbanklist = Uri.parse("$basic/bank/psbanklist.php");
final Uri psaccname = Uri.parse("$basic/bank/psaccname.php");
 
// SELL HISTORY API
final Uri allsellhistory = Uri.parse("$basic/history/userallsellhistory.php");
final Uri allpaxfulsellhistory = Uri.parse("$basic/history/userpaxsellhistory.php");
final Uri allblockcsellhistory = Uri.parse("$basic/history/userbcsellhistory.php");
final Uri allpmsellhistory = Uri.parse("$basic/history/userpmsellhistory.php");
final Uri allnewcoinssellhistory = Uri.parse("$basic/history/usernewcoinsellhistory.php");
final Uri alluniversalsellhistory = Uri.parse("$basic/history/userunisellhistory.php");
final Uri allrecentsellhistory = Uri.parse("$basic/history/userrecenthistory.php");
final Uri allbizhistory = Uri.parse("$basic/history/userbiztransactions.php");
final Uri allsrhistory = Uri.parse("$basic/history/usersrtransactions.php");
final Uri allbuycoinhistory = Uri.parse("$basic/history/userbuycointransactions.php");
final Uri allbiz2history = Uri.parse("$basic/history/userbiz2transactions.php");
final Uri pointincomehistory = Uri.parse("$basic/history/userpointhistory.php");
final Uri pointwithdrawhistory = Uri.parse("$basic/history/userwithdrawal.php");



// RATE API
final Uri getallsellrate = Uri.parse("$basic/rate/newallrates.php");
final Uri getallliverate = Uri.parse("$basic/rate/allliverates.php");
final Uri getnewcoinslist = Uri.parse("$basic/rate/newcoinslist.php");
final Uri getbizcoinslist = Uri.parse("$basic/rate/bizcoinslist.php");
final Uri biz2coinlist = Uri.parse("$basic/rate/biz2coinslist.php");

// bizsuit
final Uri bizsuitaddwalet = Uri.parse("$basic/bizsuit/addnewwallet.php");
final Uri bizsuitupdatewallet = Uri.parse("$basic/bizsuit/updatewallet.php");
final Uri bizsuituserwalletlist= Uri.parse("$basic/bizsuit/userwalletlist.php");
final Uri bizsuitupdatemainwallet= Uri.parse("$basic/bizsuit/updatemainbiz.php");

 
// SELL NOW API
final Uri sellpaxful = Uri.parse("$basic/sell/sellpaxful.php");
final Uri sellpm = Uri.parse("$basic/sell/sellpm.php");
final Uri sellnewcoins = Uri.parse("$basic/sell/sellnewcoins.php");
final Uri sellbch = Uri.parse("$basic/sell/sellbch.php");
final Uri selleth = Uri.parse("$basic/sell/selleth.php");
final Uri sellltc = Uri.parse("$basic/sell/sellltc.php");
final Uri selldai = Uri.parse("$basic/sell/selldai.php");
final Uri selldoge = Uri.parse("$basic/sell/selldoge.php");
final Uri sellunibc= Uri.parse("$basic/sell/selluni.php");
final Uri sellusdc= Uri.parse("$basic/sell/sellusdc.php");
final Uri sellbc= Uri.parse("$basic/sell/sellblockchain.php");
final Uri sellbiz= Uri.parse("$basic/sell/sellbiz.php");
final Uri biz2sellcoin = Uri.parse("$basic/sell/sellbiz2.php");




// SYSTEN API
final Uri newappversion = Uri.parse("$basic/newappnotification.php");
final Uri activepax = Uri.parse("$basic/swappaxful.php");


// SPEND RECEIVE API
final Uri userwalletlist = Uri.parse("$basic/spendreceive/userwalletlist.php");
final Uri allsrcoinlist = Uri.parse("$basic/spendreceive/allwalletlist.php");
final Uri useraddwallet = Uri.parse("$basic/spendreceive/useraddwallet.php");
final Uri feecalculator = Uri.parse("$basic/spendreceive/feecalculator.php");
final Uri usersendcoin = Uri.parse("$basic/spendreceive/usersendcoin.php");
final Uri usersellcoin = Uri.parse("$basic/spendreceive/usersellcoin.php");



// BUY COINS
final Uri buycoin = Uri.parse("$basic/buycoin/buycoin.php");
final Uri buycoinlist = Uri.parse("$basic/buycoin/allbuycoinlist.php");
final Uri buycoinpriority = Uri.parse("$basic/buycoin/allbuypriority.php");
final Uri buycoinprioritycal = Uri.parse("$basic/buycoin/priorityfeecalc.php");
final Uri buycoinsaveaddress = Uri.parse("$basic/buycoin/saveaddress.php");
final Uri buycoinusersavedaddr = Uri.parse("$basic/buycoin/allsavedaddress.php");



































}
