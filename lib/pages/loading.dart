import 'package:flutter/material.dart';
import 'package:world_time/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';// package for Loader

class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  late WorldTime defaultInstance;

  //create a new instance of the world time class
  //to use await in a function declare it as asynchronous
  void setupWorldTime() async {
    WorldTime instance = defaultInstance;
    //getTime() is an async and returns a Future value of type void
    await instance.getTime();
    // print(instance.time);

    //  once we get data from await we redirect to home page
    //the pushReplacementNamed() is going to push and replace(pop) the loading widget
    //to pass data to another route pass in a third parameter arguments as a Map object
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flag,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //set the default WorldTime instance when the app is started
    defaultInstance = WorldTime(
        location: 'Malawi', flag: 'malawi.png', url: 'Africa/Blantyre');
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.black54,
          size: 80.0,
        ),
      ),
    );
  }
}
