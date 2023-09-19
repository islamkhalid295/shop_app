import 'package:flutter/material.dart';

class ShopLoginScreen extends StatefulWidget {
  const ShopLoginScreen({super.key});

  @override
  State<ShopLoginScreen> createState() => _ShopLoginScreenState();
}

class _ShopLoginScreenState extends State<ShopLoginScreen> {
  IconData eyeIcon = Icons.visibility;
  bool showPassword = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: (Colors.orange.shade200)),
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
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.orange.shade200),
                    icon: Icon(
                      Icons.email_outlined,
                    ),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange.shade200),
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
                  obscureText: !showPassword,
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
                    labelStyle: TextStyle(color: Colors.orange.shade200),
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
                  child: MaterialButton(
                      onPressed: () {
                    formKey.currentState?.validate();
                  },
                    color: Colors.orange.shade200,
                    child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 20)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
