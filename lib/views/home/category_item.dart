import 'package:flutter/material.dart';
import 'package:iota/models/category.dart';
import 'package:iota/utils/text_style.dart';

import '../../utils/common_colors.dart';

class CategoryItemGrid extends StatelessWidget {
  CategoryModel categoryModel;


  CategoryItemGrid(this.categoryModel);

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      onTap: () {

      },
      child: new Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: CommonColors.borderColor, blurRadius: 8.0)
          ],
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: new Center(
          child: new Wrap(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 70,
                    width: 70,
                    child: new Image.asset(
                      categoryModel.icon,
                      fit: BoxFit.fill,
                    ),
                  ),
                  /// Set Animation image to detailProduk layout
                  Padding(padding: EdgeInsets.only(top: 7.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 4.0, right: 4.0),
                    child: new Container(
                      margin: EdgeInsets.only(left: 4,right: 4),
                      child: new Text(
                        categoryModel.title,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: CommonStyle.getAppFont(
                            fontSize: 15,
                            color: Colors.black,
                            fontStyle: FontStyle.normal,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 1.0)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}