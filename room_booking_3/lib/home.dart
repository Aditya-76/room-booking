import 'package:flutter/material.dart';
import 'booking.dart';

String dropdownvalue = 'Squash';
String dropdownvalue2 = 'Room';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking System'),
        centerTitle: true,
        //backgroundColor: Colors.deepPurple,
      ),
      body: MyHomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Booking()),
          );
        },
        child: Text('Next'),
        backgroundColor: Colors.blue[500],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            margin: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.blue[600] ),
            ),
            child: DropdownButtonHideUnderline(
              child:  DropdownButton<String>(  
                value: dropdownvalue,  
                icon: Icon(Icons.arrow_drop_down),  
                iconSize: 25,  
                elevation: 16,  
                style: TextStyle(
                  fontSize: 18, color: 
                  Colors.blue[500], 
                ),  
                focusColor: Colors.blue[500],
                onChanged: (String newValue) {  
                  setState(() {  
                    print(newValue);  
                    dropdownvalue = newValue;  
                  });  
                },  
                items: <String>["Squash", "Football", "Table Tennis", "Basketball"]  
                    .map<DropdownMenuItem<String>>((String val) {  
                  // ignore: missing_required_param  
                  return DropdownMenuItem<String>(  
                    value: val,  
                    child: Text(val),  
                  );  
                }).toList(),  
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.center,
            margin: const EdgeInsets.all(16.0),
            height: 65,
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.blue[600] ),
            ),
            child: DropdownButtonHideUnderline(
              child:  DropdownButton<String>(  
                value: dropdownvalue2,  
                icon: Icon(Icons.arrow_drop_down),  
                iconSize: 25,  
                elevation: 16,  
                style: TextStyle(fontSize: 18, color: Colors.blue[500]),
                onChanged: (String newValue) {  
                  setState(() {  
                    print(newValue);  
                    dropdownvalue2 = newValue;  
                  });  
                },  
                items: <String>["Room"]  
                    .map<DropdownMenuItem<String>>((String val) {  
                  // ignore: missing_required_param  
                  return DropdownMenuItem<String>(  
                    value: val,  
                    child: Text(val),  
                  );  
                }).toList(),  
              ),
            ),
          ),
        ],
      ),
    );
  }
}
