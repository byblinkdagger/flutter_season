import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_season/model/goods_res.dart';
import 'package:flutter_season/provider/provider_widget.dart';
import 'package:flutter_season/provider/view_state_widget.dart';
import 'package:flutter_season/view_model/goods_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';


class GoodsDetailPage extends StatefulWidget {
  GoodsDetailPage({Key key, this.cCode}) : super(key: key);

  String cCode;

  @override
  _GoodsDetailPageState createState() => _GoodsDetailPageState(cCode);
}


class _GoodsDetailPageState extends State<GoodsDetailPage> {

  String cCode;

  _GoodsDetailPageState(this.cCode);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<GoodsViewModel>(
      model: GoodsViewModel(cCode),
      onModelReady: (model) => model.getGoodsData(),
      builder: (BuildContext context, GoodsViewModel model, Widget child) {
        if (model.busy) {
          return ViewStateBusyWidget();
        } else if (model.error) {
          return ViewStateWidget(onPressed: model.getGoodsData);
        } else if (model.empty) {
          return ViewStateEmptyWidget(onPressed: model.getGoodsData);
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("商品详情"),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.share),
                onPressed: () {
                  showToast("分享出去啦");
                },
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  showToast("前往购物车付款");
                },
              ),
            ],
          ),
          body: SmartRefresher(
              controller: model.refreshController,
              onRefresh: model.getGoodsData,
              enablePullUp: false,
//                    header: WaterDropHeader(),
              child: CustomScrollView(
                slivers: <Widget>[
                  SliverToBoxAdapter(
                    child: Container(
//                          margin: const EdgeInsets.symmetric(vertical: 18.0),
                      child: SizedBox(
                        height: 250.0,
                        child: Swiper(
                          loop: false,
                          autoplay: true,
                          autoplayDelay: 5000,
                          pagination: SwiperPagination(),
                          itemCount: model.goodsRes.Pictures.length,
                          itemBuilder: (ctx, index) {
                            return CachedNetworkImage(
                                imageUrl: model.goodsRes.Pictures[index],
                                placeholder: (context, url) =>
                                    Center(
                                        child: CupertinoActivityIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                                fit: BoxFit.fill);
                          },
                        ),
                      ),
                    ),
                  ),
                  SliverToBoxAdapter(
                    child:
                    Padding(
                        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: Column(
                          children: <Widget>[
                            Text(model.goodsRes.cPDName,
                              style: TextStyle(
                                  fontSize: 28.0, fontWeight: FontWeight.w200)
                              , textAlign: TextAlign.start,),
                            SizedBox(height: 4,),
                            Text(model.goodsRes.cDescription,
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey.withAlpha(122)),
                                textAlign: TextAlign.start),
                            SizedBox(height: 6,),
                            Text("￥" + model.goodsRes.iMaxMarketPrice,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.lightBlue),
                                textAlign: TextAlign.start),
                          ],
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,)
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(model.goodsRes.cPDCName,
                              style: TextStyle(fontSize: 12.0,
                                  color: Colors.grey.withAlpha(122)),),
                            Text(model.goodsRes.iSumStock,
                              style: TextStyle(fontSize: 16.0),),
                          ]),),
                  ),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: EdgeInsets.only(left: 12, right: 12),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("重量：0.5kg",
                              style: TextStyle(fontSize: 12.0,
                                  color: Colors.grey.withAlpha(122)),),
                            Text("已售：35件",
                              style: TextStyle(fontSize: 12.0,
                                  color: Colors.grey.withAlpha(122)),),
                          ]),),
                  ),
                  SliverToBoxAdapter(child:
                  ListTile(
                    title: Text("商品规格"),
                    subtitle: Text("这件商品还没开卖呢"),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return new Container(
                              child: new Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: new Column(
                                  children: <Widget>[
                                    ListTile(
                                      leading: new Icon(Icons.chat),
                                      title: new Text("规格1"),
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.chat),
                                      title: new Text("规格2"),
                                    ),
                                    ListTile(
                                      leading: new Icon(Icons.chat),
                                      title: new Text("规格3"),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                  ),),
                  SliverToBoxAdapter(child:
                  ListTile(
                    title: Text("商品评价"),
                    trailing: Icon(Icons.chevron_right),
                  ),),
                  SliverToBoxAdapter(child:
                  ListTile(
                    title: Text("折折仓地址"),
                    trailing: Icon(Icons.chevron_right),
                  ),),
                  SliverToBoxAdapter(child:
                  CachedNetworkImage(
                      imageUrl: model.goodsRes.lstDetail[0],
                      placeholder: (context, url) =>
                          Center(
                              child: CupertinoActivityIndicator()),
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error),
                      fit: BoxFit.fill)),
                ],
              )
          ),
          bottomSheet: SizedBox(
            height: 45,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: FlatButton.icon(
                      icon: Icon(Icons.add),
                      label: Text("收藏", style: TextStyle(color: Colors.pink,),),
                      onPressed: () => {},
                    )
                ),
                Expanded(
                  flex: 3,
                  child: FlatButton.icon(
                    icon: Icon(Icons.shopping_basket, color: Colors.white,),
                    label: Text("购物车", style: TextStyle(color: Colors.white),),
                    color: Colors.pink,
                    onPressed: () => {},
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
