import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/models/favorites_model.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AppCubit cubit = AppCubit.get(context);
    cubit.getFavoriteData();
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          FavoriteModel? model = AppCubit.favoriteModel;
          return ConditionalBuilderRec(
            condition: model != null,
            fallback: (context) => const Center(child: CircularProgressIndicator()),
            builder: (context) => ListView.separated(
              itemBuilder: (context, index) => buildListItem(model.data.data[index],context),
              separatorBuilder:(context, index) => myDivider(),
              itemCount: model!.data.data.length,
            ),
          );
        });
  }
}
