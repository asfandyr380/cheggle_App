import 'package:flutter/material.dart';
import 'package:listar_flutter/models/model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class PhotoPreview extends StatefulWidget {
  PhotoPreview({
    this.initialIndex,
    @required this.galleryList,
  }) : pageController = PageController(initialPage: initialIndex);

  final int initialIndex;
  final PageController pageController;
  final List<ImageModel> galleryList;

  @override
  State<StatefulWidget> createState() {
    return _PhotoPreviewState();
  }
}

class _PhotoPreviewState extends State<PhotoPreview> {
  int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
  }

  ///On change image
  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  ///Build Item
  PhotoViewGalleryPageOptions _buildItem(BuildContext context, int index) {
    final ImageModel item = widget.galleryList[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: AssetImage(item.image),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained,
      maxScale: PhotoViewComputedScale.covered * 1.1,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: <Widget>[
          PhotoViewGallery.builder(
            scrollPhysics: BouncingScrollPhysics(),
            builder: _buildItem,
            itemCount: widget.galleryList.length,
            pageController: widget.pageController,
            onPageChanged: onPageChanged,
            scrollDirection: Axis.horizontal,
          ),
          Positioned(
            child: SafeArea(
              child: IconButton(
                padding: EdgeInsets.all(16),
                icon: Icon(
                  Icons.close,
                ),
                color: Colors.white,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
