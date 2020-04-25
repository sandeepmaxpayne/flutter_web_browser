import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'url';

class Menu extends StatelessWidget {
  Menu({this.accessFavorite, this.webViewController});
  final Future<WebViewController> webViewController;
  final Future accessFavorite;

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
          itemBuilder: ,
          onSelected: (String value) async{
            String url = await controller.data.currentUrl();
            await launch()
          },
        );
      },
    );
  }
}
