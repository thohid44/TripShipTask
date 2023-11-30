import 'package:flutter/material.dart';


class BalanceScreen extends StatefulWidget {
  @override
  _BalanceScreenState createState() => _BalanceScreenState();
}

class _BalanceScreenState extends State<BalanceScreen> {
  bool _showBalance = true;

  void toggleBalanceVisibility() {
    setState(() {
      _showBalance = !_showBalance;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Balance Animation'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.easeInOut,
              width: _showBalance ? 0 : 200,
              child: Expanded(
                child: Container(
                  height: 60,
                  child: Row(
                   
                    children: [
                      if (_showBalance) Text('Balance: \$1000.00'),
                      ElevatedButton(
                        onPressed: toggleBalanceVisibility,
                        child: Text(_showBalance ? 'Show Balance' : 'Hide Balance', style: TextStyle(color: Colors.black),),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
