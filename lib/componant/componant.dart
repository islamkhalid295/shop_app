import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/models/categories_model.dart';

void toast(String messange, Color color) {
  Fluttertoast.showToast(
      msg: messange,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0);
}

String? token;

Widget buildCategoriesItem(CategoriesModel model, int index) {
  return Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
        width: 80,
        height: 80,
        image: NetworkImage(model.data.data[index].image),
      ),
      Container(
        width: 80,
        color: Colors.black.withOpacity(0.6),
        child: Text(
          model.data.data[index].name,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white),
        ),
      ),
    ],
  );
}

Widget myDivider() => Container(
      width: double.infinity,
      height: 1.0,
      color: Colors.grey,
    );

MaterialColor defaultColor = Colors.orange;

Widget buildFavoriteItem(model, int index) => Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Stack(
            children: [
              Image(
                fit: BoxFit.cover,
                image: NetworkImage(model.data.data[index].image),
                height: 100,
                width: 100,
              ),
              if (model.data.data[index].discount != 0)
                Container(
                  width: 80,
                  color: Colors.red,
                  child: Center(child: Text('DISCOUNT')),
                )
            ],
            alignment: AlignmentDirectional.bottomEnd,
          ),
          SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.data.data[index].name,
                  maxLines: 2,
                  style: TextStyle(overflow: TextOverflow.ellipsis),
                ),
                SizedBox(height: 15,),
                Row(
                  children: [
                    Text(
                      '${model.data.data[index].price}',
                      style: TextStyle(
                          color: Colors.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    if (model.data.data[index].discount != 0)
                      Text(
                        '${model.data.data[index].old_price}',
                        style: TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 15),
                      ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
