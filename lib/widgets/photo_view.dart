import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
class PhotoviewPage extends StatefulWidget {

  final String imageUrl ;
  const PhotoviewPage({super.key, required this.imageUrl, });

  @override
  State<PhotoviewPage> createState() => _PhotoviewPageState();
}

class _PhotoviewPageState extends State<PhotoviewPage> {
@override
Widget build(BuildContext context) {
  return Stack(
    children: [
      PhotoView(
        imageProvider: CachedNetworkImageProvider(widget.imageUrl),
      ),
      Positioned(
        top: 50,
        right: 20,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(50),
          ),
          child: IconButton(
            icon: const Icon(Icons.close, color: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    ],
  );
}
}