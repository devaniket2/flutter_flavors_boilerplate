import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WebviewAppBar extends StatefulWidget {
  final double height;
  const WebviewAppBar({super.key, required this.height});

  @override
  State<WebviewAppBar> createState() => _WebviewAppBarState();
}

class _WebviewAppBarState extends State<WebviewAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red.withValues(alpha: .4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [SizedBox(height: widget.height, width: 1.sw)],
      ),
    );
  }
}
