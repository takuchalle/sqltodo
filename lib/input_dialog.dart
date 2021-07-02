import 'package:flutter/material.dart';

class InputDialog extends StatefulWidget {
  const InputDialog({Key? key}) : super(key: key);
  @override
  _InputDialogState createState() => _InputDialogState();
}

class _InputDialogState extends State<InputDialog> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: myController,
        ),
        ElevatedButton(
          child: Text('cancel'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        ElevatedButton(
          child: Text('submit'),
          onPressed: () {
            final text = myController.value.text.isEmpty
                ? null
                : myController.value.text;
            Navigator.pop(context, text);
          },
        )
      ],
    );
  }
}

Future<String?> showInputDialog(BuildContext context) async {
  final text = await showDialog<String>(
    context: context,
    builder: (_) => SimpleDialog(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: InputDialog(),
        ),
      ],
    ),
  );
  return text;
}
