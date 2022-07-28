import 'package:flutter/material.dart';
import 'package:my_pt/providers/auth_provider.dart';
import 'package:my_pt/providers/exercise_video_data.dart';
import 'package:my_pt/providers/exercises_provider.dart';
import 'package:my_pt/screens/auth_screen.dart';
import 'package:my_pt/screens/exercise_demo_screen.dart';
import 'package:my_pt/screens/exercises_overview.dart';
import 'package:my_pt/widgets/paint.dart';
import 'package:my_pt/widgets/video.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ExercisesProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (context) => ExcerciseVideoData(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (context, authData, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Your Personal Trainer',
            theme: ThemeData(
              snackBarTheme: const SnackBarThemeData(
                backgroundColor: Color.fromRGBO(143, 148, 251, .6),
              ),
              dialogTheme: const DialogTheme(
                backgroundColor: Color.fromRGBO(143, 148, 251, 1),
                elevation: 5,
                titleTextStyle: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold),
              ),
              drawerTheme: const DrawerThemeData(
                backgroundColor: Color.fromRGBO(143, 148, 251, .2),
              ),
              iconTheme:
                  const IconThemeData(color: Color.fromRGBO(143, 148, 251, 1)),
              primaryTextTheme:
                  const TextTheme(bodyLarge: TextStyle(color: Colors.white)),
              textTheme: Theme.of(context).textTheme.apply(
                    fontFamily: 'Raleway',
                    bodyColor: Colors.white,
                  ),
              appBarTheme: const AppBarTheme(
                  color: Color.fromRGBO(143, 148, 251, .2),
                  elevation: 0,
                  titleTextStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 21,
                    fontFamily: 'Raleway',
                  )),
              scaffoldBackgroundColor: const Color.fromRGBO(143, 148, 251, .2),
              backgroundColor: const Color.fromRGBO(143, 148, 251, .2),
              colorScheme: ColorScheme.fromSwatch().copyWith(
                primary: const Color.fromRGBO(143, 148, 251, .2),
                // brightness: Brightness.dark,
                secondary: const Color.fromRGBO(143, 148, 251, .2),
              ),
            ),
            // home: authData.isAuth ? ExersicesOverviewScreen() : AuthScreen(),
            // home: ExersicesOverviewScreen(),
            home: Videoo(),
            // home: MySpecificPage(),
            // home: Painter(),
            routes: {
              ExerciseDemoScreen.routeName: (context) => ExerciseDemoScreen(),
            }),
      ),
    );
  }
}
