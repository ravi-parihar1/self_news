import 'dart:convert';

import '../models/article_model.dart';
import 'package:http/http.dart' as http;


class News {

  List<ArticleModel> news = [];

  Future<void> getNews() async {
    String url =
        "https://newsapi.org/v2/top-headlines?country=in&apiKey=bf6ad270a04a4d2c95815bc7d259004f";

    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              urlToImage: element['urlToImage'],
              url: element['url'],
              description: element['description'],
              content: element['content']
          );
          news.add(articleModel);
        }
      });
    }
  }
}


