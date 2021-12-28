import 'package:flutter/material.dart';

class AppColors{
static const t6colorPrimary = Color(0XFF313384);
// Light Theme Colors
static const appColorPrimary = Color(0xFF0A79DF);
static const appColorleafcolor = Color(0xff618a3d);
static const appColorPrimaryDark = Color(0xFF0A79DF);
static const appColorAccent = Color(0xFF03DAC5);
static const appTextColorPrimary = Color(0xFF212121);
static const iconColorPrimary = Color(0xFFFFFFFF);
static const appTextColorSecondary = Color(0xFF5A5C5E);
static const iconColorSecondary = Color(0xFF5A5C5E);
static const appLayout_background = Color(0xFFf8f8f8);
static const appWhite = Color(0xFFFFFFFF);
static const t2_view_color = Color(0XFFDADADA);
static const appLight_purple = Color(0xFFdee1ff);
static const appLight_orange = Color(0xFFffddd5);
static const appLight_parrot_green = Color(0xFFb4ef93);
static const appIconTintCherry = Color(0xFFffddd5);
static const appIconTint_sky_blue = Color(0xFF73d8d4);
static const appIconTint_mustard_yellow = Color(0xFFffc980);
static const appIconTintDark_purple = Color(0xFF8998ff);
static const appTxtTintDark_purple = Color(0xFF515BBE);
static const appIconTintDarkCherry = Color(0xFFf2866c);
static const appIconTintDark_sky_blue = Color(0xFF73d8d4);
static const appDark_parrot_green = Color(0xFF5BC136);
static const appDarkRed = Color(0xFFF06263);
static const appLightRed = Color(0xFFF89B9D);
static const appCat1 = Color(0xFF8998FE);
static const appCat2 = Color(0xFFFF9781);
static const appCat3 = Color(0xFF73D7D3);
static const appCat4 = Color(0xFF87CEFA);
static const appCat5 = appColorPrimary;
static const appShadowColor = Color(0x95E9EBF0);
static const appColorPrimaryLight = Color(0xFFF9FAFF);
static const appSecondaryBackgroundColor = Color(0xFF131d25);
static const appDividerColor = Color(0xFFDADADA);
static const realblack = Colors.black;


// Dark Theme Colors
static const appBackgroundColorDark = Color(0xFF131d25);
static const cardBackgroundBlackDark = Color(0xFF1D2939);
static const color_primary_black = Color(0xFF131d25);
static const appColorPrimaryDarkLight = Color(0xFFF9FAFF);
static const iconColorPrimaryDark = Color(0xFF212121);
static const iconColorSecondaryDark = Color(0xFF5A5C5E);
static const appShadowColorDark = Color(0x1AFFFFFF);

// others
static const Color rimary = Color(0xFF183CA6);
static const Color teal = Color(0xFFff1744);
static const Color accents = Color(0xFFd81b60);
static const Color disableButton = Color(0xFFb3e5fc);
static const Color CircleYellow = Color(0xFFb71c1c);
static const Color deep00 = Color(0xFFEE6E73);
static const Color colorDark = Color(0xFFff1744);
static const Color primary = const Color(0xFF1738A0);
static const Color colorassence = const Color(0xFFff1744);
static const Color primaryLight = const Color(0xFF183CA6); //  
static const Color primaryDark = Color(0xFF082683);
static const Color headerInputColor = const Color(0xFFA0A0A0);
static const Color inputTextCorderColor = const Color(0xFFC6DEE9);
static const Color black = Colors.black;
static const Color white = Colors.white;
static const Color modernWhite = Color(0xFFF1F3F6);
static const Color white2 = Color(0xFFDCE7F2);
static const Color lcolor = Color(0xFF087dc0);
static const Color thickLcolor = Color(0xFF005ddf);


static const t12_primary_color = Color(0xFF3d87ff);
static const t12_success = Color(0xFF36d592);
static const t12_error = Color(0xFFF32323);
static const t12_text_color_primary = Color(0xFF1e253a);
static const t12_text_secondary = Color(0xFF838591);
static const t12_edittext_background = Color(0xFFfafafa);
static const t12_cat1 = Color(0xFF366cfd);
static const t12_cat2 = Color(0xFFff7d34);
static const t12_cat3 = Color(0xFF35c88e);
static const t12_cat4 = Color(0xFFf32323); 
static const t12_colors = [t12_cat1, t12_cat2, t12_cat3, t12_cat4];
static const t12_gradient_colors = [[Color(0xFF000000),Color(0xff000000), Color(0xff189f6b)], [Color(0xFF79caff),Color(0xff5b9afb), Color(0xff3155cf)], [Color(0xFFFeaa7b),Color(0xfffb965e), Color(0xfff5762f)]];
static const t1_view_color = Color(0XFFDADADA);
static const t1_app_background = Color(0XFFf8f8f8);
static const t1_colorPrimary = Color(0XFFff8080);
static const t1_textColorPrimary = Color(0XFF333333);
static const qIBus_textChild = Color(0xFF747474);
static const qIBus_app_background = Color(0xFFF8F7F7);
static const t5LayoutBackgroundWhite = Color(0XFFF6F7FA);
static const shadowdarkblack = Colors.black54;
static const shadowdarkblack2 = Colors.black38;
static const t10_textColorSecondary = Color(0xFF888888);


 



}
var t1TextColorPrimary = materialColor(0XFF212121);


Map<int, Color> color = {
  50: Color.fromRGBO(136, 14, 79, .1),
  100: Color.fromRGBO(136, 14, 79, .2),
  200: Color.fromRGBO(136, 14, 79, .3),
  300: Color.fromRGBO(136, 14, 79, .4),
  400: Color.fromRGBO(136, 14, 79, .5),
  500: Color.fromRGBO(136, 14, 79, .6),
  600: Color.fromRGBO(136, 14, 79, .7),
  700: Color.fromRGBO(136, 14, 79, .8),
  800: Color.fromRGBO(136, 14, 79, .9),
  900: Color.fromRGBO(136, 14, 79, 1),
};

MaterialColor materialColor(colorHax) {
  return MaterialColor(colorHax, color);
}

MaterialColor colorCustom = MaterialColor(0XFF5959fc, color);

