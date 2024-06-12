import 'dart:async';
import 'package:flutter/material.dart';
import 'input_helper.dart';

typedef CaretMoved = void Function(Offset? globalCaretPosition);
typedef TextChanged = void Function(String text);
typedef FieldValidator = String? Function(String? value);

// Helper widget to track caret position.
class TrackingTextInput extends StatefulWidget {
  const TrackingTextInput({
    Key? key,
    this.onCaretMoved,
    this.onTextChanged,
    this.hint,
    this.label,
    this.isObscured = false,
    required this.textController,
    this.validator,
    this.focusNode,
  }) : super(key: key);

  final CaretMoved? onCaretMoved;
  final TextChanged? onTextChanged;
  final String? hint;
  final String? label;
  final bool isObscured;
  final TextEditingController textController;
  final FieldValidator? validator;
  final FocusNode? focusNode;

  @override
  _TrackingTextInputState createState() => _TrackingTextInputState();
}

class _TrackingTextInputState extends State<TrackingTextInput> {
  final GlobalKey _fieldKey = GlobalKey();
  Timer? _debounceTimer;

  @override
  void initState() {
    widget.textController.addListener(() {
      // We debounce the listener as sometimes the caret position is updated after the listener
      // this assures us we get an accurate caret position.
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
          // Find the render editable in the field.
          final RenderObject? fieldBox =
              _fieldKey.currentContext?.findRenderObject();
          var caretPosition =
              fieldBox is RenderBox ? getCaretPosition(fieldBox) : null;

          widget.onCaretMoved?.call(caretPosition);
        }
      });
      widget.onTextChanged?.call(widget.textController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: widget.hint,
          labelText: widget.label,
        ),
        key: _fieldKey,
        focusNode: widget.focusNode,
        controller: widget.textController,
        obscureText: widget.isObscured,
        validator: widget.validator,
      ),
    );
  }
}
