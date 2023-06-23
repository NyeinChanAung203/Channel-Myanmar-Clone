import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

enum _MenuOption {
  navigationDelegate,
}

class Menu extends StatelessWidget {
  const Menu({super.key, required this.controller});

  final WebViewController controller;

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        onSelected: (value) async {
          switch (value) {
            case _MenuOption.navigationDelegate:
              await controller
                  .loadRequest(Uri.parse('https://channelmyanmar.org'));
          }
        },
        itemBuilder: (context) => [
              const PopupMenuItem(
                value: _MenuOption.navigationDelegate,
                child: Text('Navigate to YouTube'),
              )
            ]);
  }
}
