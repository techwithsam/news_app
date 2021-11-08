import 'package:flutter/material.dart';
import 'package:news_app/services/api.dart';
import 'package:news_app/services/model/techcrunch_model.dart';
import 'package:news_app/widget/news_card.dart';

class TechCrunchNews extends StatefulWidget {
  const TechCrunchNews({Key? key}) : super(key: key);

  @override
  _TechCrunchNewsState createState() => _TechCrunchNewsState();
}

class _TechCrunchNewsState extends State<TechCrunchNews> {
  Future<TechCrunchModel>? _techcrunch;

  @override
  void initState() {
    super.initState();
    _techcrunch = ApiCall().techcrunchApi();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<TechCrunchModel>(
      future: _techcrunch,
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
                  'Unable to get TechCrunch News. Kindly Refresh',
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data!.articles == null ||
                  snapshot.data!.articles!.isEmpty) {
                return const Center(
                  child: Text('Oops! Not article found 🥴'),
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
