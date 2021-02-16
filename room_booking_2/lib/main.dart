import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart';

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
        body: MyCustomForm(),
      );
  }
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value of the TextField.
  final myController1 = TextEditingController();
  final myController2 = TextEditingController();
  final myController3 = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController1.dispose();
    myController2.dispose();
    myController3.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Volleyball Rooms'),
        centerTitle: true,
        backgroundColor: Colors.blue[700],
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController1,
              decoration: InputDecoration(
                labelText: "Enter Name",
                border: OutlineInputBorder(),
                icon: Icon(Icons.person),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController2,
              decoration: InputDecoration(
                labelText: "Enter Starting Time",
                hintText: "01 February 2021, 00:00",
                border: OutlineInputBorder(),
                icon: Icon(Icons.calendar_today_rounded),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: myController3,
              decoration: InputDecoration(
                labelText: "Enter Ending Time",
                hintText: "01 February 2021, 10:00",
                border: OutlineInputBorder(),
                icon: Icon(Icons.calendar_today_rounded),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the text that the user has entered into the text field.
        onPressed: () {
          String name = myController1.text;
          print(name);
          String starttime = myController2.text;
          print(starttime);
          String endtime = myController3.text;
          print(endtime);
          roomChecker(name, starttime, endtime);
          /*return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the that user has entered by using the
                // TextEditingController.
                content: Text(myController1.text),
              );
            },
          );*/
        },
        tooltip: 'Show me the value!',
        child: Text(
          'Book', 
        ),
      ),
    );
  }
}

var volleyRoom1 = <List, bool>{
  ['11:00', '12:00'] : true,
};

var volleyRoom2 = <num, bool>{
  11: true,
  12: true,
  13: true,
};

var volleyRoom3 = <num, bool>{
  11: true,
  12: true,
  13: true,
};

var volleyRoomStart1 = <String, bool>{
  '11:00' : true,
};

void checkerMan(String name, String starttime, String endtime){
  print(volleyRoom1);
  print(volleyRoomStart1['11:00']);
    
  var now = DateTime.now();
  print(now);
}

var rooms = <String, List>{
  "Room 1": [],
  "Room 2": [],
  "Room 3": [],
};

void roomChecker(String name, String starttime, String endtime){
  var start = DateTime.parse(starttime);
  print(start);
  var end = DateTime.parse(endtime);
  print(end);

}

/*
if(((element[0] < start) < element[1]) || ((element[0] < end) < element[1]) || (((element[0] < start) < end) < element[1])){
          
}
*/