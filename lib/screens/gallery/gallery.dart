import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/models/model.dart';

class Gallery extends StatefulWidget {
  final List<ImageModel> photo;

  Gallery({this.photo}) : super();

  @override
  _GalleryState createState() {
    return _GalleryState();
  }
}

class _GalleryState extends State<Gallery> {
  final _controller = SwiperController();
  final _listController = ScrollController();

  int _index = 0;

  @override
  void initState() {
    super.initState();
  }

  ///On Process index change
  void _onChange(int index) {
    setState(() {
      _index = index;
    });
    final currentOffset = (index + 1) * 90.0;
    final widthDevice = MediaQuery.of(context).size.width;

    ///Animate scroll to Overflow offset
    if (currentOffset > widthDevice) {
      _listController.animateTo(
        currentOffset - widthDevice,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      ///Move to Start offset when index not overflow
      _listController.animateTo(
        0.0,
        duration: Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    }
  }

  ///On preview photo
  void _onPreviewPhoto(int index) {
    Navigator.pushNamed(
      context,
      Routes.photoPreview,
      arguments: {"photo": widget.photo, "index": index},
    );
  }

  ///On select image
  void _onSelectImage(int index) {
    _controller.move(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        brightness: Brightness.dark,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Swiper(
                controller: _controller,
                onIndexChanged: _onChange,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      _onPreviewPhoto(index);
                    },
                    child: Image.asset(
                      widget.photo[index].image,
                      fit: BoxFit.contain,
                    ),
                  );
                },
                itemCount: widget.photo.length,
                pagination: SwiperPagination(
                  alignment: Alignment(0.0, 0.9),
                  builder: DotSwiperPaginationBuilder(
                    activeColor: Theme.of(context).primaryColor,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    "Standard Double Room",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.white),
                  ),
                  Text(
                    "${_index + 1}/${widget.photo.length}",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2
                        .copyWith(color: Colors.white),
                  )
                ],
              ),
            ),
            Container(
              height: 70,
              margin: EdgeInsets.only(bottom: 16),
              child: ListView.builder(
                controller: _listController,
                padding: EdgeInsets.only(right: 16),
                scrollDirection: Axis.horizontal,
                itemCount: widget.photo.length,
                itemBuilder: (context, index) {
                  final item = widget.photo[index];
                  return GestureDetector(
                    onTap: () {
                      _onSelectImage(index);
                    },
                    child: Container(
                      width: 70,
                      margin: EdgeInsets.only(left: 16),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: index == _index
                                ? Theme.of(context).primaryColor
                                : Theme.of(context).dividerColor),
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        ),
                        image: DecorationImage(
                          image: AssetImage(item.image),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
