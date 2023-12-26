import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import '../delegates/text_delegate.dart';

class TextDialog extends StatefulWidget {
  const TextDialog({
    Key? key,
    required this.controller,
    required this.fontSize,
    required this.onFinished,
    required this.color,
    required this.textDelegate,
  }) : super(key: key);
  final TextEditingController controller;
  final double fontSize;
  final VoidCallback onFinished;
  final Color color;
  final TextDelegate textDelegate;

  static void show(
    BuildContext context,
    TextEditingController controller,
    double fontSize,
    Color color,
    TextDelegate textDelegate, {
    required ValueChanged<BuildContext> onFinished,
  }) {
    SmartDialog.show(
      builder: (_) {
        return TextDialog(
          controller: controller,
          fontSize: fontSize,
          onFinished: () => onFinished(context),
          color: color,
          textDelegate: textDelegate,
        );
      },
      onDismiss: () {
        onFinished(context);
      },
      backDismiss: false,
      clickMaskDismiss: true,
      alignment: Alignment.center,
    );
  }

  static void dismiss() {
    SmartDialog.dismiss();
  }

  @override
  State<StatefulWidget> createState() => _TextDialogState();
}

class _TextDialogState extends State<TextDialog> {
  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: GestureDetector(
        onTap: TextDialog.dismiss,
        child: Material(
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 50,
                child: TextField(
                  controller: widget.controller,
                  autofocus: true,
                  focusNode: focusNode,
                  style: TextStyle(
                    fontSize: widget.fontSize,
                    fontWeight: FontWeight.bold,
                    color: widget.color,
                  ),
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                    border: InputBorder.none,
                    hintText: '',
                  ),
                ),
              ),
              // Align(
              //   alignment: Alignment.bottomCenter,
              //   child: TextButton(
              //     child: Text(
              //       textDelegate.done,
              //       style: const TextStyle(
              //         color: Colors.white,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     onPressed: onFinished,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
