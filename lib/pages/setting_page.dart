import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';


class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          camera,
          self,
          separator,
          ...func,
          separator,
          logout,
          expanded,
        ],
      ),
    );
  }
}

// 分割条
Widget separator = Container(
  color: Colors.black12,
  width: double.infinity,
  height: 5,
);

// 相机
Widget camera = Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    FlatButton(onPressed: (){print("scan qrcode");}, child: Icon(Ionicons.camera))
  ],
);

// 个人信息
Widget self = Column(
  children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          children: [
            Container(
              height: 50,
              width: 50,
              margin: EdgeInsets.only(right: 20),
              child: Image.network("https://dss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=3351113425,3755484207&fm=26&gp=0.jpg",
                fit: BoxFit.cover,),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Xenogears", style: TextStyle(fontSize: 18),),
                Text("User ID: Asin", style: TextStyle(fontSize: 14, color: Colors.grey),)
              ],
            ),
          ],
        ),
        Container(
          height: 60,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FlatButton(onPressed: null, child: Icon(Ionicons.qr_code, color: Colors.black38, size: 18,))
            ],
          ),
        )
      ],
    ),
    Container(height: 20,)
  ],
);

List<Widget> func = [
  ListTile(
    leading: Icon(Ionicons.game_controller_outline, color: Colors.pink,),
    title: Text("Game Center"),
    trailing: Icon(Ionicons.chevron_forward),
    ),
  ListTile(
    leading: Icon(Ionicons.logo_github, color: Colors.black,),
    title: Text("GitHub"),
    trailing: Icon(Ionicons.chevron_forward),
  ),
  ListTile(
    leading: Icon(Ionicons.language, color: Colors.lightBlueAccent,),
    title: Text("Language"),
    trailing: Icon(Ionicons.chevron_forward),
  ),
];

// 填充
Widget expanded = Expanded(child: Container(color: Colors.black12,));

// 退出登录
Widget logout = Container(
  width: double.infinity,
  height: 50,
  child: FlatButton(
    onPressed: () {  },
    child: Text("Logout", style: TextStyle(fontSize: 18, color: Colors.black),),
  ),
);