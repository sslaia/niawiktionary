import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:niaswiktionary/wiki_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(EasyLocalization(
      child: const NiasWiki(),
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations'));
}

class NiasWiki extends StatelessWidget {
  const NiasWiki({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const WikiHome(),
    );
  }
}
