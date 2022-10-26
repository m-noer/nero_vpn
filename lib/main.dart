import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nero_vpn/vpn_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF3197FE),
        useMaterial3: true,
      ),
      builder: (context, widget) {
        return AnnotatedRegion(
          value: SystemUiOverlayStyle(
            systemNavigationBarColor: Theme.of(context).cardColor,
            systemNavigationBarDividerColor: Colors.transparent,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          child: Scaffold(
            body: widget,
          ),
        );
      },
      home: const VpnPage(),
    );
  }
}
