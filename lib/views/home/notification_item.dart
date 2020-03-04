import 'package:flutter/material.dart';
import 'package:iota/models/notification.dart';
import 'package:iota/utils/text_style.dart';

class NotificationItemView extends StatelessWidget {
  NotificationModel notification;


  NotificationItemView(this.notification);

  @override
  Widget build(BuildContext context) {
    final userImage = new Container(
      height: 50,
      width: 50,
      child: new Image.asset(notification.icon),
    );

    final tvTitle = new Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12, right: 8),
      child: new Text(
        notification.title,
        textAlign: TextAlign.left,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            fontSize: 15,
            color: Color(0xFF34485B),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500),
      ),
    );

    final tvDate = new Container(
      padding: EdgeInsets.only(left: 12, right: 8, top: 5),
      child: new Text(
        notification.date,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            fontSize: 13,
            color: new Color(0xFF00A9F4),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400),
      ),
    );

    final tvTime = new Container(
      padding: EdgeInsets.only(left: 12, right: 8, top: 5),
      child: new Text(
        notification.time,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            fontSize: 13,
            color: new Color(0xFF00A9F4),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400),
      ),
    );

    return new Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: new Column(
        children: <Widget>[
          new Row(
            children: <Widget>[
              userImage,
              new Flexible(
                flex: 1,
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    tvTitle,
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[tvDate, tvTime],
                    ),
                  ],
                ),
              ),
            ],
          ),
          new Container(
            margin: EdgeInsets.only(top: 4, bottom: 4),
            child: new Divider(
              color: new Color(0xFF4150B5),
            ),
          ),
        ],
      ),
    );
  }
}
