// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screan.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


class NewsCubit extends Cubit<NewsStates>{
  NewsCubit():super(NewsInitialState());
  static NewsCubit get(BuildContext context)=>BlocProvider.of(context);
int currentIndex=0;
List<Widget> screens=[
  BusinessScreen(),
  SportsScreen(),
  ScienceScreen(),
];
List<BottomNavigationBarItem> bottomItems =[
  BottomNavigationBarItem(
    icon: Icon(Icons.business,),
    label: 'Business',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.sports_martial_arts,),
    label: 'Sports',
  ),
  BottomNavigationBarItem(
    icon: Icon(Icons.science,),
    label: 'Science',
  ),
];

void changeBottomNavigationBar(int index){
currentIndex=index;
emit(NewsBottomNavState());
}
String apiKey='498af28f8af946e6b204c6c806e8cfcb';
  List<dynamic> business=[];
void getBusiness(){
  emit(NewsGetBusinessLoadingState());
  DioHelper.getData(
    urlPath:"v2/top-headlines" ,
    query: {
      'country':'eg',
      'category':'business',
      'apiKey':apiKey,
    },
  ).then((value) {
    business=value.data["articles"];
    print(business[0]["title"]);
    emit(NewsGetBusinessSuccessState());
  }).catchError((er){
    print(er.toString());
    emit(NewsGetBusinessErrorState(er.toString()));

  });


}
 List<dynamic> sports=[];
void getSports(){
  emit(NewsGetSportsLoadingState());
  DioHelper.getData(
      urlPath: 'v2/top-headlines',
      query:  {
        'country':'eg',
        'category':'sports',
        'apiKey':apiKey,
      },
  ).then((value){
    sports=value.data["articles"];
    emit(NewsGetSportsSuccessState());
  }).catchError((error){
    emit(NewsGetSportsErrorState(error));
  });
}
List<dynamic> science=[];
void getScience(){
  emit(NewsGetScienceLoadingState());
  DioHelper.getData(
    urlPath: 'v2/top-headlines',
    query:  {
      'country':'eg',
      'category':'science',
      'apiKey':apiKey,
    },
  ).then((value){
    science=value.data["articles"];
    emit(NewsGetScienceSuccessState());
  }).catchError((error){
    emit(NewsGetScienceErrorState(error));
  });
}
List<dynamic> search=[];
void getSearch(String value){
  DioHelper.getData(
      urlPath: "v2/everything",
      query: {
        'q':value,
        'apiKey':apiKey,
  }).then((value){
    search=value.data["articles"];
    emit(NewsGetSearchSuccessState());
  }).catchError((error){
    emit(NewsGetSearchErrorState(error));
  });

}


  bool isDark=false;
  void changeMode({
   bool? fromCache,
})  {
    WidgetsFlutterBinding.ensureInitialized();
    if(fromCache!=null){
      isDark=fromCache;
      emit(NewsChangeModeState());
    }
    else{
      isDark=!isDark;
      CacheHelper.setBoolData(key:'isDark', value: isDark).then((value){
        emit(NewsChangeModeState());
          Future.delayed(Duration(milliseconds:300,),(){
      emit(Refresh());
      },);
      });
    }




  }


}