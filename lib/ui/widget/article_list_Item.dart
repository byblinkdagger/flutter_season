import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_season/model/home.dart';
import 'package:flutter_season/ui/router/goods/goods_page.dart';
import 'package:oktoast/oktoast.dart';

import 'Image.dart';
import 'animated_provider.dart';
import 'favourite_animation.dart';

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
                              "已售：" + article.iSoldSum,
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
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) {
                  return GoodsDetailPage(cCode: article.cInvCode,);
                },
              ));
            },
          ),
        ),
        Positioned(
          bottom: 0,
          right: 80,
          child: ArticleFavouriteWidget(Random().nextBool()),
        )
      ],
    );
  }
}

/// 收藏按钮
class ArticleFavouriteWidget extends StatelessWidget {
  bool collect;

  ArticleFavouriteWidget(this.collect);

  @override
  Widget build(BuildContext context) {
    ///位移动画的tag
    var uniqueKey = UniqueKey();
    return GestureDetector(
      behavior: HitTestBehavior.opaque, //否则padding的区域点击无效
      onTap: () async {
        if (collect) {
          addFavourites(context,collect:collect);
        }
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Hero(
          tag: uniqueKey,
          child: ScaleAnimatedSwitcher(
            child: Icon(
                collect
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: Colors.redAccent[100]),
          ),
        ),
      ),
    );
  }
}

addFavourites(BuildContext context,
    {
      bool collect,
      Object tag: 'addFavourite',
      bool playAnim: true
    }) {
  //未登录
  if (playAnim) {
    ///接口调用成功播放动画
    Navigator.push(
        context,
        HeroDialogRoute(
            builder: (_) =>
                FavouriteAnimationWidget(
                  tag: tag,
                  add: collect,
                )));
  }
}


