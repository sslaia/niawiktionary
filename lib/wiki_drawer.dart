import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WikiDrawer extends StatelessWidget {
  WikiDrawer({
    Key? key,
    required Completer<WebViewController> controller,
  })  : _controller = controller,
        super(key: key);

  final Completer<WebViewController> _controller;
  final color = Colors.orange[50];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> controller) {
          if (controller.hasData) {
            return Container(
              color: color,
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      // color: Colors.white70,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/images/niawt_background.webp'),
                      ),
                    ),
                    child: Stack(children: [
                      Positioned(
                        bottom: 12.0,
                        left: 12.0,
                        child: Text(
                          'Nias Wiktionary',
                          style: GoogleFonts.cinzelDecorative(
                            textStyle: const TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                  ListTile(
                    leading: const Icon(Icons.home_outlined),
                    title: const Text('home').tr(),
                    onTap: () {
                      Navigator.pop(context);
                      controller.data!
                          .loadUrl('https://nia.m.wiktionary.org/wiki/Olayama');
                    },
                  ),
                  ListTile(
                      leading: const Icon(Icons.local_fire_department_outlined),
                      title: const Text("recent_changes").tr(),
                      onTap: () {
                        Navigator.pop(context);
                        controller.data!.loadUrl(
                            'https://nia.m.wiktionary.org/wiki/Special:RecentChanges');
                      }),
                  ListTile(
                      leading: const Icon(Icons.security_outlined),
                      title: const Text("special_pages").tr(),
                      onTap: () {
                        Navigator.pop(context);
                        controller.data!.loadUrl(
                            'https://nia.m.wiktionary.org/wiki/Special:SpecialPages');
                      }),
                  ListTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('announcement').tr(),
                    onTap: () {
                      Navigator.pop(context);
                      controller.data!.loadUrl(
                          'https://nia.m.wiktionary.org/wiki/Wiktionary:Angombakhata');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.meeting_room_outlined),
                    title: const Text('community_portal').tr(),
                    onTap: () {
                      Navigator.pop(context);
                      controller.data!.loadUrl(
                          'https://nia.m.wiktionary.org/wiki/Wiktionary:Bawagöli_zato');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.bubble_chart_outlined),
                    title: const Text('village_pump').tr(),
                    onTap: () {
                      Navigator.pop(context);
                      controller.data!.loadUrl(
                          'https://nia.m.wiktionary.org/wiki/Wiktionary:Monganga_afo');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.gesture_outlined),
                    title: const Text('sandbox').tr(),
                    onTap: () {
                      Navigator.pop(context);
                      controller.data!.loadUrl(
                          'https://nia.m.wiktionary.org/wiki/Wiktionary:Nahia_wamakori');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.handyman_outlined),
                    title: const Text('help').tr(),
                    onTap: () {
                      Navigator.pop(context);
                      controller.data!.loadUrl(
                          'https://nia.m.wiktionary.org/wiki/Wiktionary:Fanolo');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.people_outlined),
                    title: const Text('helpers').tr(),
                    onTap: () {
                      Navigator.pop(context);
                      controller.data!.loadUrl(
                          'https://nia.m.wiktionary.org/wiki/Wiktionary:Sangai_halöŵö');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.local_florist_outlined),
                    title: const Text('about').tr(),
                    onTap: () {
                      Navigator.pop(context);
                      controller.data!.loadUrl(
                          'https://nia.m.wiktionary.org/wiki/Wiktionary:Sanandrösa');
                    },
                  ),
                ],
              ),
            );
          }
          return Container(
            child: const Text('Empty'),
          );
        },
      ),
    );
  }
}
