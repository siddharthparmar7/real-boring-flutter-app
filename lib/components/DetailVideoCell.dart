import 'package:flutter/material.dart';

class DetailVideoCell extends StatelessWidget {
  final video;
  DetailVideoCell(this.video);

  @override
  Widget build(BuildContext context) {
    return new FlatButton(
      padding: new EdgeInsets.all(10.0),
      child: new Row(
        children: <Widget>[
          new Container(
              height: 90, child: new Image.network(video["imageUrl"])),
          new Flexible(
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Padding(
                  padding: new EdgeInsets.only(left: 10),
                  child: new Text(
                    video["name"],
                    style: new TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      onPressed: () {},
    );
  }
}
