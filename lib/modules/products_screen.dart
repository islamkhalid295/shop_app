import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/product_model.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        HomeModel? model = AppCubit.homeModel;
        return ConditionalBuilderRec(
          condition: model != null && AppCubit.categoriesModel != null,
          builder: (context) {
            return SingleChildScrollView(
              child: Container(
                color: Colors.grey[100],
                child: Column(
                  children: [
                    CarouselSlider(
                        items: model?.data.banners
                            .map((e) => Image(
                                  image: NetworkImage('${e.image}'),
                                ))
                            .toList(),
                        options: CarouselOptions(
                            autoPlay: true,
                            enableInfiniteScroll: true,
                            viewportFraction: 1)),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Categories',
                            style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          Container(
                            height: 80,
                            child: ListView.separated(
                              itemBuilder: (context, index) => buildCategoriesItem(AppCubit.categoriesModel!,index),
                              scrollDirection: Axis.horizontal,
                              itemCount: AppCubit.categoriesModel!.data.data.length,
                              separatorBuilder: (context, index) => const SizedBox(width: 10,),

                            ),
                          ),
                          const SizedBox(height: 10,),
                          const Text(
                            'New Products',
                            style: TextStyle(fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          GridView.count(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            padding: const EdgeInsets.all(5),
                            // mainAxisSpacing: ,
                            crossAxisSpacing: 3,
                            mainAxisSpacing: 3,
                            childAspectRatio: 0.55,
                            children:
                            List.generate(model!.data.products.length, (index) {
                              return Container(
                                color: Colors.white,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Stack(
                                        alignment: AlignmentDirectional.bottomEnd,
                                        children: [
                                          Image(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                  model.data.products[index].image),
                                              height: 200),
                                          if (model.data.products[index].discount != 0)
                                            Container(
                                              width: 80,
                                              color: Colors.red,
                                              child: const Center(child: Text('DISCOUNT')),
                                            )
                                        ],
                                      ),
                                      Text(
                                        model.data.products[index].name,
                                        maxLines: 2,
                                        style:
                                        const TextStyle(overflow: TextOverflow.ellipsis),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            '${model.data.products[index].price}',
                                            style: const TextStyle(
                                                color: Colors.orange,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          if (model.data.products[index].discount != 0)
                                            Text(
                                              '${model.data.products[index].old_price}',
                                              style: const TextStyle(
                                                  decoration:
                                                  TextDecoration.lineThrough,
                                                  color: Colors.grey,
                                                  fontSize: 12),
                                            ),
                                          const Spacer(),
                                          CircleAvatar(
                                            radius: 15,
                                            backgroundColor: cubit.inFavorite[model.data.products[index].id]! ? defaultColor[200] : Colors.grey[200],
                                            child: IconButton(
                                              icon: const Icon(Icons.favorite_border),
                                              onPressed: (){
                                                cubit.changeFavorite(model.data.products[index].id);
                                              },
                                              iconSize: 15,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          fallback: (context) => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
