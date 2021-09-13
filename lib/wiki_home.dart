import 'dart:async';
import 'dart:io' as IO;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:niaswiktionary/wiki_drawer.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiHome extends StatefulWidget {

  const WikiHome({Key? key}) : super(key: key);

  @override
  _WikiHomeState createState() => _WikiHomeState();
}

class _WikiHomeState extends State<WikiHome> {
  WebViewController? controller;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  final key = GlobalKey();
  final String title = "Nias Wiktionary";
  final url = 'https://nia.m.wiktionary.org/wiki/';
  final color = Colors.orange[50];

  @override
  void initState() {
    if (IO.Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            backgroundColor: color,
            title: Text(
              title,
              style: GoogleFonts.cinzelDecorative(
                  textStyle: const TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54)),
            ),
            actions: [
              FutureBuilder<WebViewController>(
                future: _controller.future,
                builder: (BuildContext context,
                    AsyncSnapshot<WebViewController> controller) {
                  if (controller.hasData) {
                    return Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.refresh,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            controller.data!.reload();

                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.shuffle_outlined,
                            color: Colors.black54,
                          ),
                          onPressed: () {
                            controller.data!
                                .loadUrl(url + 'Special:Random');
                          },
                        ),
                        PopupMenuButton<int>(
                          color: Colors.white,
                          onSelected: (item) {
                            switch (item) {
                              case 0:
                                setState(() {
                                  context.setLocale(const Locale('en'));
                                });
                                break;
                              case 1:
                                setState(() {
                                  context.setLocale(const Locale('id'));
                                });
                                break;
                              // case 2:
                              //   lang = 'Nias';
                              //   break;
                            }
                          },
                          itemBuilder: (context) => [
                            PopupMenuItem<int>(
                              value: 0,
                              child: ListTile(
                                  leading: const Icon(Icons.language_outlined,
                                      color: Colors.purple),
                                  title: const Text('english').tr()),
                            ),
                            PopupMenuItem<int>(
                              value: 1,
                              child: ListTile(
                                  leading: const Icon(Icons.language_outlined,
                                      color: Colors.indigo),
                                  title: const Text('indonesia').tr()),
                            ),
                            // PopupMenuItem<int>(
                            //   value: 2,
                            //   child: ListTile(
                            //       leading: Icon(Icons.language_outlined,
                            //           color: Colors.orange),
                            //       title: Text('Nias')),
                            // ),
                          ],
                        )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
          drawer: WikiDrawer(
              controller: _controller,
              // color: color,
              // url: url,
              // title: title,
          ),
          body: WebView(
            key: key,
            initialUrl: url + 'Olayama',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.future.then((value) => controller = value);
              _controller.complete(webViewController);
            },
            onPageStarted: (url) {
              Future.delayed(const Duration(milliseconds: 300), () {
                controller?.evaluateJavascript("document.getElementsByTagName('header')[0].style.display='none'");
                controller?.evaluateJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
              });
            },
            onPageFinished: (url) {
              Future.delayed(const Duration(milliseconds: 300), () {
                controller?.evaluateJavascript("document.getElementsByTagName('header')[0].style.display='none'");
                controller?.evaluateJavascript("document.getElementsByTagName('footer')[0].style.display='none'");
              });
            },
          ),
        ),
      // ),
    );
  }
}
