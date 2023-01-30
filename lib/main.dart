// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:news_app/layout/news_app/cubit/cubit.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/layout/news_app/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


void main() async {
  //بيتاكد ان كل حاجه هنا في المبثود خلصت بعدين بيرن الابلكيشن
   WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
 DioHelper.init();
  await CacheHelper.init();
   bool? isDark= CacheHelper.getBoolData(key: 'isDark',);

  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget
{
  final bool? isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (BuildContext context)=>NewsCubit()..getBusiness()..getSports()..getScience()..changeMode(fromCache:isDark),
      child: BlocConsumer<NewsCubit,NewsStates>(
        listener:(context,state){},
        builder: (context,state){

          return  MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch:Colors.deepOrange ,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.white,
                elevation: 0.0,
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                elevation: 20.0,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                backgroundColor: Colors.white,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
                labelMedium: TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                ),

              ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),

            ),
            darkTheme: ThemeData(
              primarySwatch: Colors.deepOrange,
              scaffoldBackgroundColor: HexColor('333739'),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                color: HexColor('333739'),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                backgroundColor: HexColor('333739'),
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
              ),
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                ),
                labelMedium: TextStyle(
                  color: Colors.white,
                  fontSize: 13.0,
                ),
              ),
              iconTheme: IconThemeData(
                color: Colors.white,
              ),
            ),
            themeMode:(NewsCubit.get(context).isDark)?ThemeMode.dark:ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );

  }

}