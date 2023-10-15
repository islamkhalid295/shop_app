import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = AppCubit.categoriesModel;
        return ConditionalBuilderRec(
          condition: model != null,
          fallback: (context) => Center(child: CircularProgressIndicator()),
          builder: (context) => ListView.separated(
            separatorBuilder:(context, index) => myDivider(),
            itemCount: model!.data.data.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Image(image: NetworkImage(model!.data.data[index].image),
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10,),
                  Text(model!.data.data[index].name,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                  Spacer(),
                  IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward_ios)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
