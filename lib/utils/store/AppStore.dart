import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:loadng/styles/AppColors.dart';
import 'package:loadng/utils/constants.dart';

part 'AppStore.g.dart';

class AppStore = AppStoreBase with _$AppStore;

abstract class AppStoreBase with Store {
  @observable
  bool isDarkModeOn = false;

  @observable
  Color scaffoldBackground;

  @observable
  Color backgroundColor;

  @observable
  Color backgroundSecondaryColor;

  @observable
  Color textPrimaryColor;

  @observable
  Color appColorPrimaryLightColor;

  @observable
  Color textSecondaryColor;

  @observable
  Color appBarColor;

  @observable
  Color iconColor;

  @observable
  Color iconSecondaryColor;

  @observable
  String selectedLanguage = 'en';

  @action
  Future<void> setDarkMode(bool aIsDarkModeOn) async {
    isDarkModeOn = aIsDarkModeOn;

    if (aIsDarkModeOn) {
      scaffoldBackground = AppColors.appBackgroundColorDark;

      appBarColor = AppColors.cardBackgroundBlackDark;
      backgroundColor = Colors.white;
      backgroundSecondaryColor = Colors.white;
      appColorPrimaryLightColor = AppColors.cardBackgroundBlackDark;

      iconColor = AppColors.iconColorPrimary;
      iconSecondaryColor = AppColors.iconColorSecondary;

      textPrimaryColor = whiteColor;
      textSecondaryColor = Colors.white54;

      textPrimaryColorGlobal = whiteColor;
      textSecondaryColorGlobal = Colors.white54;
      shadowColorGlobal = AppColors.appShadowColorDark;
    } else {
      scaffoldBackground = AppColors.appWhite;

      appBarColor = AppColors.appWhite;
      backgroundColor = Colors.black;
      backgroundSecondaryColor = AppColors.appSecondaryBackgroundColor;
      appColorPrimaryLightColor = AppColors.appColorPrimaryLight;

      iconColor = AppColors.iconColorPrimaryDark;
      iconSecondaryColor = AppColors.iconColorSecondaryDark;

      textPrimaryColor = AppColors.appTextColorPrimary;
      textSecondaryColor = AppColors.appTextColorSecondary;

      textPrimaryColorGlobal = AppColors.appTextColorPrimary;
      textSecondaryColorGlobal = AppColors.appTextColorSecondary;
      shadowColorGlobal = AppColors.appShadowColor;
    }

    await setBool(isDarkModeOnPref, aIsDarkModeOn);
  }

  @action
  void setLanguage(String aLanguage) => selectedLanguage = aLanguage;
}
