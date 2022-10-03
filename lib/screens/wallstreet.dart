import 'package:flutter/material.dart';
import 'package:news_app/services/api.dart';
import 'package:news_app/services/model/wall_street_model.dart';
import 'package:news_app/widget/news_card.dart';

class WallStreetNews extends StatefulWidget {
  const WallStreetNews({Key? key}) : super(key: key);

  @override
  State<WallStreetNews> createState() => _WallStreetNewsState();
}

class _WallStreetNewsState extends State<WallStreetNews> {
  Future<WallStreetModel>? _wallstreet;

  @override
  void initState() {
    super.initState();
    _wallstreet = ApiCall().wallStreetApi();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WallStreetModel>(
      future: _wallstreet,
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
                  'Unable to get Wall Street News. Kindly Refresh',
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
