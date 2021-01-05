import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

Color white = Color.fromRGBO(250, 250, 250, 1);
const docs = [
  {
    "title": "Node.js 开发文档",
    "content": "Node.js 是一个基于Chrome JavaScript 运行时建立的一个平台。Node.js是一个事件驱动I/O服务端JavaScript环境，基于Google的V8引擎，V8引擎执行Javascript的速度非常快，性能非常好。"
  },
  {
    "title": "Koa 下一代web开发平台",
    "content": "Koa 是一个新的 web 框架，由 Express 幕后的原班人马打造， 致力于成为 web 应用和 API 开发领域中的一个更小、更富有表现力、更健壮的基石。 通过利用 async 函数，Koa 帮你丢弃回调函数，并有力地增强错误处理。 Koa 并没有捆绑任何中间件， 而是提供了一套优雅的方法，帮助您快速而愉快地编写服务端应用程序。"
  }
];

class DocsPage extends StatefulWidget {
  @override
  _DocsPageState createState() => _DocsPageState();
}

class _DocsPageState extends State<DocsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Documents'),
        backgroundColor: white,
        elevation: 1,
        centerTitle: true,
      ),
      body: Container(
        color: Colors.black12,
        child: ListView(
          children: [
            flare,
            ...docs.map((e) => docCard(context, e['title'], e['content'])),
          ],
        ),
      ),
    );
  }
}

Widget docCard(BuildContext context, String title, String content) {
  Widget card = Container(
    width: double.infinity,
    margin: EdgeInsets.only(left: 20, right: 20, top: 10),
    padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
    decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.all(Radius.circular(15))
    ),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              Icon(Ionicons.book_outline, color: Colors.greenAccent,),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  maxLines: 1,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
        Container(
            child: Text(content, maxLines: 4, overflow: TextOverflow.ellipsis,)
        )
      ],
    ),
  );
  return card;
}

Widget flare = Container(
  height: 180,
  width: double.infinity,
  margin: EdgeInsets.only(left: 20, right: 20, top: 10),
  decoration: BoxDecoration(
      color: white,
      borderRadius: BorderRadius.all(Radius.circular(15))
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.all(Radius.circular(15)),
    child: FlareActor("assets/flare/sun.flr", alignment:Alignment.center, fit:BoxFit.fitWidth, animation:"Sun Rotate"),
  ),
);