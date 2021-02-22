import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

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
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text(((){
                  if(roomNumber != 0){
                    return "Room no $roomNumber has been booked.";
                  }
                  else{
                    return "Room cannot be booked. Try another slot";
                  }
                }())),
              );
            },
          );
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

int micros = 1;

int roomChecker(String name, String starttime, String endtime){
  var start = DateTime.parse(starttime);  
  //Adding microseconds to prevent isAfter from not working as intended
  start = start.add(new Duration(microseconds: micros));
  print(start);
  var end = DateTime.parse(endtime); 
  //Adding microseconds to prevent isAfter from not working as intended
  end = end.add(new Duration(microseconds: micros));
  print(end);
  micros += 1;

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

  print("Output for User:-");
  if(flagAdded != 0){
    print("Room number $flagAdded booked");
    print("");
    String roomi = "$flagAdded";
    print(roomi);
    ssubmitForm(name, starttime, endtime, roomi);
  }
  else{
    print("Room cannot be booked. Try another slot.");
    print("");
  }

  print("Output for Admins:-");
  print(rooms[1]); 
  print(rooms[2]); 
  print(rooms[3]);  
  print("");

  return flagAdded;
}

class TimeForm {
  String name;
  String start;
  String end;
  String room;

  TimeForm(this.name, this.start, this.end, this.room);

  factory TimeForm.fromJson(dynamic json) {
    return TimeForm("${json['name']}", "${json['start']}", "${json['end']}", "${json['room']}");
  }

  // Method to make GET parameters.
  Map toJson() => {
        'name': name,
        'start': start,
        'end': end,
        'room' : room
      };
}

class FormController {  
  // Google App Script Web URL.
  static const String URL = "https://script.google.com/macros/s/AKfycbwcL7DLnLHjLoWAxWrNjVs_iLZTLyd69OpfIrd1CEyDIZo7wA7YPoWlqQ/exec";
  
  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses form parameters and sends HTTP GET request on url. On successful response, callback is called.
  void submitForm( TimeForm timeform, void Function(String) callback) async {
    try {
      await http.post(URL, body: timeform.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          print(url);
          await http.get(url).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          //print("yo");
          //print(response.body);
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
      //print("meow");
    }
  }
}

void ssubmitForm(String name, String start, String end, String room) {
  TimeForm timeform = TimeForm(name, start, end, room);

  FormController formController = FormController();

  // Submit 'timeform' and save it in Google Sheets.
  formController.submitForm(timeform, (String response) {
    print("Response: $response");
    if (response == FormController.STATUS_SUCCESS) {
      // Feedback is saved succesfully in Google Sheets.
      print("Feedback Submitted");
    } else {
      // Error Occurred while saving data in Google Sheets.
      print("Error Occurred!");
    }
  });
}