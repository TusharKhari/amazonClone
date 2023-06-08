import 'package:amazon/common/widgets/bottom_bar.dart';
import 'package:amazon/constants/global_variable.dart';
import 'package:amazon/features/admin/screens/admin_screen.dart';
import 'package:amazon/features/auth/screens/auth_screen.dart';
import 'package:amazon/features/auth/services/auth_service.dart';
import 'package:amazon/providers/functions_provider.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:amazon/router.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";
// ignore: slash_for_doc_comments
// charts have error


//// ignore_for_file: prefer_const_literals_to_create_immutables,prefer_const_constructors_in_immutables, camel_case_types,prefer_const_constructors
void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(create: (_) => FunctionProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //AuthScreen _authScreen = AuthScreen();
  final AuthService authService = AuthService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authService.getUserData(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      title: 'Amazon ',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVariables.secondaryColor,
          
        )
        ,
        appBarTheme:const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          )
          ,
        )
        ,
       // useMaterial3: true, // optional
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home:
          //
          Provider.of<UserProvider>(context).user.token.isNotEmpty
              ?
              //
              Provider.of<UserProvider>(context).user.type == "user"
                  ?
                  //  HomeScreen()
                  BottomBar()
                  //
                  :
                  //
                  AdminScreen()
              :
              //
              AuthScreen(),
    );
  }
}
