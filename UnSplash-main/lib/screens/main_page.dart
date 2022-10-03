// import 'package:flutter/material.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:provider/provider.dart';
// import 'package:unsplash_photos/presentation/screens/favorite_page.dart';
// import 'package:unsplash_photos/presentation/screens/home_page.dart';
// import 'package:unsplash_photos/presentation/widgets/bottom_nav_bar.dart';
// import 'package:unsplash_photos/utils/my_state.dart';
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await FlutterDownloader.initialize(debug: false);
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   PageController controller = PageController();
//
//   @override
//   void dispose() {
//     controller.dispose();
//     super.dispose();
//   }
//
//   List<Widget> pages = [
//     const HomePage(),
//     const FavoritePage(),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => ThemeState()),
//         ChangeNotifierProvider(create: (context) => PageState())
//       ],
//       builder: (context, _) {
//         final themeState = Provider.of<ThemeState>(context);
//         final pageState = Provider.of<PageState>(context);
//         themeState.getTheme();
//         return MaterialApp(
//           debugShowCheckedModeBanner: false,
//           // this will prevent app from closing on
//           // pressing back button unless we are on homepage
//           home: WillPopScope(
//             onWillPop: () async {
//               if (pageState.currentPage != 0) {
//                 pageState.changePage(0);
//                 controller.jumpTo(0);
//                 return false;
//               } else {
//                 return true;
//               }
//             },
//             child: Scaffold(
//               body: PageView(
//                 physics: const BouncingScrollPhysics(),
//                 controller: controller,
//                 children: pages,
//                 onPageChanged: (index) {
//                   pageState.changePage(index);
//                 },
//               ),
//               bottomNavigationBar: BottomNavBar(pageController: controller),
//             ),
//           ),
//           themeMode: themeState.currentThemeMode,
//           theme: ThemeData(
//             scaffoldBackgroundColor: Colors.white,
//             canvasColor: Colors.white,
//             primaryColor: Colors.white,
//             colorScheme: const ColorScheme.light(),
//           ),
//           darkTheme: themeState.getDarkTheme(),
//         );
//       },
//     );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../business_logic/Cubit/bottom_nav_cubit.dart';



class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BottomNavCubit(),
      child: BlocConsumer<BottomNavCubit, BottomNavState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = BottomNavCubit.get(context);
          return Scaffold(
            body: cubit.bottomScreens[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottom(index);
              },
              items: cubit.bottomItem,
            ),
          );
        },
      ),
    );
  }
}
