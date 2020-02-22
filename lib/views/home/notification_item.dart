import 'package:flutter/material.dart';
import 'package:iota/models/notification.dart';
import 'package:iota/utils/text_style.dart';

import '../../utils/local_images.dart';

class NotificationItemView extends StatelessWidget {
  NotificationModel notification;


  NotificationItemView(this.notification);

  @override
  Widget build(BuildContext context) {
    final userImage = Container(
      height: 50,
      width: 50,
      child: Image.asset(notification.icon),
    );

    final tvTitle = Container(
      width: double.infinity,
      padding: EdgeInsets.only(left: 12, right: 8),
      child: Text(
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

    final tvDate = Container(
      padding: EdgeInsets.only(left: 12, right: 8, top: 5),
      child: Text(
        notification.date,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            fontSize: 13,
            color: Color(0xFF00A9F4),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400),
      ),
    );

    final tvTime = Container(
      padding: EdgeInsets.only(left: 12, right: 8, top: 5),
      child: Text(
        notification.time,
        textAlign: TextAlign.center,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: CommonStyle.getAppFont(
            fontSize: 13,
            color: Color(0xFF00A9F4),
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w400),
      ),
    );

    return Container(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              userImage,
              Flexible(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    tvTitle,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[tvDate, tvTime],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 4, bottom: 4),
            child: Divider(
              color: Color(0xFF4150B5),
            ),
          ),
        ],
      ),
    );
  }
}
