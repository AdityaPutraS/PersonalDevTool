import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrRendererPage extends StatefulWidget {
  const QrRendererPage({
    Key? key,
  }) : super(key: key);

  @override
  State<QrRendererPage> createState() => _QrRendererPageState();
}

class _QrRendererPageState extends State<QrRendererPage>
    with AutomaticKeepAliveClientMixin<QrRendererPage> {
  var inputTextController = TextEditingController();
  var qrString = '';

  @override
  bool get wantKeepAlive => true;

  void _setQRString(text) {
    setState(() {
      qrString = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'QR String',
                ),
                onChanged: _setQRString,
                controller: inputTextController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
              ),
              flex: 1),
          Expanded(
              child: QrImage(
                data: qrString,
                version: QrVersions.auto,
                padding: const EdgeInsets.all(16.0),
              ),
              flex: 1),
        ],
      ),
    );
  }
}
