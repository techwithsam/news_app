import 'package:flutter/material.dart';
import 'package:news_app/services/api.dart';
import 'package:news_app/services/model/top_headlines_model.dart';
import 'package:news_app/widget/news_card.dart';

class TopHeadlineNews extends StatefulWidget {
  const TopHeadlineNews({Key? key}) : super(key: key);

  @override
  State<TopHeadlineNews> createState() => _TopHeadlineNewsState();
}

class _TopHeadlineNewsState extends State<TopHeadlineNews> {
  Future<NewsModel>? _headlines;

  @override
  void initState() {
    super.initState();
    _headlines = ApiCall().newsApi();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<NewsModel>(
      future: _headlines,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Center();
          case ConnectionState.waiting:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.active:
            return const Center();
          case ConnectionState.done:
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Unable to get Top Headline News. Kindly Refresh',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.articles == null ||
                  snapshot.data!.articles!.isEmpty) {
                return const Center(
                  child: Text('Oops! No article found 🥴'),
                );
              } else {
                return NewsCardWidget(data: snapshot.data!);
              }
            } else {
              return const Text('No Internet Connection');
            }
        }
      },
    );
  }
}
