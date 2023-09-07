import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<dynamic, dynamic>? data; // Make it nullable

  @override
  Widget build(BuildContext context) {
    // Use the null-aware operator ?. to access arguments safely
    data = data?.isNotEmpty == true
        ? data
        : ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;

    if (data == null) {
      // Handle the case where arguments are null
      // You can provide a default value or display an error message
      print('No data received from the previous screen');
      // For example, set a default value for data
      data = {'location': 'Unknown', 'flag': 'unknown.png', 'time': 'Unknown'};
    } else {
      print(data);
    }

    // Check if data['isDaytime'] is not null before accessing it
    bool isDaytime = data?['isDaytime'] == true;

    // Set Background
    String bgImage = isDaytime ? 'day.jpg' : 'night.jpg';
    Color? bgColor = isDaytime ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image:
                  AssetImage(bgImage), // Use the dynamically calculated bgImage
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    dynamic result =
                        await Navigator.pushNamed(context, '/location');
                    if (result != null) {
                      setState(() {
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDaytime': result['isDaytime'],
                          'flag': result['flag'],
                        };
                      });
                    }
                  },
                  icon: Icon(
                    Icons.edit_location,
                    color: Colors.grey[300],
                  ),
                  label: Text(
                    'Edit Location',
                    style: TextStyle(color: Colors.grey[300]),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      data?['location'] ??
                          'Unknown', // Use null-aware operator and provide a default value
                      style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: Colors.white),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                Text(
                  data?['time'] ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 66,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
