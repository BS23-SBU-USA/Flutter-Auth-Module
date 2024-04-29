part of 'theme.dart';

   
class CustomAppBarTheme{
  static final AppBarTheme _appBarTheme = AppBarTheme(
    backgroundColor: UIColors.white,
    elevation: 0,
    titleSpacing: 0,
    centerTitle: true,
    titleTextStyle: AppTypography.semiBold18Caros(
      color: UIColors.black,
    ),
    iconTheme: const IconThemeData(
      color: UIColors.black,
    ),
  );

  static AppBarTheme light(){
    return _appBarTheme.copyWith(
      backgroundColor: lightColorScheme.background,
    );
  }

  static AppBarTheme dark(){
    return _appBarTheme.copyWith(
      backgroundColor: darkColorScheme.background,
    );
  }
   
}
