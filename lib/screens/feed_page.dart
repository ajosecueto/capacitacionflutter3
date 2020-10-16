import 'package:capacitacionflutter3/models/feed_model.dart';
import 'package:capacitacionflutter3/widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  FeedModel _feedModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Future.delayed(Duration(seconds: 5), (){
    //   _feedModel?.getAllData();
    // });
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    _feedModel = Provider.of<FeedModel>(context);
    _feedModel.getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView.builder(
            itemCount: _feedModel.posts.length,
            itemBuilder: (context, index) {
              if (_feedModel.posts[index].url == null) {
                return SizedBox();
              }
              return PostWidget(post: _feedModel.posts[index]);
            }),
      ),
    );
  }
}
