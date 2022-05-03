import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:personal_dev_tools/util.dart';

class TextGeneratorPage extends StatefulWidget {
  const TextGeneratorPage({
    Key? key,
    required this.inputLabel,
    required this.generatedLabel,
    required this.generatorFunc,
  }) : super(key: key);
  final String inputLabel;
  final String generatedLabel;
  final String Function(String, int) generatorFunc;
  @override
  State<TextGeneratorPage> createState() => _TextGeneratorPageState();
}

class _TextGeneratorPageState extends State<TextGeneratorPage>
    with AutomaticKeepAliveClientMixin<TextGeneratorPage> {
  var inputTextController = TextEditingController();
  var generatedTextController = TextEditingController();
  bool useInverseFormatFunc = false;
  int numTextGenerated = 1;

  @override
  bool get wantKeepAlive => true;

  void _setText(text) {
    setState(() {
      generatedTextController.text = text;
    });
  }

  void _addText(text) {
    setState(() {
      var start = inputTextController.selection.start;
      var end = inputTextController.selection.end;
      inputTextController.text = inputTextController.text.substring(0, start) + text + inputTextController.text.substring(end);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      _addText('\${uuidv4}');
                    },
                    child: const Text('UUIDv4'),
                  ),
                  flex: 2,
                ),
                const Spacer(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      _addText('\${timestamp}');
                    },
                    child: const Text('Timestamp'),
                  ),
                  flex: 2,
                ),
                const Spacer(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      _addText('\${iter}');
                    },
                    child: const Text('Iteration'),
                  ),
                  flex: 2,
                ),
                const Spacer(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      _addText('\${xid}');
                    },
                    child: const Text('Xid'),
                  ),
                  flex: 2,
                ),
                const Spacer(),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 15),
                    ),
                    onPressed: () {
                      _addText('\${mongoid}');
                    },
                    child: const Text('MongoID'),
                  ),
                  flex: 2,
                ),
                const Spacer(flex: 1),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(
                      icon: Icon(Icons.add),
                      hintText: 'default: 1',
                      labelText: 'Number text generated',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onChanged: (String? value) {
                      var parsedInt = int.tryParse(value!);
                      if (parsedInt != null) {
                        numTextGenerated = parsedInt;
                      }
                    },
                    validator: (String? value) {
                      var parsedInt = int.tryParse(value!);
                      if (parsedInt != null && parsedInt > 0) {
                        return null;
                      }
                      return 'Value must be a positive int';
                    },
                  ),
                  flex: 3,
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Input Format",
                      ),
                      controller: inputTextController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    flex: 1),
                Visibility(
                  child: IconButton(
                    icon: const FaIcon(FontAwesomeIcons.arrowRight),
                    onPressed: () {
                      _setText(widget.generatorFunc(
                          inputTextController.text, numTextGenerated));
                    },
                  ),
                ),
                Expanded(
                    child: TextField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Generated Text",
                      ),
                      readOnly: true,
                      controller: generatedTextController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                    flex: 1),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
