import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class NewsDetail extends StatefulWidget {
  final dynamic news;

  NewsDetail({Key key, this.news}): super(key: key);

  @override
  _NewsDetailState createState() => _NewsDetailState();
}

class _NewsDetailState extends State<NewsDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          child: Row(
            children: [
              Container(width: 4, color: Colors.redAccent, height: 40, margin: EdgeInsets.only(right: 15),),
              Expanded(child: Text('${widget.news['infotitle']}', maxLines: 2, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800),))
            ],
          ),
        ),
        elevation: 0,
        backgroundColor: Color.fromRGBO(250, 250, 250, 1),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Text('${widget.news['content']}', style: TextStyle(fontSize: 15),),
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 40,
        color: Color.fromRGBO(240, 240, 240, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(icon: Icon(Icons.arrow_back), onPressed: (){Navigator.pop(context);}),
            IconButton(icon: Icon(Icons.share_rounded), onPressed: (){})
          ],
        ),
      ),
    );
  }
}
