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
                hintText: "2021-02-21 10:00:00",
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
                hintText: "2021-02-21 11:00:00",
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
          int roomNumber = roomChecker(name, starttime, endtime);
          /*return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text("Room no $roomNumber has been booked."),
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

var rooms = <num, List>{
  1: [],
  2: [],
  3: [],
};

int roomChecker(String name, String starttime, String endtime){
  var start = DateTime.parse(starttime);  print(start);
  var end = DateTime.parse(endtime); print(end);

  print("");
  print("Output for Admins:-");
  print(rooms[1]); 
  print(rooms[2]); 
  print(rooms[3]);  
  print("");

  int flagAdded = 0;
  int flagRoom = -1;
  for(var i = 1; i < 4; i++){
    flagRoom = -1;
    for(var j = 0; j < rooms[i].length; j++){
      if(((start.isAfter(rooms[i][j][0])) && start.isBefore(rooms[i][j][1])) || ((end.isAfter(rooms[i][j][0])) && end.isBefore(rooms[i][j][1])) || (((start.isAfter(rooms[i][j][0])) && start.isBefore(end)) && end.isBefore(rooms[i][j][1]))){
        flagRoom = j;
        break;
      }
      else{
        continue;
      }
    }

    if(flagRoom == -1){
      rooms[i] = rooms[i] + [[start,end]];
      flagAdded = i;
      break;
    }
  }

  print("Output for User:");
  if(flagAdded != 0){
    print("Room number $flagAdded booked");
    print("");
  }
  else{
    print("Room cannot be booked");
    print("");
  }

  print("Output for Admins:-");
  print(rooms[1]); 
  print(rooms[2]); 
  print(rooms[3]);  
  print("");

  return flagAdded;
}