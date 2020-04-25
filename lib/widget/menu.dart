import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../favorite_page.dart';

class Menu extends StatelessWidget {
  Menu({this.accessFavorite, this.webViewController});
  final Future<WebViewController> webViewController;
  final Function accessFavorite;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: webViewController,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (!controller.hasData) {
          return Container();
        }
        // otherwise return popup
        return PopupMenuButton<String>(
          itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
            const PopupMenuItem<String>(
              child: Text('Email link'),
              value: 'Email link',
            ),
            const PopupMenuItem(
              child: Text('see favorites'),
              value: 'See Favorites',
            ),
          ],
          onSelected: (String value) async {
            if (value == 'Email link') {
              String url = await controller.data.currentUrl();
              await launch(
                  'mailto:sandeepduttacse45@gmail.com?subject=Check out the cool wikipedia page&body=$url');
            } else {
              String newUrl = await Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return FavoritePage(favorites: accessFavorite());
              }));
              Scaffold.of(context).removeCurrentSnackBar();
              if (newUrl != null) controller.data.loadUrl(newUrl);
            }
          },
        );
      },
    );
  }
}
