import 'package:conditional_builder_rec/conditional_builder_rec.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/componant/componant.dart';
import 'package:shop_app/cubit/login_cubit.dart';
import 'package:shop_app/cubit/states.dart';
import 'package:shop_app/modules/shop_register.dart';

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
                      const Text(
                        "Login",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Password can\'t be empty';
                          } else {
                            return null;
                          }
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
                          icon: const Icon(
                            Icons.password_rounded,
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
                            child: const Text('Login',
                                style: TextStyle(color: Colors.white, fontSize: 20)),
                          ),
                          fallback: (context) => Center(child: CircularProgressIndicator(color: Colors.orange.shade300,)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          const Text('Don\'t have account?'),
                          TextButton(onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder:(context) =>  const ShopRegisterScreen()));
                          }, child: Text('Register',style: TextStyle(color: defaultColor[200]),),)
                        ],
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
