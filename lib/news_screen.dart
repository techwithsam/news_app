import 'package:flutter/material.dart';
import 'screens/apple.dart';
import 'screens/techcrunch.dart';
import 'screens/tesla.dart';
import 'screens/top_headlines.dart';
import 'screens/wallstreet.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({Key? key}) : super(key: key);

  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final PageController _controller = PageController();
  int currentSelect = 0;
  final List<String> _tabs = [
    'Top Headlines',
    'Tesla',
    'TechCrunch',
    'Apple',
    'WallStreet'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'News App',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(
                _tabs.length,
                (index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      currentSelect = index;
                      _controller.jumpToPage(index);
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    margin: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: currentSelect == index
                              ? Colors.red
                              : Colors.transparent,
                          width: 4.0,
                        ),
                      ),
                    ),
                    child: Text(
                      _tabs[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        height: 2.2,
                        fontSize: 18,
                        fontWeight: currentSelect == index
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 5,
            child: PageView(
              controller: _controller,
              onPageChanged: (index) {
                setState(() {
                  currentSelect = index;
                });
              },
              children: const [
                TopHeadlineNews(),
                TeslaNews(),
                TechCrunchNews(),
                AppleNews(),
                WallStreetNews(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
