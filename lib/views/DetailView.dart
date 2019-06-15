import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../components/DetailVideoCell.dart';

class DetailPage extends StatefulWidget {
  final _course;
  DetailPage(this._course);
  @override
  State<StatefulWidget> createState() {
    return new DetailPageState(_course);
  }
}

class DetailPageState extends State<DetailPage> {
  final _course;
  var _isLoading = true;
  var _videos = [];
  DetailPageState(this._course);

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  _fetchData() async {
    final url =
        "http://api.letsbuildthatapp.com/youtube/course_detail?id=${_course['id']}";
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final videos = json.decode(response.body);
      print(videos);
      setState(() {
        _isLoading = false;
        _videos = videos;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(_course['name']),
      ),
      body: new Center(
        child: _isLoading
            ? new CircularProgressIndicator()
            : new ListView.builder(
                itemCount: _videos.length,
                itemBuilder: (BuildContext context, int index) {
                  final video = _videos[index];
                  return DetailVideoCell(video);
                },
              ),
      ),
    );
  }
}
