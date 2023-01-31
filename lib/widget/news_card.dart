import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsCardWidget extends StatelessWidget {
  final dynamic data;
  NewsCardWidget({Key? key, this.data}) : super(key: key);

  final OpenWebsite inAppChrome = OpenWebsite();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.articles!.length,
      shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            if (Platform.isWindows) {
              launch("${data.articles![index].url}");
            } else {
              inAppChrome.open(
                url: Uri.parse("${data.articles![index].url}"),
                options: ChromeSafariBrowserClassOptions(
                  android: AndroidChromeCustomTabsOptions(
                      addDefaultShareMenuItem: false),
                  ios: IOSSafariOptions(barCollapsingEnabled: true),
                ),
              );
            }
          },
          child: Container(
            margin: const EdgeInsets.only(top: 14),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  blurRadius: 12.0,
                  offset: const Offset(4.0, 5.0),
                ),
              ],
              // border: Border.all(color: Colors.red),
            ),
            child: Column(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    image: DecorationImage(
                      image:
                          NetworkImage("${data.articles![index].urlToImage}"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data.articles![index].title}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "${data.articles![index].description}",
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 8),
                      FittedBox(
                        child: Text.rich(
                          TextSpan(
                            text: 'By',
                            children: [
                              TextSpan(
                                text: ' ${data.articles![index].author} •',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              TextSpan(
                                text: ' ${data.articles![index].source!.name} ',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: Colors.red,
                                ),
                              ),
                              TextSpan(
                                  text:
                                      '• ${data.articles![index].publishedAt}'),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class OpenWebsite extends ChromeSafariBrowser {
  @override
  void onOpened() {
    debugPrint("ChromeSafari browser opened");
  }

  @override
  void onCompletedInitialLoad() {
    debugPrint("ChromeSafari browser initial load completed");
  }

  @override
  void onClosed() {
    debugPrint("ChromeSafari browser closed");
  }
}
