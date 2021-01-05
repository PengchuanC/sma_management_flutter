import 'dart:io';
import 'package:flare_splash_screen/flare_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:sma_management/layout/bottom_nav_bar.dart';
import 'package:sma_management/theme/theme.dart';
import 'package:sp_util/sp_util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  runApp(MyApp());
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前
    // MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor:    Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: ThemeProvider())],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, widget) {
          return ScreenUtilInit(
            child: MaterialApp(
              theme: ThemeData(
                primarySwatch: Colors.red,
                primaryColor: Colors.white,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              home: SplashScreen.navigate(
                name: 'assets/flare/splash.flr',
                next: (context) => BottomNavBar(title: 'News',),
                until: () => Future.delayed(Duration(seconds: 2)),
                startAnimation: 'Sun Rotate',
              ),
              // home: BottomNavBar(title: 'News',),
            )
          );
        },
      ),
    );
  }
}
