import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/cubit/login_cubit.dart';
import 'package:shop_app/cubit/states.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  IconData eyeIcon = Icons.visibility;
  bool showPassword = false;
  var formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(InitState()),
      child: BlocConsumer<LoginCubit,AppStates>(
        listener: (context, state) {},
        builder: (context, state) {

          return Scaffold(
            appBar: AppBar(backgroundColor: (Colors.orange.shade300)),
            body: Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Email can\'t be empty';
                          else
                            return null;
                        },
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.orange.shade300),
                          icon: Icon(
                            Icons.email_outlined,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orange.shade300),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value!.isEmpty)
                            return 'Password can\'t be empty';
                          else
                            return null;
                        },
                        controller: passwordController,
                        obscureText: !showPassword,
                        onFieldSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            LoginCubit.get(context).login(
                                emailController.text,
                                passwordController.text,
                                context,
                            );
                          }
                        },
                        decoration: InputDecoration(
                          suffixIcon: IconButton(
                              icon: Icon(eyeIcon),
                              onPressed: () {
                                setState(() {
                                  showPassword
                                      ? eyeIcon = Icons.visibility
                                      : eyeIcon = Icons.visibility_off;
                                  showPassword = !showPassword;
                                });
                              }),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.orange.shade300),
                          icon: Icon(
                            Icons.password_rounded,
                          ),
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.orangeAccent),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        width: double.infinity,
                        child: ConditionalBuilderRec(
                          condition: state is! LodingState,
                          builder: (context) => MaterialButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                LoginCubit.get(context).login(
                                    emailController.text,
                                    passwordController.text,context);
                              }
                            },
                            color: Colors.orange.shade300,
                            child: Text('Login',
                                style: TextStyle(color: Colors.white, fontSize: 20)),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.orange.shade300,)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
