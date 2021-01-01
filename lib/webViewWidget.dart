import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
const timeout = const Duration(seconds: 3);
const ms = const Duration(milliseconds: 1);
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
  bool loading=true;
  final Completer<WebViewController> _controller =
  Completer<WebViewController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
appBar: AppBar(
  title: Text(widget.title)),

      body: Builder(builder: (BuildContext context){
         return Stack(
           children:[ WebView(
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
startTimeout(100);

             },
             gestureNavigationEnabled: true,
           ),
            loading ? Center(
               child: CircularProgressIndicator(

               ),
             ):Container()
        ]
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

  startTimeout([int milliseconds]) {
    var duration = milliseconds == null ? timeout : ms * milliseconds;
    return new Timer(duration, handleTimeout);
  }
  handleTimeout() {  // callback function
    setState(() {
        loading = false;
 });
  }
}
