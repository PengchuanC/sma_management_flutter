import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sma_management/theme/iconfont.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetail extends StatefulWidget {
  final dynamic news;

  NewsDetail({Key key, this.news}): super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  bool _like = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Row(
            children: [
              Container(width: 4, color: Colors.redAccent, height: 40, margin: EdgeInsets.only(right: 15),),
              Expanded(child: Text('${widget.news['infotitle']}', maxLines: 2, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),))
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
        actions: [
          GestureDetector(
            child: Container(
              height: 40,
              width: 40,
              child: _like? FlareActor(
                'assets/flare/like.flr',
                animation: 'Like',
                fit: BoxFit.contain,
              ): Icon(Ionicons.heart_outline),
            ),
            onTap: (){
              setState(() {
                _like = !_like;
              });
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 0),
            child: Text('${widget.news['content']}', style: TextStyle(fontSize: 18),),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 45,
        decoration: BoxDecoration(
            color: Color.fromRGBO(240, 240, 240, 1),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(5), topRight: Radius.circular(5))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.arrow_back), onPressed: ()=>Navigator.pop(context)),
            Container(
              width: 100,
              child: Row(
                children: [
                  IconButton(icon: Icon(Iconfont.wechat), onPressed: () async {
                    String url = 'wexin://';
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  }),
                  IconButton(icon: Icon(Iconfont.browser), onPressed: () async {
                    String url = widget.news['linkaddress'];
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
