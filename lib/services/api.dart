import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'model/apple_news_model.dart';
import 'model/techcrunch_model.dart';
import 'model/tesla_news_model.dart';
import 'model/top_headlines_model.dart';
import 'model/wall_street_model.dart';

class ApiCall {
  final String _nointernet = "No internet connection";
  final String _timeMsg = "Request timeout, connect to a better network";
  final String msg = "An error occured: ";
  static const String apiKey = "8b06d860e8944eb988d2145ab362c0f2&language=en";
  String topHeadUrl =
      "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=$apiKey";
  String appleUrl =
      "https://newsapi.org/v2/everything?q=apple&sortBy=popularity&apiKey=$apiKey";
  String teslaUrl =
      "https://newsapi.org/v2/everything?q=tesla&sortBy=publishedAt&apiKey=$apiKey";
  String techUrl =
      "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=$apiKey";
  String wallStreetUrl =
      "https://newsapi.org/v2/everything?domains=wsj.com&apiKey=$apiKey";

  Future<TopHeadlines> newsApi() async {
    try {
      final response = await http.get(Uri.parse(topHeadUrl)).timeout(
            const Duration(seconds: 60),
          );
      if (response.statusCode == 200) {
        var convert = json.decode(response.body);
        if (convert.toString().isNotEmpty && response.statusCode == 200) {
          TopHeadlines topHeadlines = TopHeadlines.fromJson(convert);

          return topHeadlines;
        }
        return TopHeadlines.fromJson(jsonDecode(response.body));
      } else {
        return TopHeadlines(msg: response.reasonPhrase, status: "Failed");
      }
    } on SocketException catch (_) {
      return TopHeadlines(msg: _nointernet, status: "Failed");
    } on TimeoutException catch (_) {
      return TopHeadlines(msg: _timeMsg, status: "Failed");
    } catch (e) {
      return TopHeadlines(status: "Failed", msg: msg + '$e');
    }
  }

  Future<AppleNewsModel> appleNewsApi() async {
    try {
      final response = await http.get(Uri.parse(appleUrl)).timeout(
            const Duration(seconds: 60),
          );
      if (response.statusCode == 200) {
        var convert = json.decode(response.body);
        if (convert.toString().isNotEmpty && response.statusCode == 200) {
          AppleNewsModel appleNews = AppleNewsModel.fromJson(convert);
          return appleNews;
        }
        return AppleNewsModel.fromJson(jsonDecode(response.body));
      } else {
        return AppleNewsModel(msg: response.reasonPhrase, status: "Failed");
      }
    } on SocketException catch (_) {
      return AppleNewsModel(msg: _nointernet, status: "Failed");
    } on TimeoutException catch (_) {
      return AppleNewsModel(msg: _timeMsg, status: "Failed");
    } catch (e) {
      return AppleNewsModel(status: "Failed", msg: msg + '$e');
    }
  }

  Future<TeslaNewsModel> teslaNewsApi() async {
    try {
      final response = await http.get(Uri.parse(teslaUrl)).timeout(
            const Duration(seconds: 60),
          );
      if (response.statusCode == 200) {
        var convert = json.decode(response.body);
        if (convert.toString().isNotEmpty && response.statusCode == 200) {
          TeslaNewsModel teslaNews = TeslaNewsModel.fromJson(convert);
          return teslaNews;
        }
        return TeslaNewsModel.fromJson(jsonDecode(response.body));
      } else {
        return TeslaNewsModel(msg: response.reasonPhrase, status: "Failed");
      }
    } on SocketException catch (_) {
      return TeslaNewsModel(msg: _nointernet, status: "Failed");
    } on TimeoutException catch (_) {
      return TeslaNewsModel(msg: _timeMsg, status: "Failed");
    } catch (e) {
      return TeslaNewsModel(status: "Failed", msg: msg + '$e');
    }
  }

  Future<TechCrunchModel> techcrunchApi() async {
    try {
      final response = await http.get(Uri.parse(techUrl)).timeout(
            const Duration(seconds: 60),
          );
      if (response.statusCode == 200) {
        var convert = json.decode(response.body);
        if (convert.toString().isNotEmpty && response.statusCode == 200) {
          TechCrunchModel techCrunch = TechCrunchModel.fromJson(convert);
          return techCrunch;
        }
        return TechCrunchModel.fromJson(jsonDecode(response.body));
      } else {
        return TechCrunchModel(msg: response.reasonPhrase, status: "Failed");
      }
    } on SocketException catch (_) {
      return TechCrunchModel(msg: _nointernet, status: "Failed");
    } on TimeoutException catch (_) {
      return TechCrunchModel(msg: _timeMsg, status: "Failed");
    } catch (e) {
      return TechCrunchModel(status: "Failed", msg: msg + '$e');
    }
  }

  Future<WallStreetModel> wallStreetApi() async {
    try {
      final response = await http.get(Uri.parse(wallStreetUrl)).timeout(
            const Duration(seconds: 60),
          );
      if (response.statusCode == 200) {
        var convert = json.decode(response.body);
        if (convert.toString().isNotEmpty && response.statusCode == 200) {
          WallStreetModel wallStreet = WallStreetModel.fromJson(convert);
          return wallStreet;
        }
        return WallStreetModel.fromJson(jsonDecode(response.body));
      } else {
        return WallStreetModel(msg: response.reasonPhrase, status: "Failed");
      }
    } on SocketException catch (_) {
      return WallStreetModel(msg: _nointernet, status: "Failed");
    } on TimeoutException catch (_) {
      return WallStreetModel(msg: _timeMsg, status: "Failed");
    } catch (e) {
      return WallStreetModel(status: "Failed", msg: msg + '$e');
    }
  }
}
