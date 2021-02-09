import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Room Booking'),
          centerTitle: true,
        ),
        body: Column(
          children: <Widget>[
            new FlatButton(
              onPressed: () => {print('You have booked slot 1')},
              child: Text('11:00 to 12:00'),
            ),
            new FlatButton(
              onPressed: () => {print('You have booked slot 2')},
              child: Text('12:00 to 13:00'),
            ),
            new FlatButton(
              onPressed: () => {print('You have booked slot 3')},
              child: Text('13:00 to 14:00'),
            ),
          ],
        ));
  }
}
