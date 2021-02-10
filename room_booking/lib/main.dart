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
              onPressed: () => {
                if (volleyRoom1[11] == true)
                  {
                    volleyRoom1[11] = false,
                    print('You have booked slot 1 of Room 1')
                  }
                else if (volleyRoom2[11] == true)
                  {
                    volleyRoom2[11] = false,
                    print('You have booked slot 1 of Room 2')
                  }
                else if (volleyRoom3[11] == true)
                  {
                    volleyRoom3[11] = false,
                    print('You have booked slot 1 of Room 3')
                  }
                else
                  {print('No room available right now.')}
              },
              child: Text('11:00 to 12:00'),
              color: Colors.blue[500],
            ),
            new FlatButton(
              onPressed: () => {
                if (volleyRoom1[12] == true)
                  {
                    volleyRoom1[12] = false,
                    print('You have booked slot 2 of Room 1')
                  }
                else if (volleyRoom2[12] == true)
                  {
                    volleyRoom2[12] = false,
                    print('You have booked slot 2 of Room 2')
                  }
                else if (volleyRoom3[12] == true)
                  {
                    volleyRoom3[12] = false,
                    print('You have booked slot 2 of Room 3')
                  }
                else
                  {print('No room available right now.')}
              },
              child: Text('12:00 to 13:00'),
              color: Colors.blue[500],
            ),
            new FlatButton(
              onPressed: () => {
                if (volleyRoom1[13] == true)
                  {
                    volleyRoom1[13] = false,
                    print('You have booked slot 3 of Room 1')
                  }
                else if (volleyRoom2[13] == true)
                  {
                    volleyRoom2[13] = false,
                    print('You have booked slot 3 of Room 2')
                  }
                else if (volleyRoom3[13] == true)
                  {
                    volleyRoom3[13] = false,
                    print('You have booked slot 3 of Room 3')
                  }
                else
                  {print('No room available right now.')}
              },
              child: Text('13:00 to 14:00'),
              color: Colors.blue[500],
            ),
          ],
        ));
  }
}

var volleyRoom1 = <num, bool>{
  11: true,
  12: true,
  13: true,
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
