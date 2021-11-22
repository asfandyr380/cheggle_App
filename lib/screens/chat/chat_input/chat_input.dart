import 'dart:async';

import 'package:flutter/material.dart';
import 'package:listar_flutter/configs/config.dart';
import 'package:listar_flutter/screens/chat/chat_input/gallery.dart';
import 'package:listar_flutter/screens/chat/chat_input/more.dart';
import 'package:listar_flutter/screens/chat/chat_input/record.dart';

enum VirtualKeyboard { more, record, gallery, none }

class ChatInput extends StatefulWidget {
  final String initText;
  final double keyboardHeight;
  final double minimum;
  final Function(String text) onSend;

  ChatInput({
    this.initText,
    this.onSend,
    this.keyboardHeight,
    this.minimum,
  });

  @override
  _ChatInputState createState() {
    return _ChatInputState();
  }
}

class _ChatInputState extends State<ChatInput> {
  final _inputHeight = 64.0;
  final _editingController = TextEditingController();
  final _focusNode = FocusNode();

  double _storageKeyboardHeight = Application.preferences.getDouble(
    Preferences.keyboardHeight,
  );
  bool _keepAlive = false;
  bool _showAction = true;
  bool _readyVirtualUI = false;
  double _virtualKeyboardHeight;
  double _minimumOffset = 0;
  VirtualKeyboard _virtualKeyboard = VirtualKeyboard.none;
  Timer _timerAlive;
  Timer _timerShowAction;

  @override
  void initState() {
    super.initState();
    if (_storageKeyboardHeight == null) _storageKeyboardHeight = 250;
    _virtualKeyboardHeight = widget.keyboardHeight;
    _minimumOffset = widget.minimum;
    _focusNode.addListener(_onFocusChange);
  }

  ///On Send Message/Gallery
  void _onSend() async {
    switch (_virtualKeyboard) {
      default:
        if (_editingController.text.isNotEmpty) {
          widget?.onSend(_editingController.text);
          _editingController?.clear();
        }
        break;
    }
  }

  ///On Send Record
  void _onSendRecord(String text) {
    widget?.onSend(text);
  }

  ///On Gallery
  void _onGallery() async {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _virtualKeyboard = VirtualKeyboard.gallery;
    });
  }

  ///On Gallery
  void _onRecord() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _virtualKeyboard = VirtualKeyboard.record;
    });
  }

  ///On more
  void _onMore() {
    FocusScope.of(context).requestFocus(FocusNode());
    setState(() {
      _virtualKeyboard = VirtualKeyboard.more;
    });
  }

  /// height keyboard
  void _onChangeHeightKeyboard() {
    ///Set virtual keyboard when media query > safe are bottom [keyboard OPEN]
    if (widget.keyboardHeight > _minimumOffset) {
      setState(() {
        _virtualKeyboardHeight = widget.keyboardHeight;
      });
      _storageKeyboardHeight = widget.keyboardHeight;

      ///Save Preferences
      Application.preferences.setDouble(
        Preferences.keyboardHeight,
        _storageKeyboardHeight,
      );
    } else {
      ///When [keyboard CLOSE]
      if (_virtualKeyboard != VirtualKeyboard.none) {
        ///Keep VirtualKeyboard show other picker
        setState(() {
          _virtualKeyboardHeight = _storageKeyboardHeight;
        });
      } else {
        ///Keep VirtualKeyboard when focus again text field
        if (!_keepAlive) {
          setState(() {
            _virtualKeyboardHeight = _minimumOffset;
          });
        }
      }
    }
  }

  ///Handle Focus Text Field
  void _onFocusChange() {
    ///The  keyboard is OPEN

    if (_focusNode.hasFocus) {
      ///Show and auto hidden action when not input
      _timerShowAction?.cancel();
      setState(() {
        _showAction = false;
      });
      _timerShowAction = Timer(Duration(milliseconds: 3000), () {
        if (_editingController.text.isEmpty) {
          setState(() {
            _showAction = true;
          });
        }
      });

      ///Reset VirtualKeyboard when tap input
      if (_virtualKeyboard != VirtualKeyboard.none) {
        setState(() {
          _virtualKeyboard = VirtualKeyboard.none;
        });

        ///The trick keep virtual keyboard open size when touch text field
        _keepAlive = true;
        _timerAlive?.cancel();
        _timerAlive = Timer(Duration(milliseconds: 500), () {
          _keepAlive = false;
        });
      }
    } else {
      setState(() {
        _showAction = true;
      });
    }
  }

  ///Dismiss Process for VirtualKeyboard
  void _gesturesDismiss(DragUpdateDetails detail) {
    if (detail.delta.dy > 0 && _virtualKeyboard != VirtualKeyboard.none) {
      setState(() {
        _virtualKeyboard = VirtualKeyboard.none;
      });
    }
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _editingController.dispose();
    _timerAlive?.cancel();
    _timerShowAction?.cancel();
    super.dispose();
  }

  ///Select Color
  Color _selectedColor(VirtualKeyboard type) {
    if (type == _virtualKeyboard) {
      return Theme.of(context).primaryColor;
    }
    return null;
  }

  ///Build buildVirtualKeyboard
  Widget _buildVirtualKeyboard() {
    if (_readyVirtualUI) {
      switch (_virtualKeyboard) {
        case VirtualKeyboard.gallery:
          return InputGallery(onSelect: (list) {});
        case VirtualKeyboard.record:
          return InputRecord(
            onSend: _onSendRecord,
          );
        case VirtualKeyboard.more:
          return InputMore(
            onSend: _onSendRecord,
          );
        default:
          return Container();
      }
    }
    return Container();
  }

  ///Widget build action
  Widget _buildAction() {
    if (_showAction) {
      return Row(
        children: [
          Flexible(
            fit: FlexFit.loose,
            child: IconButton(
              icon: Icon(
                Icons.more_horiz,
                color: _selectedColor(VirtualKeyboard.more),
              ),
              onPressed: _onMore,
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: IconButton(
              icon: Icon(
                Icons.mic,
                color: _selectedColor(VirtualKeyboard.record),
              ),
              onPressed: _onRecord,
            ),
          ),
        ],
      );
    }

    return IconButton(
      icon: Icon(
        Icons.chevron_right,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: () {
        setState(() {
          _showAction = true;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _onChangeHeightKeyboard();
    return GestureDetector(
      onVerticalDragUpdate: _focusNode.hasFocus ? null : _gesturesDismiss,
      onHorizontalDragUpdate: _focusNode.hasFocus ? null : _gesturesDismiss,
      child: Container(
        color: Theme.of(context).cardColor,
        child: AnimatedContainer(
          curve: Curves.easeOutQuad,
          duration: Duration(milliseconds: 250),
          onEnd: () {
            setState(() {
              _readyVirtualUI = !_readyVirtualUI;
            });
          },
          height: _virtualKeyboardHeight + _inputHeight,
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  AnimatedContainer(
                    duration: Duration(milliseconds: 150),
                    width: _showAction ? 100 : 32,
                    child: _buildAction(),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(8),
                      padding: EdgeInsets.only(left: 8, right: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Theme.of(context).dividerColor,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: "Type some thing ...",
                                border: InputBorder.none,
                              ),
                              controller: _editingController,
                              onSubmitted: (value) {
                                FocusScope.of(context).requestFocus(
                                  _focusNode,
                                );
                                _onSend();
                              },
                              onChanged: (text) {
                                if (text.isNotEmpty && _showAction) {
                                  setState(() {
                                    _showAction = false;
                                  });
                                }
                              },
                            ),
                          ),
                          InkWell(
                            onTap: _onSend,
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                            child: Container(
                              width: 32,
                              height: 32,
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.send,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(child: _buildVirtualKeyboard()),
            ],
          ),
        ),
      ),
    );
  }
}
