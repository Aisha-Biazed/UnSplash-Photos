import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import '../../screens/favorite_page.dart';
import '../../screens/home_page.dart';

part 'bottom_nav_state.dart';

class BottomNavCubit extends Cubit<BottomNavState> {
  BottomNavCubit() : super(BottomNavInitial());


  static BottomNavCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItem = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.home_outlined,
      ),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite_outline,
      ),
      label: 'Favorites',
    ),
  ];

  List<Widget> bottomScreens = const [
    HomePage(),
    FavoritePage(),
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(BottomNavBarState());
  }
}
