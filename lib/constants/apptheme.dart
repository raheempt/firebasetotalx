import 'package:firebasetotalx/constants/appcolors.dart';
import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor:AppColors.bgColor,
    appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.primaryColor,
    ) ,
    // textTheme: TextTheme(
    //   titleLarge: AppTextStyles.headline,
    //   titleMedium: AppTextStyles.subtitle,
    //   button: AppTextStyles.button,


    // )
  );
}