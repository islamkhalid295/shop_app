import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/app_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/network/remote/dio_helper.dart';
import 'package:shop_app/network/remote/end_points.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var loginModel = AppCubit.get(context).loginModel;
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var formKey = GlobalKey<FormState>();
        var nameController = TextEditingController(
            text: loginModel?.data?.name);
        var emailController = TextEditingController(
            text: loginModel?.data?.email);
        var phoneController = TextEditingController(
            text: loginModel?.data?.phone);
        return ConditionalBuilderRec(
          condition: AppCubit.get(context).loginModel != null,
          fallback: (context) => Center(
              child: CircularProgressIndicator(
                color: Colors.orange.shade300,
              )),
          builder: (context) => Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'name can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'name',
                      labelStyle: TextStyle(color: Colors.orange.shade300),
                      icon: const Icon(
                        Icons.person,
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Email can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(color: Colors.orange.shade300),
                      icon: const Icon(
                        Icons.email_outlined,
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orange.shade300),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'phone can\'t be empty';
                      } else {
                        return null;
                      }
                    },
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: TextStyle(color: Colors.orange.shade300),
                      icon: const Icon(
                        Icons.phone,
                      ),
                      border: const OutlineInputBorder(),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.orangeAccent),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: ConditionalBuilderRec(
                      condition: AppCubit.get(context).loginModel != null,
                      builder: (context) => MaterialButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            DioHelper.putData(
                                UPDATE_PROFILE,
                                {
                                  "name": nameController.text,
                                  "phone": phoneController.text,
                                  "email": emailController.text,
                                },
                                token: token).then((value) {
                              toast('تم التعديل بنجاح', Colors.green);
                              AppCubit.get(context).getProfile();
                            }).catchError((error){
                              toast(error.toString(), Colors.red);

                            });
                          }
                        },
                        color: Colors.orange.shade300,
                        child: const Text('UPDATE',
                            style:
                            TextStyle(color: Colors.white, fontSize: 20)),
                      ),
                      fallback: (context) => Center(
                          child: CircularProgressIndicator(
                            color: Colors.orange.shade300,
                          )),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () {
                        AppCubit.get(context).logOut(context);
                      },
                      color: Colors.orange.shade300,
                      child: const Text('LOGOUT',
                          style:
                          TextStyle(color: Colors.white, fontSize: 20)),
                    )
                    ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
