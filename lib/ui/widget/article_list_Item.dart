import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_season/model/home.dart';

import 'Image.dart';

class ArticleItemWidget extends StatelessWidget {
  final Bean0102 article;
  final int index;
  final GestureTapCallback onTap;

  /// 首页置顶
  final bool top;

  ArticleItemWidget(this.article,
      {Key key, this.index, this.onTap, this.top: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var backgroundColor = Theme
        .of(context)
        .scaffoldBackgroundColor;
    return Stack(
      children: <Widget>[
        Material(
          color: top
              ? Theme
              .of(context)
              .accentColor
              .withAlpha(10)
              : backgroundColor,
          child: InkWell(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: Divider.createBorderSide(context, width: 0.7),
                  )),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      ClipOval(
                        child: Image.asset(
                            "assets/images/avatar-default.png", width: 20),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          article.cInvName,
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption,
                        ),
                      ),
                      Expanded(
                        child: SizedBox.shrink(),
                      ),
                      Text(article.iPrice,
                          style: Theme
                              .of(context)
                              .textTheme
                              .caption),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "已售："+article.iSoldSum,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .caption,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      WrapperImage(
                        url: article.cThumPicture,
                        height: 60,
                        width: 60,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


