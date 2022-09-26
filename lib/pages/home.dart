import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  //initialize data variable to grab the data passed from loading widget
  Map data = {};

  @override
  Widget build(BuildContext context) {

    //we need to update the value of data in the build method because we have
    // to pass the 'context'
    /**use a ternary operator to check if data is empty or not, when it's empty the default instance
     * data will be passed from loading, when it is not empty it will be updated with data from
     * choose_location pop() method
    */
    data = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map;
    print(data);//prints to the console
    //now we can access all the data from the Map and print it in the home screen

    //set background
    String bgImage = data['isDayTime'] ? 'day.png' : 'night.png';
    Color? bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo[700];

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            //we'll use the box decoration to set the background image
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/$bgImage'),
                //to cover the whole screen
                fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
              child: Column(
                children: [
                  TextButton.icon(
                    //async coz we go to the location page to get some data and return back(pop) to
                    //this page with the data which takes some time to do (async) so we have to
                    //store that data in a Future dynamic variable using await since we are not sure
                    //of what data we are getting back
                    onPressed: () async{
                      //to navigate to location page
                      dynamic result = await Navigator.pushNamed(context, '/location');

                      //when we get back the new data from the choose location now we update the state
                      setState(() {
                        //update the data variable (Map)
                        data = {
                          'time': result['time'],
                          'location': result['location'],
                          'isDayTime': result['isDayTime'],
                          'flag': result['flag']
                        };
                      });
                    },
                    icon: Icon(Icons.edit_location, color: Colors.amberAccent[100],),
                    label: Text('Edit Location',
                      style: TextStyle(color: Colors.amberAccent[100]),),
                    ),
                  SizedBox(height: 20.0,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        data['location'],
                        style: TextStyle(
                          fontSize: 28.0,
                          letterSpacing: 2.0,
                          color: data['isDayTime'] ? Colors.black87 : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),

                  Text(
                    data['time'],
                    style: TextStyle(
                      fontSize: 66.0,
                      color: data['isDayTime'] ? Colors.black87 : Colors.grey[300],
                    ),
                  )

                ],
              ),
            ),
          ),

      ),
    );
  }
}
