import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputGallery extends StatefulWidget {
  final Function(List) onSelect;
  InputGallery({
    Key key,
    this.onSelect,
  }) : super(key: key);

  @override
  _InputGalleryState createState() {
    return _InputGalleryState();
  }
}

class _InputGalleryState extends State<InputGallery> {
  String _option = 'image';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  ///On Load data
  void _loadData() async {}

  Future<void> loadAssets() async {}

  ///On Change Select
  void _onChange(String key) {
    setState(() {
      _option = key;
    });
  }

  ///Builder  List
  Widget _buildList() {
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 8),
      child: Stack(
        children: [
          Column(
            children: [
              CupertinoSlidingSegmentedControl(
                groupValue: _option,
                padding: EdgeInsets.zero,
                children: {
                  'image': Container(
                    width: 60,
                    height: 24,
                    child: Text('Photo'),
                    alignment: Alignment.center,
                  ),
                  'video': Container(
                    width: 60,
                    height: 24,
                    child: Text('Video'),
                    alignment: Alignment.center,
                  ),
                },
                onValueChanged: _onChange,
              ),
              Expanded(child: _buildList())
            ],
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              mini: true,
              child: Icon(
                Icons.image_outlined,
                color: Colors.white,
              ),
              onPressed: loadAssets,
            ),
          )
        ],
      ),
    );
  }
}

class ThumbGallery extends StatefulWidget {
  final Function() onTap;
  final bool selected;

  ThumbGallery({
    Key key,
    this.onTap,
    this.selected,
  }) : super(key: key);

  @override
  _ThumbGalleryState createState() {
    return _ThumbGalleryState();
  }
}

class _ThumbGalleryState extends State<ThumbGallery> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      alignment: Alignment.center,
      margin: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).focusColor,
        ),
      ),
      child: SizedBox(
        width: 16,
        height: 16,
        child: CircularProgressIndicator(
          strokeWidth: 1,
        ),
      ),
    );
  }
}
