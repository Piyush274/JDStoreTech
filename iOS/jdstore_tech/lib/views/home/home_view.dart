import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  InAppWebViewController? webView;
  bool canGoBack = false;

  late PullToRefreshController pullToRefreshController;

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      onRefresh: () async {
        if (webView != null) {
          if (Platform.isAndroid) {
            webView!.reload();
          } else if (Platform.isIOS) {
            var url = await webView!.getUrl();
            webView!.loadUrl(urlRequest: URLRequest(url: url));
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: WillPopScope(
        onWillPop: () async {
          if (canGoBack) {
            webView?.goBack();
            return false;
          } else {
            return true;
          }
        },
        child: SafeArea(
          child: InAppWebView(
            initialUrlRequest:
                URLRequest(url: WebUri("https://www.jdstoretech.com")),
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              webView = controller;
            },
            onLoadStop: (controller, url) {
              pullToRefreshController.endRefreshing();
              webView?.canGoBack().then((value) {
                setState(() {
                  canGoBack = value;
                });
              });
            },
            onLoadError: (controller, url, code, message) {
              pullToRefreshController.endRefreshing();
            },
          ),
        ),
      ),
    );
  }
}
