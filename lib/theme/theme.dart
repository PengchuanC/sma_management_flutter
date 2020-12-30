import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sp_util/sp_util.dart';

Map<String, Color> themeColorMap = {
  'gray': Colors.grey,
  'blue': Colors.blue,
  'blueAccent': Colors.blueAccent,
  'cyan': Colors.cyan,
  'deepPurple': Colors.purple,
  'deepPurpleAccent': Colors.deepPurpleAccent,
  'deepOrange': Colors.orange,
  'green': Colors.green,
  'indigo': Colors.indigo,
  'indigoAccent': Colors.indigoAccent,
  'orange': Colors.orange,
  'purple': Colors.purple,
  'pink': Colors.pink,
  'red': Colors.red,
  'teal': Colors.teal,
  'black': Colors.black,
};


class ThemeProvider with ChangeNotifier {
  String _themeColor = '';

  String get themeColor => _themeColor;

  setTheme(String themeColor) {
    _themeColor = themeColor;
    notifyListeners();
  }
}

class ChangeThemePage extends StatefulWidget {
  @override
  _ChangeThemePageState createState() => _ChangeThemePageState();
}

class _ChangeThemePageState extends State<ChangeThemePage> {

  String _colorKey;

  @override
  void initState() {
    _initAsync();
    super.initState();
  }

  Future<void> _initAsync() async {
    await SpUtil.getInstance();
    _colorKey = SpUtil.getString('key_theme_color', defValue: 'blue');
    Provider.of<ThemeProvider>(context, listen: false).setTheme(_colorKey); // 设置初始化主题颜色
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        leading: Icon(Icons.color_lens),
        title: Text('颜色主题'),
        initiallyExpanded: false,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              children: themeColorMap.keys.map((key) {
                Color value = themeColorMap[key];
                return InkWell(
                  onTap: () {
                    setState(() {
                      _colorKey = key;
                      SpUtil.putString('key_theme_color', key);
                      Provider.of<ThemeProvider>(context, listen: false).setTheme(key);
                    });
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    color: value,
                    child: _colorKey == key
                        ? Icon(
                      Icons.done,
                      color: Colors.white,
                    )
                        : null,
                  ),
                );
              }).toList(),
            ),
          )
        ],
      );
  }
}
