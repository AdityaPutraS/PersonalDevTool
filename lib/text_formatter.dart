import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_dev_tools/util.dart';

class TextFormatterPage extends StatefulWidget {
  const TextFormatterPage(
      {Key? key,
      required this.inputLabel,
      required this.formattedLabel,
      required this.formatFunc,
      this.inverseFormatFunc})
      : super(key: key);
  final String inputLabel;
  final String formattedLabel;
  final String Function(String) formatFunc;
  final String Function(String)? inverseFormatFunc;

  @override
  State<TextFormatterPage> createState() => _TextFormatterPageState();
}

class _TextFormatterPageState extends State<TextFormatterPage>
    with AutomaticKeepAliveClientMixin<TextFormatterPage> {
  var inputTextController = TextEditingController();
  var formattedTextController = TextEditingController();
  bool useInverseFormatFunc = false;

  @override
  bool get wantKeepAlive => true;

  void _setText(text) {
    setState(() {
      if (useInverseFormatFunc && widget.inverseFormatFunc != null) {
        formattedTextController.text = widget.inverseFormatFunc!(text);
      } else {
        formattedTextController.text = widget.formatFunc(text);
      }
    });
  }

  void _setUseInverseFormatFunc(value) {
    setState(() {
      var tempText = formattedTextController.text;
      formattedTextController.text = inputTextController.text;
      inputTextController.text = tempText;
      useInverseFormatFunc = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: useInverseFormatFunc ? widget.formattedLabel : widget.inputLabel,
                ),
                onChanged: (text) {
                  _setText(text);
                },
                controller: inputTextController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              flex: 1),
          Visibility(
            child: IconButton(
              icon: const FaIcon(FontAwesomeIcons.arrowsLeftRight),
              onPressed: () {
                _setUseInverseFormatFunc(!useInverseFormatFunc);
              },
            ),
            visible: widget.inverseFormatFunc != null,
          ),
          Expanded(
              child: TextField(
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: useInverseFormatFunc ? widget.inputLabel : widget.formattedLabel,
                ),
                readOnly: true,
                controller: formattedTextController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              flex: 1),
        ],
      ),
    );
  }
}
