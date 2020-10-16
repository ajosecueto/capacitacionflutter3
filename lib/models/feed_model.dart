import 'package:capacitacionflutter3/core/network.dart';
import 'package:capacitacionflutter3/models/post.dart';
import 'package:flutter/cupertino.dart';

class FeedModel extends ChangeNotifier {
  List<Post> posts = [];

  Future<void> getAllData() async {
    try {
      final jsonDecoded = await Network.get("api/feed/");
      posts =
          (jsonDecoded["data"] as List).map((e) => Post.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      return Future.error(e);
    }
  }
}
