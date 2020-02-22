import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:iota/database/app_preferences.dart';
import 'package:iota/utils/constant.dart';
import 'package:iota/utils/text_style.dart';
import 'package:iota/views/home/notification_item.dart';
import 'package:provider/provider.dart';
import 'package:transformer_page_view/transformer_page_view.dart';

import '../../utils/common_colors.dart';
import '../../utils/common_colors.dart';
import '../../utils/local_images.dart';
import 'home_item.dart';
import 'home_view_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeView> {
  int currentIndex = 0;
  bool isExpanded = false;
  ScrollController _controller;
  bool silverCollapsed = false;

  IndexController controller = IndexController();

  List<String> titleList = [
    "Malaika Shen",
    "Api Karim",
    "Beder Meye",
    "Marjukh Rasel",
    "Hero Alam"
  ];
  List<String> iconList = [
    LocalImages.ic_user,
    LocalImages.ic_user_2,
    LocalImages.ic_user_3,
    LocalImages.ic_user_4,
    LocalImages.ic_user_5,
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = ScrollController();

    _controller.addListener(() {
      if (_controller.offset > 100 && !_controller.position.outOfRange) {
        if (!silverCollapsed) {
          silverCollapsed = true;
        }
        Provider.of<HomeViewModel>(context).notifyListeners();
        print("Collapsed");
      }
      if (_controller.offset <= 100 && !_controller.position.outOfRange) {
        if (silverCollapsed) {
          silverCollapsed = false;
        }
        Provider.of<HomeViewModel>(context).notifyListeners();
        print("Expanded");
      }
    });

    Future.delayed(Duration.zero, () {
      AppPreferences().setLanguageCode(AppConstants.LANGUAGE_SPANISH);
      Provider.of<HomeViewModel>(context).addNoificationList();
      Provider.of<HomeViewModel>(context).addCategoryList();
    });
  }

  void redirectToHome() {
    /*Navigator.of(context).pushReplacement(
      MaterialPageRoute(
          builder: (BuildContext context) =>
          new LoginView()));*/
  }

  @override
  Widget build(BuildContext context) {
    final mViewModel = Provider.of<HomeViewModel>(context);

    final notificationList = Container(
      padding: EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15), bottomRight: Radius.circular(15)),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                Text(
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
                Container(
                  margin: EdgeInsets.only(bottom: 4, left: 12, right: 12),
                  child: Divider(
                    color: Color(0xFF4150B5),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 30, top: 30),
            child: ListView.builder(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: mViewModel.notificationList.length,
                padding: const EdgeInsets.all(5.0),
                itemBuilder: (context, position) {
                  return NotificationItemView(
                      mViewModel.notificationList[position]);
                }),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: FlatButton(
              onPressed: () {
                isExpanded = !isExpanded;
                mViewModel.notifyListeners();
              },
              color: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(7)),
              ),
              textColor: Color.fromARGB(255, 255, 255, 255),
              padding: EdgeInsets.all(0),
              child: Text(
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
        SliverAppBar(
          expandedHeight: isExpanded ? 400 : 200,
          floating: true,
          pinned: true,
          elevation: 0.0,
          actions: <Widget>[
            silverCollapsed
                ? InkWell(
                    onTap: () {
                      _controller.animateTo(
                        0.0,
                        curve: Curves.easeOut,
                        duration: const Duration(milliseconds: 300),
                      );
                    },
                    child: Container(
                        height: 22,
                        width: 22,
                        margin: EdgeInsets.only(left: 12, right: 12),
                        child: Image.asset(LocalImages.ic_notification_badge)))
                : Container(),
          ],
          backgroundColor: CommonColors.primaryColor,
          flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: silverCollapsed
                  ? Text(
                      "App Name",
                      style: CommonStyle.getAppFont(
                          fontSize: 17,
                          color: Colors.white,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w600),
                    )
                  : Container(),
              background: notificationList),
        ),
      ];
    };

    final btnLeftArrow = Container(
      margin: EdgeInsets.only(bottom: 60, left: 70),
      child: InkWell(
          onTap: () {
            controller.previous();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(LocalImages.ic_left_arrow),
          )),
    );

    final btnRightArrow = Container(
      margin: EdgeInsets.only(bottom: 60, right: 70),
      child: InkWell(
          onTap: () {
            controller.next();
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(LocalImages.ic_right_arrow),
          )),
    );

    final mProfileSlider = Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(LocalImages.ic_profile_background),
              fit: BoxFit.fill)),
      height: 270,
      child: Stack(
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
                                  image: new AssetImage(iconList[index])))),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 20, bottom: 20),
                        child: Text(
                          titleList[index],
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
              itemCount: 5),
          Align(
            alignment: Alignment.bottomLeft,
            child: btnLeftArrow,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: btnRightArrow,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: new DotsIndicator(
                dotsCount: titleList.length,
                position: currentIndex.toDouble(),
                decorator: DotsDecorator(
                  color: Colors.white,
                  activeColor: Color(0xFF5F56D2),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    var grid = Container(
      child: GridView.count(
        padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 20.0),
        shrinkWrap: true,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 17.0,
        childAspectRatio:
            MediaQuery.of(context).size.shortestSide < 600 ? 1.2 : 1.0,
        crossAxisCount: 2,
        primary: false,
        children: List.generate(
          mViewModel.categoryList.length,
          (index) => (CategoryItemGrid(mViewModel.categoryList[index])),
        ),

// List.generate(
// (mViewModel.categoryIsApiLoading)
// ? mViewModel.categoryList.length + 1
// : mViewModel.categoryList.length,
// (index) => (index == mViewModel.categoryList.length)
// ? CommonUtils.getListItemProgressBar()
// : RecommedItemGrid(mViewModel.categoryList[index]),
// )
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      drawer: silverCollapsed ? Drawer() : Container(),
      body: SafeArea(
        child: NestedScrollView(
          controller: _controller,
          headerSliverBuilder: sliverNotification,
          body: SingleChildScrollView(
            child: Column(
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
