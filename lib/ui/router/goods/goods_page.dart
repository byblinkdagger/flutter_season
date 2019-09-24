import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_season/model/goods_res.dart';
import 'package:flutter_season/provider/provider_widget.dart';
import 'package:flutter_season/provider/view_state_widget.dart';
import 'package:flutter_season/view_model/goods_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
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
                                style: TextStyle(fontSize: 22.0)
                                , textAlign: TextAlign.start,),
                              SizedBox(height: 4,),
                              Text(model.goodsRes.cDescription,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.grey.withAlpha(122)),
                                  textAlign: TextAlign.start),
                              SizedBox(height: 4,),
                              Text(model.goodsRes.iMaxMarketPrice,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.red),
                                  textAlign: TextAlign.start),
                            ],
                            mainAxisAlignment: MainAxisAlignment.start,)
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.only(left: 12, right: 12),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(model.goodsRes.cPDCName,
                                style: TextStyle(fontSize: 12.0),),
                              Text(model.goodsRes.iSumStock,
                                style: TextStyle(fontSize: 16.0),),
                            ]),),
                    ),
                    SliverToBoxAdapter(child:
                    ListTile(
                      title: Text("商品规格"),
                      subtitle: Text("这件商品还没开卖呢"),
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
            )
        );
      },
    );
  }
}
