import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';

class Search extends StatelessWidget {
  const Search({super.key});

  //TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          //title: Text("البحث"),
          elevation: 0,
          backgroundColor: defaultColor[100],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: const InputDecoration(
                    hintText: "ابحث عن طريق ادخال اسم المنتج",
                    label: Text("Search"),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "enter any text";
                    }
                    return null;
                  },
                  //controller: searchController,
                  onFieldSubmitted: (value) {
                    AppCubit.get(context).search(value);
                  },
                ),
              ),
              BlocConsumer<AppCubit, AppStates>(
                listener: (context, state) {},
                builder: (context, state) {
                   var model = AppCubit.get(context).searchModel;
                  return Expanded(
                    child: ConditionalBuilderRec(
                      condition: model != null && state is! SearchLodingState,
                      builder: (context) => ListView.separated(
                        itemBuilder: (context, index) => buildListItem(model.data!.data?[index],context,isSearch: true),
                        separatorBuilder:(context, index) => myDivider(),
                        itemCount: model!.data!.data!.length,
                      ),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
