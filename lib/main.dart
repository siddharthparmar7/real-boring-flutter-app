import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import './components/VideoCell.dart';
import './views/DetailView.dart';

void main() => runApp(RealBoringApp());

class RealBoringApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new RealBoringState();
  }
}

class RealBoringState extends State<RealBoringApp> {
  var _isLoading = false;
  var _videos = [];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    final url = "http://api.letsbuildthatapp.com/youtube/home_feed";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final map = json.decode(response.body);
      final videosJson = map["videos"];
      setState(() {
        _isLoading = false;
        _videos = videosJson;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: new AppBar(
          title: new Text("Real Boring App"),
          actions: <Widget>[
            new IconButton(
              icon: new Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  _isLoading = true;
                });
                _fetchData();
              },
            )
          ],
        ),
        body: new Center(
            child: _isLoading
                ? new CircularProgressIndicator()
                : new ListView.builder(
                    itemCount: _videos.length,
                    itemBuilder: (context, index) {
                      final video = _videos[index];
                      return new FlatButton(
                        padding: new EdgeInsets.all(0.0),
                        child: new VideoCell(video),
                        onPressed: () {
                          print("video was clicked");
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (context) => new DetailPage(video)));
                        },
                      );
                    },
                  )),
      ),
    );
  }
}
