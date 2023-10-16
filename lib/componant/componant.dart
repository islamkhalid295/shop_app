

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/cubit/app_cubit.dart';
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
          style: const TextStyle(color: Colors.white),
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

Widget buildListItem(model, context, {bool isSearch = false}) => Padding(
      padding: const EdgeInsets.all(12),
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Image(
                image: NetworkImage(model.image),
                height: 100,
                width: 100,
              ),
              if(!isSearch)
                if (model.discount != 0)
                Container(
                  width: 80,
                  color: Colors.red,
                  child: const Center(child: Text('DISCOUNT')),
                )
            ],
          ),
          const SizedBox(
            width: 15,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.name,
                  maxLines: 2,
                  style: const TextStyle(overflow: TextOverflow.ellipsis),
                ),
                const SizedBox(height: 15,),
                Row(
                  children: [
                    Text(
                      '${model.price}',
                      style: const TextStyle(
                          color: Colors.orange,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    if(!isSearch)
                    if (model.discount != 0)
                      Text(
                        '${model.old_price}',
                        style: const TextStyle(
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey,
                            fontSize: 15),
                      ),
                    const Spacer(),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: AppCubit.get(context).inFavorite[model.id]! ? defaultColor[200] : Colors.grey[200],
                      child: IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: (){
                          AppCubit.get(context).changeFavorite(model.id);
                        },
                        iconSize: 15,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
