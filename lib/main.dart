// import 'package:assingmentapp/pages/home_page.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }

import 'package:assingmentapp/bloc/cart_bloc.dart';
import 'package:assingmentapp/bloc/product_bloc.dart';
import 'package:assingmentapp/widget/bottom_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProductBloc()..add(FetchProducts())),
        BlocProvider(create: (_) => CartBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: BottomBarWidget(),
      ),
    );
  }
}
