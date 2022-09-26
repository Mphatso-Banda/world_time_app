import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//we get http API from pub.dev to enable us process http requests in the app
import 'package:http/http.dart';
//import library to convert Json String
import 'dart:convert';
//package to help us format out date/time
import 'package:intl/intl.dart';

class WorldTime {
  late String location; //location name for th UI
  late String time; // the time in that location
  late String flag; //url to an asset flag icon
  late String url; //location url for api endpoint
  late bool isDayTime; //true or false if day time or not

  //add a constructor with named parameters
  WorldTime({required this.location, required this.flag, required this.url});

  //because we set async it's not gonna block any code #nonblocking
  //return Future<void> to use the await function when expectin the future value
  Future<void> getTime() async {

    //in case an error happens let's try to catch it
    try{

      //make a call to the end-point where we are  going to request our data
      //from the Worldtime API, we use Response type from HTTP package
      Response response =
      await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      //  convert the json string returned to a Map data object that we can use,
      //  using the 'dart:convert' library
      Map data = jsonDecode(response.body);
      // print(data);

      //  get properties from data
      String datetime = data['datetime'];
      //create a substring of the offset from position 1 to 3 (02)
      String offset = data['utc_offset'].substring(1, 3);
      // print(datetime);
      // print(offset);

      //  create a datetime object from the datetime string
      DateTime now = DateTime.parse(datetime);
      //to get the actual time in the city add the utc_offset by parsing it to int
      now = now.add(Duration(hours: int.parse(offset)));

      //convert now to a String and set it to the time variable
      // time = now.toString();

      //using the ternary operator to see if it's day or night
      isDayTime = now.hour > 6 && now.hour < 20 ? true : false;

    //  format now using util package and set it to time
      time = DateFormat.jm().format(now);

    }
    catch(e){
      if (kDebugMode) {
        print('caught error $e');
      }
    //  update the time variable in case the error happens
      time = 'could not get time data';
    }

  }
}
