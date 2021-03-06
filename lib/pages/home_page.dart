import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading/indicator/ball_pulse_indicator.dart';
import 'package:loading/loading.dart';
import 'package:skeleton_text/skeleton_text.dart';
import 'package:sma_management/http/news.dart';
import 'package:sma_management/pages/home/news_detail.dart';
import 'package:sma_management/utils/dash.dart';

final sector = <String>['要闻', '宏观', '证券市场', '股票', '基金', '私募', '国际'];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            title: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(225, 225, 225, 1),
                    borderRadius: BorderRadius.all(Radius.circular(15))
                ),
                child: Container(
                  padding: EdgeInsets.only(left: 20, top: 5, bottom: 5),
                  child: Text("Search", style: TextStyle(fontSize: 18, color: Colors.grey),),
                ),
              ),
            ),
            actions: [
              Icon(Ionicons.scan_circle_outline),
              Icon(Ionicons.notifications_circle_outline),
              Container(width: 20,)
            ],
            pinned: true,
            floating: false,
            bottom: TabBar(
              controller: _tabController,
              tabs: [
                ...sector.map((e) => Tab(text: e,)).toList()
              ],
              indicatorWeight: ScreenUtil().setHeight(2),
              indicatorPadding: EdgeInsets.only(
                  left: ScreenUtil().setWidth(10),
                  right: ScreenUtil().setWidth(10)),
              labelPadding:
              EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(12)),
              isScrollable: true,
              indicatorColor: Colors.redAccent,
              labelColor: Colors.redAccent,
              labelStyle: TextStyle(
                fontSize: ScreenUtil().setSp(24),
                color: Colors.redAccent,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: Color(0xffAAAAAA),
              unselectedLabelStyle: TextStyle(
                fontSize: ScreenUtil().setSp(18),
                color: Color(0xffAAAAAA),
              ),
              indicatorSize: TabBarIndicatorSize.label,
            ),
            backgroundColor: Color.fromRGBO(250, 250, 250, 1),
            elevation: 0,
          )
        ];
      },
      body: TabBarView(
        children: [
          ...sector.map((e) => NewsTabView(category: e))
        ],
        controller: _tabController,
      ),
    );
  }

  @override
  void initState() {
    _tabController =
        TabController(initialIndex: 0, length: sector.length, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }
}


class NewsTabView extends StatefulWidget {
  final String category;

  NewsTabView({Key key, this.category}) : super(key: key);

  @override
  _NewsTabViewState createState() => _NewsTabViewState();
}

class _NewsTabViewState extends State<NewsTabView>
    with AutomaticKeepAliveClientMixin {
  ScrollController scrollController = new ScrollController();
  StreamController<List<dynamic>> streamController;
  int _page = 1;
  bool loading = false;
  List _news = [];

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
      child: StreamBuilder(
        stream: streamController.stream,
          builder: (context, snapshot){
            List<dynamic> data = snapshot.data;
            if (data == null) {
              return Center(
                child: skeleton,
              );
            }
            _news.addAll(data);
            return ListView.builder(
              itemBuilder: (ctx, idx){
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return NewsDetail(news: _news[idx]);
                    }));
                  },
                  child: idx != _news.length ? Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(left: 20, right: 20, bottom: 5, top: 5),
                    color: Color.fromRGBO(250, 250, 250, 1),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_news[idx]['infotitle'], style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),),
                        Text(_news[idx]['content'].toString().trim().replaceAll(new RegExp(r"(\s+\b|\b\s|\t|\n)"), ""), maxLines: 4, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 15),),
                        Row(
                          children: [
                            Text(_news[idx]['media'], style: TextStyle(fontSize: 12, color: Colors.black87),),
                            Container(width: 10,),
                            Text(_news[idx]['infopubldate'], style: TextStyle(fontSize: 12, color: Colors.black87)),
                            Container(width: 5,),
                            Text(_news[idx]['infopubltime'], style: TextStyle(fontSize: 12, color: Colors.black87)),
                          ],
                        ),
                        Container(
                          height: 2,
                          color: Colors.black12,
                          margin: EdgeInsets.only(top: 5),
                        )
                      ],
                    ),
                  ): loading? Text(''): Center(
                    child: Loading(indicator: BallPulseIndicator(), size: 20.0, color: Colors.redAccent),
                  ),
                  splashColor: Colors.redAccent.withOpacity(0.1),
                  highlightColor: Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                );
              },
              itemCount: _news.length + 1,
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
            );
          }
      ),
      onRefresh: () async {
        _page = 1;
        List<dynamic> data = await _getNews();
        streamController.sink.add(data);
      },
    );
  }

  @override
  void initState() {
    super.initState();
    streamController = StreamController();
    _getNews();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 20) {
          _getNews();
      }
    });
  }

  Future _getNews() async {
    if (!loading){
      loading = true;
      var ret = await getNews(widget.category, _page);
      streamController.sink.add(ret);
      _page++;
      loading = false;
      return ret;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  void dispose() {
    super.dispose();
    loading = true;
    scrollController.dispose();
    streamController.close();
  }
}

// 新闻骨架
Widget skeleton =  ListView.builder(
    scrollDirection: Axis.vertical,
    physics: BouncingScrollPhysics(),
    itemCount: 6,
    itemBuilder: (BuildContext context, int index) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              color: Colors.white70),
          child: Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 15.0, bottom: 5.0),
                      child: SkeletonAnimation(
                        child: Container(
                          height: 20,
                          width: MediaQuery.of(context).size.width -40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300]),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                      const EdgeInsets.only(left: 15.0, bottom: 5.0),
                      child: SkeletonAnimation(
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width -40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Colors.grey[300]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5.0),
                        child: SkeletonAnimation(
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 10,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                color: Colors.grey[300]),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
