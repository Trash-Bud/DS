import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:frontend/controller/provider/asn_change_notifier.dart';
import 'package:flutter/services.dart';

class KafkaSend extends StatelessWidget {
  const KafkaSend({super.key});

  static final TextEditingController asnController = TextEditingController();

  Future<void> _sendReceptionReceived(id, context) async {
    final model = Provider.of<AsnChangeNotifier>(context, listen: false);
    await model.sendReceptionReceived(id);
  }

  @override
  Widget build(BuildContext context) {
    final MediaQueryData queryData = MediaQuery.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Demo')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: EdgeInsets.only(top: queryData.size.height / 7.5),
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 350),
                child: Column(children: [
                  createForm(context, queryData),
                ]),
              )),
        ],
      ),
    );
  }

  Widget createInput(BuildContext context, TextEditingController controller) {
    return TextFormField(
        style: const TextStyle(fontSize: 20),
        autocorrect: false,
        autofocus: true,
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: const InputDecoration(
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Color.fromARGB(255, 82, 81, 81))),
            border: OutlineInputBorder(),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(width: 2))));
  }

  Widget createFormButton(BuildContext context, String text) {
    return SizedBox(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        child: Text(text,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 20),
            textAlign: TextAlign.center),
        onPressed: () =>
            {_sendReceptionReceived(int.parse(asnController.text), context)},
      ),
    );
  }

  Widget createForm(BuildContext context, MediaQueryData queryData) {
    return Form(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ),
        child: Padding(
            padding: EdgeInsets.only(
                left: queryData.size.width / 45,
                right: queryData.size.width / 45,
                top: queryData.size.height / 40,
                bottom: queryData.size.height / 45),
            child: Column(
              children: [
                createLabel(context, 'ASN ID'),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: queryData.size.height / 80)),
                createInput(context, asnController),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: queryData.size.height / 25)),
                createFormButton(context, 'Send Reception Received'),
              ],
            )),
      ),
    );
  }

  /// Aggregates all widgets in a list.
  List<Widget> getWidgets(BuildContext context, MediaQueryData queryData) {
    final List<Widget> widgets = [];

    widgets.add(
        Padding(padding: EdgeInsets.only(bottom: queryData.size.height / 70)));
    widgets.add(createForm(context, queryData));

    return widgets;
  }

  /// Creates the input labels.
  Widget createLabel(BuildContext context, String labelText) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        labelText,
        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
      ),
    );
  }
}
