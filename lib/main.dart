import 'package:flutter/material.dart';
import './configure_nonweb.dart' if (dart.library.html) './configure_web.dart';

import './services/sheets_api.dart';
import './models/article.dart';
import './interface/screens/home/home.dart';

void main() async {
  configureApp();
  WidgetsFlutterBinding.ensureInitialized();
  await SheetApi.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Article>? _listArticle;

  @override
  void initState() {
    SheetApi.getAllRow().then((value) {
      _listArticle = value;
      setState(() {});
    });

    super.initState();
    // debugPrint("length:" + _listArticle!.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Toyareka Education',
        theme: ThemeData(
          primarySwatch: Colors.grey,
          fontFamily: 'Poppins',
        ),
        home: Home(
          listArticle: _listArticle,
        ));
  }
}
