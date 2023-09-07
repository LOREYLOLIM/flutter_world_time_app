import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  String location; // location name for the UI
  String time = ''; // time in that location, initialized to an empty string
  String flag; // url to asset flag icon
  String url; // location URL for API endpoints
  bool isDaytime; // true or false if day time or not

  WorldTime({required this.location, required this.flag, required this.url})
      : isDaytime = true;

  Future<void> getTime() async {
    // World time make request

    try {
      Response response = await get(
          Uri.parse('https://timeapi.io/api/Time/current/zone?timeZone=$url'));
      Map data = jsonDecode(response.body);
      // print(data);
      // get properties from data
      String dateTime = data['dateTime'];
      String timeZone = data['timeZone'];
      // print(dateTime);
      // print(timeZone);

      // create DateTime
      DateTime now = DateTime.parse(dateTime);
      // print(now);

      // Set time property
      isDaytime = now.hour > 6 && now.hour < 20 ? true : false;
      time = DateFormat.jm()
          .format(now); // Format the DateTime object to a time string
    } catch (e) {
      print('Caught Error, $e');
      time = 'could not get time data';
    }
  }
}
