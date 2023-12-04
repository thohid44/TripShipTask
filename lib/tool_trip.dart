import 'package:flutter/material.dart';



class MyToolTrip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Tooltip with TextFormField'),
        ),
        body: MyForm(),
      ),
    );
  }
}

class MyForm extends StatefulWidget {
  @override
  _MyFormState createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final TextEditingController _textController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool showTooltip = false;

  @override
  void initState() {
    super.initState();

    // Listen to changes in the focus of the TextFormField
    _focusNode.addListener(() {
      setState(() {
        showTooltip = _focusNode.hasFocus && _textController.text.isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [

          Tooltip(
            message: "Test tool trip",
            child: Icon(Icons.abc),
          ), 
          Tooltip(
            message: 'Value cannot be empty',
            preferBelow: false,
            showDuration: Duration(seconds: 2),
            decoration: BoxDecoration(
              color: Colors.redAccent,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: TextFormField(
              controller: _textController,
              focusNode: _focusNode,
              decoration: InputDecoration(
                labelText: 'Enter value',
              ),
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Perform an action when the button is pressed
              // For example, you can submit the form
              print('Form Submitted');
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }
}
