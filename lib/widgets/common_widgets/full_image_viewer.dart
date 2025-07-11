import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../Utils/custom_methods.dart';

class FullImageViewer extends StatefulWidget {
  final String imageData;
  const FullImageViewer({super.key, required this.imageData,});

  @override
  State<FullImageViewer> createState() => _FullImageViewerState();
}

class _FullImageViewerState extends State<FullImageViewer> {
  CustomMethods cm = CustomMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: cm.getAppBarWithTitle(
        context, 
        "",
        actions: [
          IconButton(
            onPressed: () {
              Share.share(widget.imageData);
            },
            icon: const Icon(
              Icons.share,
              color: Colors.white,
            ),
          )
        ]
      ),
      body: InteractiveViewer(
        panEnabled: false, // Set it to false
        boundaryMargin: const EdgeInsets.all(100),
        minScale: 1,
        maxScale: 2,
        child: Image.network(
          widget.imageData,
          height: MediaQuery.sizeOf(context).height,
          width: MediaQuery.sizeOf(context).width,
        ),
      ),
    );
  }
}