// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors, prefer_const_constructors_in_immutables

import 'dart:io';

import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/foundation.dart';
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
import 'package:news_app/shared/styles/theme.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async {
  //بيتاكد ان كل حاجه هنا في المبثود خلصت بعدين بيرن الابلكيشن
   WidgetsFlutterBinding.ensureInitialized();
   ResponsiveSizingConfig.instance.setCustomBreakpoints(
     ScreenBreakpoints(desktop: 800, tablet: 550, watch: 200),
   );
  Bloc.observer = MyBlocObserver();
 DioHelper.init();
  await CacheHelper.init();

  if(Platform.isWindows) {
    await DesktopWindow.setMinWindowSize(
        Size(450, 650),
    );
  }


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
            theme: lightMode,
            darkTheme: darkMode,
            themeMode:(NewsCubit.get(context).isDark)?ThemeMode.dark:ThemeMode.light,
           /* builder: (context, child) => ResponsiveWrapper
                .builder(
                child,
                maxWidth: 1200,
                minWidth: 480,
                defaultScale: true,
                breakpoints: [
                  ResponsiveBreakpoint.resize(480, name: MOBILE),
                  ResponsiveBreakpoint.autoScale(800, name: TABLET),
                  ResponsiveBreakpoint.resize(1000, name: DESKTOP),
                ],
                background: Container(color: Color(0xFFF5F5F5))),
            initialRoute: "/",
*/
            home:NewsLayout(),

          );
        },
      ),
    );

  }

}