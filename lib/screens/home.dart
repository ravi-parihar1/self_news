import 'package:flutter/material.dart';
import 'package:self_news/models/article_model.dart';
import 'package:self_news/screens/article_view.dart';
import 'package:self_news/screens/themedata.dart';
import '../helper/news.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:lottie/lottie.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    //categories = getCategories();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Row(
           mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Lottie.network('https://assets8.lottiefiles.com/packages/lf20_2LdLki.json',height: 50,width: 100),

            //Lottie.network('https://assets4.lottiefiles.com/packages/lf20_kzfpndct.json',height: 50,width: 100),
          ],
        ),
      ),
      body: _loading
          ? Center(
              child: Container(
                child: const CircularProgressIndicator(),
              ),
            )
          :Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [

                    Container(
                      height: 600,
                      padding: const EdgeInsets.only(top: 20),
                      child: Swiper(
                          itemCount: articles.length,
                          itemWidth: 300,
                          layout: SwiperLayout.STACK,

                          //shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return BlogTile(
                              imageUrl: articles[index].urlToImage,
                              title: articles[index].title,
                              desc: articles[index].description,
                              url: articles[index].url,
                            );
                          }),
                    ),
                  ],
                ),
              ),

    );
  }
}


class BlogTile extends StatelessWidget {
  final String imageUrl, title, desc, url;

  const BlogTile(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.desc,
      required this.url})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ArticleView(
                      blogUrl: url,
                    )));
      },
      child: Card(

        elevation: 20,
        shadowColor: Colors.black,
        //color: Colors.white,

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            //set border radius more than 50% of height and width to make circle
          ),

        child: Container(

          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(imageUrl,height: 300,),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.only(right: 16,left: 16),
                child: Column(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      desc,
                      style: const TextStyle(color: Colors.blueGrey),
                    ),
                  ],
                ),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
