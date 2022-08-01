import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:travella_01/pages/information_page/constants.dart';
class GalleryWidget extends StatefulWidget {
  final List<String> assetImages;
  final int index;
  final PageController pageController;

  GalleryWidget({
    required this.assetImages,
    this.index = 0,
  }) : pageController = PageController(initialPage: index) ;

  @override
  State<GalleryWidget> createState() => _GalleryWidgetState();
}

class _GalleryWidgetState extends State<GalleryWidget> {
  late int index = widget.index;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: [
        PhotoViewGallery.builder(
          pageController: widget.pageController,
          //scrollDirection: Axis.vertical,
          itemCount: widget.assetImages.length, //buraya firebase için değişiklik yapılacak
          builder:(context, index) {
            final assetImage = widget.assetImages[index];

            return PhotoViewGalleryPageOptions(
              imageProvider: AssetImage(assetImage), //NetworkImage ile değiştirilebilir.
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained * 4, //maksimum 4x zoom a izin veriyoruz.
            );
          },
          onPageChanged: (index) => setState(() {
            this.index = index;
          }),
        ),
        Container(
          padding: EdgeInsets.all(defaultPadding),
          child: DefaultTextStyle(
            style: TextStyle(color: Colors.white, fontSize: 25),
            child: Text(
              "Fotoğraf ${index + 1}/${widget.assetImages.length}",

            ),
          ),
        ),
      ],
    );

  }
}
