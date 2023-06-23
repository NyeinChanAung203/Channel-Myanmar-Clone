import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../themes/styles.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.8),
      child: const CupertinoActivityIndicator(
        color: kWhite,
        radius: 12,
      ),
    );
  }
}
