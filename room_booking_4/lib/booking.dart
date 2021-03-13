import 'package:flutter/material.dart';
// ignore: implementation_imports
import 'package:flutter/src/widgets/basic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'home.dart';

class Booking extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking System'),
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
  final myController1 = TextEditingController(); // Name
  final myController2 = TextEditingController(); // Start Time
  final myController3 = TextEditingController(); // End Time

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
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              dropdownvalue + ' ' + dropdownvalue2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.blue[500],
                fontSize: 20,
              ),
            ),
          ),
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
          //print(name);
          String starttime = myController2.text;
          //print(starttime);
          String endtime = myController3.text;
          //print(endtime);
          int roomNumber = roomChecker(name, starttime, endtime, 'Y');
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text((() {
                  if (roomNumber != 0) {
                    return dropdownvalue +
                        " room no $roomNumber has been booked.";
                  } else {
                    return dropdownvalue +
                        " room is already booked for the time slot you chose. Try another slot";
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

var rooms = <String, Map>{
  'Football': {1: [], 2: [], 3: []},
  'Squash': {1: [], 2: [], 3: []},
  'Table Tennis': {1: [], 2: [], 3: []},
  'Basketball': {1: [], 2: [], 3: []},
};

int micros = 1;

int roomChecker(
    String name, String starttime, String endtime, String approval) {
  var start = DateTime.parse(starttime);
  //Adding microseconds to prevent isAfter from not working as intended
  start = start.add(new Duration(microseconds: micros));
  //print(start);
  var end = DateTime.parse(endtime);
  //Adding microseconds to prevent isAfter from not working as intended
  end = end.add(new Duration(microseconds: micros));
  //print(end);
  micros += 1;

  print("");
  int flagAdded = 0;
  int flagRoom = -1;
  for (var i = 1; i < 4; i++) {
    flagRoom = -1;
    for (var j = 0; j < rooms[dropdownvalue][i].length; j++) {
      if (((start.isAfter(rooms[dropdownvalue][i][j][0])) &&
              start.isBefore(rooms[dropdownvalue][i][j][1])) ||
          ((end.isAfter(rooms[dropdownvalue][i][j][0])) &&
              end.isBefore(rooms[dropdownvalue][i][j][1])) ||
          (((start.isAfter(rooms[dropdownvalue][i][j][0])) &&
                  start.isBefore(end)) &&
              end.isBefore(rooms[dropdownvalue][i][j][1]))) {
        flagRoom = j;
        break;
      } else {
        continue;
      }
    }

    if (approval == 'Y') {
      if (flagRoom == -1) {
        rooms[dropdownvalue][i] = rooms[dropdownvalue][i] +
            [
              [start, end]
            ];
        flagAdded = i;
        break;
      }
    }
  }

  print("Output for User:-");
  if (flagAdded != 0) {
    print(dropdownvalue + " room number $flagAdded booked");
    print("");
    //print(rooms[dropdownvalue][1]);
    String roomi = "$flagAdded";
    //print(roomi);
    ssubmitForm(name, starttime, endtime, roomi, 'Y');

    //print(dropdownvalue);
    //print(dropdownvalue2);
  } else {
    print("Room cannot be booked. Try another slot.");
    print("");
  }

  print("****************************");
  print("Output for Admins:-");
  print(rooms[dropdownvalue][1]);
  print(rooms[dropdownvalue][2]);
  print(rooms[dropdownvalue][3]);
  print("");
  print("****************************");
  return flagAdded;
}

class TimeForm {
  String name;
  String start;
  String end;
  String room;
  String sport;
  String type;
  String approval;

  TimeForm(this.name, this.start, this.end, this.room, this.sport, this.type,
      this.approval);

  factory TimeForm.fromJson(dynamic json) {
    return TimeForm(
        "${json['name']}",
        "${json['start']}",
        "${json['end']}",
        "${json['room']}",
        "${json['sport']}",
        "${json['type']}",
        "${json['approval']}");
  }

  // Method to make GET parameters. (Added approval too)
  Map toJson() => {
        'name': name,
        'start': start,
        'end': end,
        'room': room,
        'sport': sport,
        'type': type,
        'approval': approval
      };
}

class FormController {
  // Google App Script Web URL.
  static const String URL =
      "https://script.google.com/macros/s/AKfycbz2EAI07F78QdMirZSwM9S6qUFVxXIM8vnYFtfYfgACy816j54xLPIGJixJktrvas0-fA/exec";

  // Success Status Message
  static const STATUS_SUCCESS = "SUCCESS";

  /// Async function which saves feedback, parses form parameters and sends HTTP GET request on url. On successful response, callback is called.
  void submitForm(TimeForm timeform, void Function(String) callback) async {
    try {
      await http.post(URL, body: timeform.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          //print(url);
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

  /// Async function which loads feedback from endpoint URL and returns List.
  Future<List<TimeForm>> getFeedbackList() async {
    return await http.get(URL).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      return jsonFeedback.map((json) => TimeForm.fromJson(json)).toList();
    });
  }
}

void ssubmitForm(
    String name, String start, String end, String room, String approval) {
  TimeForm timeform =
      TimeForm(name, start, end, room, dropdownvalue, dropdownvalue2, approval);

  FormController formController = FormController();

  // Submit 'timeform' and save it in Google Sheets.
  if (approval == 'Y') {
    formController.submitForm(timeform, (String response) {
      print("Response: $response");
      if (response == FormController.STATUS_SUCCESS) {
        // Feedback is saved succesfully in Google Sheets.
        print("Data Submitted");
      } else {
        // Error Occurred while saving data in Google Sheets.
        print("Error Occurred!");
      }
    });
  }
}
