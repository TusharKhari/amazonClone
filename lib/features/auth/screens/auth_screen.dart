import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textField.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors

enum Auth {
  signin,
  signup,
}

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth-screen';
  AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;

  final _signUpFormKey = GlobalKey<FormState>();
  final _signInFormKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void SignUpUser() {
    authService.SignUpUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text);
  }

  void SignInUser() {
    authService.SignInUser(
        context: context,
        email: _emailController.text,
        password: _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
            ),
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: Text(
                'Crete Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signup)
              Container(
                padding: EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _nameController,
                        hintText: 'Name',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(
                          text: 'Sign Up',
                          onTap: () {
                            if (_signUpFormKey.currentState!.validate()) {
                              SignUpUser();
                            } else {}
                          })
                    ],
                  ),
                ),
              ),
            ListTile(
              tileColor: _auth == Auth.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: Text(
                'Sign-in.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? val) {
                  setState(() {
                    _auth = val!;
                  });
                },
              ),
            ),
            if (_auth == Auth.signin)
              Container(
                padding: EdgeInsets.all(8),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signInFormKey,
                  child: Column(
                    children: [
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomTextField(
                        controller: _passwordController,
                        hintText: 'Password',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CustomButton(text: 'Sign In', onTap: () {
                        if (_signInFormKey.currentState!.validate()) {
                              SignInUser();
                            } else {}
                      })
                    ],
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
