import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class webViewWidget extends StatefulWidget {
 String title,url;
 webViewWidget(String title,String url){
   this.title = title;
   this.url = url;
 }
  @override
  _webViewWidgetState createState() => _webViewWidgetState();

}

class _webViewWidgetState extends State<webViewWidget> {
 // _webViewWidgetState(String title, String url);
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text(widget.title)),

      body: Builder(builder: (BuildContext context){
         return WebView(
           initialUrl: widget.url,
           javascriptMode: JavascriptMode.unrestricted,
           onWebViewCreated: (WebViewController webViewController){
             _controller.complete(webViewController);
           },
           javascriptChannels: <JavascriptChannel>[
           _toasterJavascriptChannel(context)          
           ].toSet(),
           navigationDelegate: (NavigationRequest request) {
             if (request.url.startsWith('https://www.youtube.com/')) {
               print('blocking navigation to $request}');
               return NavigationDecision.prevent;
             }
             print('allowing navigation to $request');
             return NavigationDecision.navigate;
           },
           onPageStarted: (String url){
             print('Page started loading: $url');
           },
           onPageFinished: (String url){
             print('Page finished loading: $url');
           },
           gestureNavigationEnabled: true,
         );
    }),
    );
  }
  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          // ignore: deprecated_member_use
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }
}
