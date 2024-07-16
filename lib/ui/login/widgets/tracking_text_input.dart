import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:heroicons/heroicons.dart';
import 'input_helper.dart';

typedef CaretMoved = void Function(Offset? globalCaretPosition);
typedef TextChanged = void Function(String text);
typedef FieldValidator = String? Function(String? value);

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
    this.isPasswordField = false,
  }) : super(key: key);

  final CaretMoved? onCaretMoved;
  final TextChanged? onTextChanged;
  final String? hint;
  final String? label;
  final bool isObscured;
  final TextEditingController textController;
  final FieldValidator? validator;
  final FocusNode? focusNode;
  final bool isPasswordField;

  @override
  _TrackingTextInputState createState() => _TrackingTextInputState();
}

class _TrackingTextInputState extends State<TrackingTextInput> {
  final GlobalKey _fieldKey = GlobalKey();
  Timer? _debounceTimer;
  bool _isObscured = true;

  @override
  void initState() {
    _isObscured = widget.isObscured;
    widget.textController.addListener(() {
      if (_debounceTimer?.isActive ?? false) _debounceTimer!.cancel();
      _debounceTimer = Timer(const Duration(milliseconds: 100), () {
        if (_fieldKey.currentContext != null) {
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

  void _toggleObscureText() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(bottom: 20.0.w),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: widget.hint,
          labelText: widget.label,
          suffixIcon: widget.isPasswordField
              ? IconButton(
                  icon: HeroIcon(
                    _isObscured ? HeroIcons.eye : HeroIcons.eyeSlash,
                  ),
                  onPressed: _toggleObscureText,
                )
              : null,
        ),
        key: _fieldKey,
        focusNode: widget.focusNode,
        controller: widget.textController,
        obscureText: widget.isPasswordField ? _isObscured : widget.isObscured,
        validator: widget.validator,
      ),
    );
  }
}
