import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedDay;
  TimeOfDay? selectedTime;
  String? selectedActivity;

  final List<String> days = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];
  final List<String> activities = [
    'Wake up',
    'Go to gym',
    'Breakfast',
    'Meetings',
    'Lunch',
    'Quick nap',
    'Go to library',
    'Dinner',
    'Go to sleep'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        title: Padding(
          padding: EdgeInsets.only(top: 28.0),
          child: Text('Remainder App!',
              style: GoogleFonts.poppins(
                  fontSize: 28, fontWeight: FontWeight.w400)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Text(
            //   'Hello, User\nWelcome to your personalized Remainder App!\n\nSelect the Day, Time and The activity to be reminded',
            //   style: GoogleFonts.poppins(
            //       fontSize: 18, fontWeight: FontWeight.normal),
            // ),
            RichText(
              text: TextSpan(
                style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontSize: 18,
                    fontWeight: FontWeight.normal),
                children: <TextSpan>[
                  TextSpan(text: 'Hello, User\n'),
                  TextSpan(
                      text: 'Welcome to your personalized remainder app!\n'),
                  TextSpan(
                      text:
                          'Please select the Day,Time and the Activity to be reminded for.\n',
                      style: GoogleFonts.poppins(fontSize: 14))
                ],
              ),
            ),
            // Day dropdown
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Select Day',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w400)),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(color: Colors.grey, width: 1))),
                    child: DropdownButton<String>(
                      value: selectedDay,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDay = newValue;
                        });
                      },
                      items: days.map<DropdownMenuItem<String>>((String day) {
                        return DropdownMenuItem<String>(
                          value: day,
                          child: Text(day),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            // Time picker
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Time',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400)),
                ElevatedButton(
                  onPressed: () async {
                    TimeOfDay? time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        selectedTime = time;
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5))),
                  child: Text(
                      selectedTime != null
                          ? selectedTime!.format(context)
                          : 'Select Time',
                      style: GoogleFonts.poppins(
                          fontSize: 20, fontWeight: FontWeight.w400)),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Activity dropdown
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Select Activity',
                    style: GoogleFonts.poppins(
                        fontSize: 20, fontWeight: FontWeight.w400)),
                Container(
                  decoration: BoxDecoration(
                      border: Border(
                          bottom: BorderSide(color: Colors.grey, width: 1))),
                  child: DropdownButton<String>(
                    value: selectedActivity,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedActivity = newValue;
                      });
                    },
                    items: activities
                        .map<DropdownMenuItem<String>>((String activity) {
                      return DropdownMenuItem<String>(
                        value: activity,
                        child: Text(activity),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),

            SizedBox(height: 80),

            ElevatedButton(
              onPressed: () {
                if (selectedDay != null &&
                    selectedTime != null &&
                    selectedActivity != null) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Reminder set for $selectedActivity on $selectedDay at ${selectedTime!.format(context)}'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Please complete all fields'),
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2))),
              child: Text('Set Reminder',
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w400)),
            ),
          ],
        ),
      ),
    );
  }
}
