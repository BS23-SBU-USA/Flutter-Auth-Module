import 'package:auth_module/src/core/theme/extension.dart';
import 'package:auth_module/src/core/theme/typography/style.dart';
import 'package:auth_module/src/core/widgets/button/back_button.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({
    required this.url,
    super.key,
  });

  final String url;

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              loading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.color.onPrimary,
        elevation: 0,
        title: Text(
          'Terms & Conditions',
          style: AppTypography.semiBold18Caros(),
        ),
        centerTitle: true,
        leading: const AppBackButton(),
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            WebViewWidget(
              controller: controller,
            ),
            if (loading)
              CircularProgressIndicator(
                color: context.color.primary,
              ),
          ],
        ),
      ),
    );
  }
}
