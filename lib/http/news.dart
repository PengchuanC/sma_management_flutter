import 'package:dio/dio.dart';

final String url = "https://sma.nomuraoi-sec.com/api/sma/v2/news/advance/";

Future getNews(String category, int page) async {
  var resp = await Dio().get(url, queryParameters: {'category': category, 'page': page});
  return resp.data;
}