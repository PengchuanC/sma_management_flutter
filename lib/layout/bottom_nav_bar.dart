import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:sma_management/pages/docs_page.dart';
import 'package:sma_management/pages/home_page.dart';
import 'package:sma_management/pages/setting_page.dart';
import 'package:sma_management/theme/theme.dart';


final mainPages = <Widget>[HomePage(), ChangeThemePage(), DocsPage(), SettingPage()];

class BottomNavBar extends StatefulWidget {
  final String title;

  BottomNavBar({Key key, this.title}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> with AutomaticKeepAliveClientMixin {
  int _currentIndex = 0;
  final pages = mainPages;
  PageController _pageController;

  themeColor(BuildContext context) {
    Color color = themeColorMap[Provider.of<ThemeProvider>(context).themeColor];
    return color != null ? color : Colors.black38;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: SafeArea(
        child: PageView(
          children: [
            ...pages
          ],
          controller: _pageController,
          physics: NeverScrollableScrollPhysics(),
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Color.fromRGBO(240, 240, 240, 1),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
        ),
        child: SalomonBottomBar(
            currentIndex: _currentIndex,
            onTap: onTabTapped,
            items: [
              SalomonBottomBarItem(
                  icon: _currentIndex == 0
                      ? Icon(Ionicons.planet)
                      : Icon(Ionicons.planet_outline),
                  title: Text('Home'),
                  selectedColor: Colors.redAccent
              ),
              SalomonBottomBarItem(
                  icon: _currentIndex == 1
                      ? Icon(Ionicons.heart)
                      : Icon(Ionicons.heart_outline),
                  title: Text('Like'),
                  selectedColor: Colors.red
              ),
              SalomonBottomBarItem(
                  icon: _currentIndex == 2
                      ? Icon(Ionicons.library)
                      : Icon(Ionicons.library_outline),
                  title: Text('Library'),
                  selectedColor: Colors.blue
              ),
              SalomonBottomBarItem(
                  icon: _currentIndex == 3
                      ? Icon(Ionicons.cog)
                      : Icon(Ionicons.cog_outline),
                  title: Text('Settings'),
                  selectedColor: Colors.green,
              ),
            ]),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }
}
