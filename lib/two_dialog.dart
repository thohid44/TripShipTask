import 'package:flutter/material.dart';

class TwoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Dialog Example'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _showFirstDialog(context);
          },
          child: Text('Open Dialog'),
        ),
      ),
    );
  }

  void _showFirstDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('First Dialog'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context); // Close the first dialog
                _showSecondDialog(context);
              },
              child: Text('Yes'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context); // Close the first dialog
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }

  void _showSecondDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Second Dialog'),
          children: <Widget>[
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context); // Close the second dialog
                // Handle 'Yes' in the second dialog
              },
              child: Text('Yes'),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context); // Close the second dialog
                // Handle 'No' in the second dialog
              },
              child: Text('No'),
            ),
          ],
        );
      },
    );
  }
}
