import 'dart:async';

import 'package:capacitacionflutter3/core/network.dart';
import 'package:capacitacionflutter3/models/post.dart';

class RxProvider {
  StreamController<List<Post>> _controller = StreamController<List<Post>>();

  Stream<List<Post>> get getData => _controller.stream;

  void getAllData() async {
    try {
      final jsonDecoded = await Network.get("api/feed/");
      _controller.add(
          (jsonDecoded["data"] as List).map((e) => Post.fromJson(e)).toList());
    } catch (e) {
      _controller.addError(e);
    }
  }

  void dispose() {
    _controller.close();
  }
}
