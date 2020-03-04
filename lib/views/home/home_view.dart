import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:iota/database/app_preferences.dart';
import 'package:iota/utils/constant.dart';
import 'package:iota/utils/text_style.dart';
import 'package:iota/views/home/notification_item.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../../utils/common_colors.dart';
import '../../utils/local_images.dart';
import 'category_item.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int currentIndex = 0;
  bool isExpanded = false;
  ScrollController _controller;
  bool silverCollapsed = false;
  IndexController controller = new IndexController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = new ScrollController();
    _controller.addListener(() {
      if (_controller.offset > 100 && !_controller.position.outOfRange) {
        if (!silverCollapsed) {
          silverCollapsed = true;
        }
        setState(() {});
      }
      if (_controller.offset <= 100 && !_controller.position.outOfRange) {
        if (silverCollapsed) {
          silverCollapsed = false;
        }
        setState(() {});
      }
    });

    Future.delayed(Duration.zero, () {
      new AppPreferences().setLanguageCode(AppConstants.LANGUAGE_SPANISH);
      Provider.of<HomeViewModel>(context).addNoificationList();
      Provider.of<HomeViewModel>(context).addCategoryList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<HomeViewModel>(context);
    final notificationList = new Container(
      padding: new EdgeInsets.only(top: 8),
      decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.only(
            bottomLeft: new Radius.circular(15), bottomRight: new Radius.circular(15)),
      ),
      child: new Stack(
        children: <Widget>[
          new Align(
            alignment: Alignment.topCenter,
            child: new Column(
              children: <Widget>[
                new Text(
                  "Notification (" +
                      mViewModel.notificationList.length.toString() +
                      ")",
                  style: CommonStyle.getAppFont(
                    color: CommonColors.primaryColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                  ),
                  textAlign: TextAlign.left,
                ),
                new Container(
                  margin: new EdgeInsets.only(bottom: 4, left: 12, right: 12),
                  child: new Divider(
                    color: new Color(0xFF4150B5),
                  ),
                ),
              ],
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(bottom: 30, top: 30),
            child: new ListView.builder(
                physics: new ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: mViewModel.notificationList.length,
                padding: const EdgeInsets.all(5.0),
                itemBuilder: (context, position) {
                  return NotificationItemView(
                      mViewModel.notificationList[position]);
                }),
          ),
          new Align(
            alignment: Alignment.bottomCenter,
            child: new FlatButton(
              onPressed: () {
                isExpanded = !isExpanded;
                mViewModel.notifyListeners();
              },
              color: Colors.transparent,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.all(new Radius.circular(7)),
              ),
              textColor: new Color.fromARGB(255, 255, 255, 255),
              padding: new EdgeInsets.all(0),
              child: new Text(
                isExpanded ? "See Less" : "See More",
                style: CommonStyle.getAppFont(
                    color: CommonColors.primaryColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    decoration: TextDecoration.underline),
                textAlign: TextAlign.left,
              ),
            ),
          ),
        ],
      ),
    );

    final sliverNotification = (BuildContext context, bool innerBoxIsScrolled) {
      return <Widget>[
        new SliverAppBar(
          expandedHeight: isExpanded ? 400 : 200,
          floating: true,
          pinned: true,
          elevation: 0.0,
          actions: <Widget>[
            silverCollapsed
                ? new InkWell(
                    onTap: () {
                      _controller.animateTo(
                        0.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    child: new Container(
                        height: 30,
                        width: 30,
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: new Center(
                          child: new Stack(
                            children: <Widget>[
                              new Align(
                                  alignment: Alignment.centerRight,
                                  child: new Image.asset(
                                    LocalImages.ic_notification_badge,
                                    height: 22,
                                    width: 22,
                                  )),
                              new Align(
                                alignment: Alignment.centerLeft,
                                child: new Container(
                                  height: 18,
                                  width: 18,
                                  margin: new EdgeInsets.only(bottom: 6),
                                  decoration: new BoxDecoration(
                                      color: Colors.red,
                                      borderRadius:
                                          BorderRadius.circular(24.0)),
                                  child: new Center(
                                    child: new Text(
                                      "3",
                                      textAlign: TextAlign.center,
                                      style: CommonStyle.getAppFont(
                                          fontSize: 10,
                                          color: Colors.white,
                                          fontStyle: FontStyle.normal,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )))
                : new Container(),
          ],
          backgroundColor: CommonColors.primaryColor,
          flexibleSpace: new FlexibleSpaceBar(
              centerTitle: true,
              title: silverCollapsed
                  ? new Text(
                      "App Name",
                      style: CommonStyle.getAppFont(
                          fontSize: 17,
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600),
                    )
                  : new Container(),
              background: notificationList),
        ),
      ];
    };

    final btnLeftArrow = new Container(
      margin: EdgeInsets.only(bottom: 60, left: 70),
      child: new InkWell(
          onTap: () {
            if (currentIndex > 0) {
              currentIndex--;
            } else {
              currentIndex = mViewModel.titleList.length - 1;
            }
            controller.move(currentIndex);
          },
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Image.asset(LocalImages.ic_left_arrow),
          )),
    );

    final btnRightArrow = new Container(
      margin: EdgeInsets.only(bottom: 60, right: 70),
      child: new InkWell(
          onTap: () {
            if (currentIndex < mViewModel.titleList.length - 1) {
              currentIndex++;
            } else {
              currentIndex = 0;
            }
            controller.move(currentIndex);
          },
          child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Image.asset(LocalImages.ic_right_arrow),
          )),
    );

    final mProfileSlider = new Container(
      decoration: new BoxDecoration(
          image: DecorationImage(
              image: AssetImage(LocalImages.ic_profile_background),
              fit: BoxFit.fill)),
      height: 270,
      child: new Stack(
        children: <Widget>[
          new TransformerPageView(
              loop: false,
              controller: controller,
              onPageChanged: (int index) {
                currentIndex = index;
                mViewModel.notifyListeners();
              },
              itemBuilder: (BuildContext context, int index) {
                return new Container(
                  color: Colors.transparent,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      new Container(
                          width: 120.0,
                          height: 120.0,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: new AssetImage(
                                      mViewModel.iconList[index])))),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        child: new Text(
                          mViewModel.titleList[index],
                          textAlign: TextAlign.center,
                          style: CommonStyle.getAppFont(
                              fontSize: 20,
                              color: Colors.white,
                              fontStyle: FontStyle.normal,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: mViewModel.titleList.length),
          new Align(
            alignment: Alignment.bottomLeft,
            child: btnLeftArrow,
          ),
          new Align(
            alignment: Alignment.bottomRight,
            child: btnRightArrow,
          ),
          new Align(
            alignment: Alignment.bottomCenter,
            child: new Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: new DotsIndicator(
                dotsCount: mViewModel.titleList.length,
                position: currentIndex.toDouble(),
                decorator: new DotsDecorator(
                  color: Colors.white,
                  activeColor: new Color(0xFF5F56D2),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    var grid = new Container(
      child: new GridView.count(
        padding: new EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
        shrinkWrap: true,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 17.0,
        childAspectRatio:
            MediaQuery.of(context).size.shortestSide < 600 ? 1.2 : 1.0,
        crossAxisCount: 2,
        primary: false,
        children: new List.generate(
          mViewModel.categoryList.length,
          (index) => (CategoryItemGrid(mViewModel.categoryList[index])),
        ),
      ),
    );

    return new Scaffold(
      backgroundColor: Colors.white,
      drawer: silverCollapsed ? new Drawer() : new Container(),
      body: new SafeArea(
        child: new NestedScrollView(
          controller: _controller,
          headerSliverBuilder: sliverNotification,
          body: new SingleChildScrollView(
            child: new Column(
              children: <Widget>[
                mProfileSlider,
                grid,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
