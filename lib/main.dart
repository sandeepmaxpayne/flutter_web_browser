import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MaterialApp(
      home: Browser(),
    ));

class Browser extends StatefulWidget {
  @override
  _BrowserState createState() => _BrowserState();
}

class _BrowserState extends State<Browser> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  final Set<String> _favorite = Set<String>();

  dynamic _bookmarkButton() {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> controller) {
        if (controller.hasData) {
          return FloatingActionButton(
            onPressed: () async {
              var url = await controller.data.currentUrl();
              _favorite.add(url);
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text('Saved $url in favorites'),
                ),
              );
            },
            child: Icon(Icons.favorite),
          );
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wiki Explorer'),
        actions: <Widget>[
          //  NavigationControls(),
          //Menu(),
        ],
      ),
      body: WebView(
        initialUrl: 'https://en.wikipedia.org/wiki/Kraken',
        onWebViewCreated: (WebViewController webViewController) =>
            _controller.complete(webViewController),
      ),
      floatingActionButton: _bookmarkButton(),
    );
  }
}
