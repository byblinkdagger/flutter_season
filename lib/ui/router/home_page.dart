import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_season/config/resource_mananger.dart';
import 'package:flutter_season/model/home.dart';
import 'package:flutter_season/provider/provider_widget.dart';
import 'package:flutter_season/ui/widget/Image.dart';
import 'package:flutter_season/ui/widget/article_list_Item.dart';
import 'package:flutter_season/view_model/home_model.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:oktoast/oktoast.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'abroad/structure_page.dart';
import 'login/login_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  int _counter = 0;
  TabController _tabController;
  List tabs = ["分类", "首页", "专题", "我要开店"];
  int _selectedIndex = 1;
  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return ProviderWidget<HomeViewModel>(
        model: HomeViewModel(),
        onModelReady: (model) => model.loadData(),
        builder: (context, model, child) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              bottom: TabBar(
                  controller: _tabController,
                  tabs: tabs.map((e) => Tab(text: e)).toList()),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                SmartRefresher(
                    controller: model.refreshController,
                    onRefresh: model.loadData,
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
                                itemCount: model.banners.length,
                                itemBuilder: (ctx, index) {
                                  return CachedNetworkImage(
                                      imageUrl: model.banners[index].picture,
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
                        SliverToBoxAdapter(child: Flex(
                          direction: Axis.horizontal,
                          children: <Widget>[
                            Expanded(
                              flex: 1,
                              child: generateTitleArea(
                                  ImageHelper.wrapAssets("home_hot.png"), "热卖"),
                            ),
                            Expanded(
                              flex: 1,
                              child: generateTitleArea(
                                  ImageHelper.wrapAssets("home_newer.png"),
                                  "新品"),
                            ),
                            Expanded(
                              flex: 1,
                              child: generateTitleArea(
                                  ImageHelper.wrapAssets("home_promotion.png"),
                                  "促销"),
                            ),
                            Expanded(
                              flex: 1,
                              child: generateTitleArea(
                                  ImageHelper.wrapAssets("home_recommend.png"),
                                  "推荐"),
                            ),
                          ],
                        ),),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                                (context, index) {
                              Bean0102 item = model.topGoods[index];
                              return ArticleItemWidget(
                                item,
                              );
                            },
                            childCount: model.topGoods?.length ?? 0,
                          ),
                        ),
//                        SliverFixedExtentList(
//                          itemExtent: 120.0,
//                          delegate: SliverChildBuilderDelegate(
//                                (context, index) {
//                              Bean0102 item = model.topGoods[index];
//                              return ArticleItemWidget(
//                                item,
//                              );
//                            },
//                            childCount: model.topGoods?.length ?? 0,
//                          ),
//                        ),
                        SliverGrid.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                          children: model.topGoods?.map((product) {
                            return GoodsItemWidget(product);
                          }).toList(),
                        ),
//                        SliverList(
//                          delegate: SliverChildBuilderDelegate(
//                                (context, index) {
//                              Bean0102 item = model.topGoods[index];
//                              return ArticleItemWidget(
//                                item,
//                              );
//                            },
//                            childCount: model.topGoods?.length ?? 0,
//                          ),
//                        ),
//                        SliverGrid(
//                          gridDelegate: new SliverGridDelegateWithMaxCrossAxisExtent(
//                            maxCrossAxisExtent: 200.0,
//                            mainAxisSpacing: 2.0,
//                            crossAxisSpacing: 2.0,
//                            childAspectRatio: 2.0,
//                          ),
//                          delegate: SliverChildBuilderDelegate(
//                                (context, index) {
//                              Bean0102 item = model.topGoods[index];
//                              return GoodsItemWidget(item);
//                            },
//                            childCount: model.topGoods?.length ?? 0,
//                          ),
//                        )
//                      Container(width: double.infinity,
//                        height: 5,
//                        color: Color(0xFFF4F4F4),
//                        margin: EdgeInsets.symmetric(vertical: 5.0),),
//                      SizedBox(
//                          width: double.infinity,
//                          height: 200,
//                          child: ListView.builder(
//                              itemCount: model.topGoods.length,
//                              itemBuilder: (BuildContext context, int index) {
//                                Bean0102 item = model.topGoods[index];
//                                return ArticleItemWidget(item);
//                              }
//                          )),
//                      SizedBox(
//                        width: double.infinity,
//                        height: 200,
//                        child: ListView.builder(
//                            itemCount: model.topGoods.length,
//                            itemBuilder: (BuildContext context, int index) {
//                              Bean0102 item = model.topGoods[index];
//                              return GoodsItemWidget(item);
//                            }
//                        ),),
//                      SizedBox(
//                        width: double.infinity,
//                        height: 200,
//                        child: GridView.builder(
//                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                              crossAxisCount: 2, //每行2列
//                              childAspectRatio: 1.0, //显示区域宽高相等
//                              crossAxisSpacing: 1,
//                              mainAxisSpacing: 1,
//                            ),
//                            itemCount: model.topGoods.length,
//                            itemBuilder: (BuildContext context, int index) {
//                              Bean0102 item = model.topGoods[index];
//                              return GoodsItemWidget(item);
//                            }
//                        ),),
//                        GridView.builder(
//                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                              crossAxisCount: 2, //每行2列
//                              childAspectRatio: 1.0, //显示区域宽高相等
//                              crossAxisSpacing: 1,
//                              mainAxisSpacing: 1,
//                            ),
//                            itemCount: model.topGoods.length,
//                            itemBuilder: (BuildContext context, int index) {
//                              Bean0102 item = model.topGoods[index];
//                              return generateCommonGoodsitem(item);
//                            }
//                        )
                      ],)
                ),
//                SingleChildScrollView(
////                  padding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
//                  child: Column(
//                    //动态创建一个List<Widget>
//                    children: <Widget>[
//                      Container(
//                        margin: const EdgeInsets.symmetric(vertical: 18.0),
//                        child: SizedBox(
//                          height: 250.0,
//                          child: Swiper(
//                            loop: false,
//                            autoplay: true,
//                            autoplayDelay: 5000,
//                            pagination: SwiperPagination(),
//                            itemCount: model.banners.length,
//                            itemBuilder: (ctx, index) {
//                              return CachedNetworkImage(
//                                  imageUrl: model.banners[index].picture,
//                                  placeholder: (context, url) =>
//                                      Center(
//                                          child: CupertinoActivityIndicator()),
//                                  errorWidget: (context, url, error) =>
//                                      Icon(Icons.error),
//                                  fit: BoxFit.fill);
//                            },
//                          ),
//                        ),
//                      ),
//                      Flex(
//                        direction: Axis.horizontal,
//                        children: <Widget>[
//                          Expanded(
//                            flex: 1,
//                            child: generateTitleArea(
//                                ImageHelper.wrapAssets("home_hot.png"), "热卖"),
//                          ),
//                          Expanded(
//                            flex: 1,
//                            child: generateTitleArea(
//                                ImageHelper.wrapAssets("home_newer.png"), "新品"),
//                          ),
//                          Expanded(
//                            flex: 1,
//                            child: generateTitleArea(
//                                ImageHelper.wrapAssets("home_promotion.png"),
//                                "促销"),
//                          ),
//                          Expanded(
//                            flex: 1,
//                            child: generateTitleArea(
//                                ImageHelper.wrapAssets("home_recommend.png"),
//                                "推荐"),
//                          ),
//                        ],
//                      ),
//                      Container(width: double.infinity,
//                        height: 5,
//                        color: Color(0xFFF4F4F4),
//                        margin: EdgeInsets.symmetric(vertical: 5.0),),
//                      SizedBox(
//                          width: double.infinity,
//                          height: 200,
//                          child: ListView.builder(
//                              itemCount: model.topGoods.length,
//                              itemBuilder: (BuildContext context, int index) {
//                                Bean0102 item = model.topGoods[index];
//                                return ArticleItemWidget(item);
//                              }
//                          )),
//                    ],
//                  ),
//                ),
                LoginPage(),
                StructurePage(),
                Text("4"),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), title: Text('首页')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.business), title: Text('商品')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.shopping_cart), title: Text('购物车')),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), title: Text('我的')),
              ],
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.grey,
              selectedItemColor: Colors.green,
              onTap: _onItemTapped,
            ),
          );
        });
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }

  Widget generateTitleArea(String url, String title) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(
              vertical: 12.0),
          child: ClipOval(
            child: Image.asset(
              url,
              width: 40,
            ),
          ),
        ),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  Widget generateCommonGoodsitem(Bean0102 goods) {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20.0, top: 4, bottom: 4, right: 10),
          //容器外填充
          constraints: BoxConstraints.tightFor(width: 80.0, height: 40.0),
          //卡片大小
          decoration: BoxDecoration( //背景装饰
              borderRadius: new BorderRadius.circular((2.0)), // 圆角度
              border: new Border.all(color: Color(0xFFFFFF00), width: 0.5)
          ),
          alignment: Alignment.centerLeft,
          //卡片内文字居中
          child: Text( //卡片文字
              "满减"),
        ),
        Center(
          child: Padding(padding: EdgeInsets.all(20),
            child: WrapperImage(
              url: goods.cThumPicture,
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.contain,
            ),),
        ),
        Text(goods.cInvName, //字符串重复六次
          textAlign: TextAlign.center,
          textScaleFactor: 2,
        ),
        Text.rich(TextSpan(
            children: [
              TextSpan(
                  text: "特价: ",
                  style: TextStyle(
                      color: Colors.red
                  )
              ),
              TextSpan(
                text: "￥" + goods.iPrice,
              ),
            ]
        )),
      ],
    );
  }

//  List<Widget> _generateItem(BuildContext context, List<PageInfo> children) {
//    return children.map<Widget>((page) {
//      return ListTile(
//        title: Text(page.title),
//        trailing: Icon(Icons.keyboard_arrow_right),
//        onTap: () => _openPage(context, page),
//      );
//    }).toList();
//  }
}

class GoodsItemWidget extends StatelessWidget {

  final Bean0102 goods;

  const GoodsItemWidget(this.goods, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(child: Column(
      children: <Widget>[
        SizedBox(height: 4,),
        Container(
          //容器外填充
          constraints: BoxConstraints.tightFor(width: 80.0, height: 32.0),
          //卡片大小
          decoration: BoxDecoration( //背景装饰
            borderRadius: new BorderRadius.circular((4.0)), // 圆角度
            border: new Border.all(color: Color(0xFFFF0000), width: 0.5),
          ),
          alignment: Alignment.center,
          //卡片内文字居中
          child: Text( //卡片文字
              "满减"),
        ),
        Center(
          child: Padding(padding: EdgeInsets.all(10),
            child: WrapperImage(
              url: goods.cThumPicture,
              height: 80,
              width: double.infinity,
              fit: BoxFit.contain,
            ),),
        ),
        Text(goods.cInvName, //字符串重复六次
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textScaleFactor: 1,
        ),
        Text.rich(TextSpan(
            children: [
              TextSpan(
                  text: "特价: ",
                  style: TextStyle(
                      color: Colors.red
                  )
              ),
              TextSpan(
                text: "￥" + goods.iPrice,
              ),
            ]
        )),
      ],
    ), onTap:
        () => showToast("商品被点击了"),);
  }
}