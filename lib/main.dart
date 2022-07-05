import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false
      ,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int pageIndex = 0;
List<Marker> _markers = <Marker>[
  Marker(markerId: MarkerId('1'),
  position: LatLng(37.42796133580664,-122.085749655962)),
];
  final pages = [
     Container(),
     Container(),
     Container(),
     Container(),
  ];
  late Position _currentPosition;
  String _currentAddress ='';
  _getCurrentLocation() async {
    LocationPermission permission; permission = await Geolocator.requestPermission();
    Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best, )
        .then((Position position) {

      setState(() {
        _currentPosition = position;
        _getAddressFromLatLng();
      });
    }).catchError((e) {
      print(e);
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude,
          _currentPosition.longitude
      );

      Placemark place = placemarks[0];
      setState(() {
        _currentAddress = "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentLocation();
    Future.delayed(const Duration(seconds: 4), () async {
      _markers.add(Marker(markerId: MarkerId('2'),position: LatLng(_currentPosition.latitude,_currentPosition.latitude),
          infoWindow: InfoWindow(title: 'My Current Location')));
      CameraPosition cameraPosition = CameraPosition(
        zoom: 14,
        target: LatLng(_currentPosition.latitude,_currentPosition.latitude),);
final GoogleMapController controller = await _controller.future;
controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
      setState(() {

      });

    });



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(8), // Set this height
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            ],
          ),
        ),
      ),


      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 7),
        child: SingleChildScrollView(
          child: Container(
            height: 700,
            child: Column(
              children: <Widget>[
                Container(
                  width: 500,
                  padding: EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Image.asset("assets/1.png",height: 35,width: 35,),
                            Text(_currentAddress),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(

                          children: [
                            Image.asset("assets/search.png",height: 40,width: 40,),
                            SizedBox(width: 2,),
                            Image.asset("assets/msg.png",height: 40,width: 40,),
                            SizedBox(width: 2,),
                            Image.asset("assets/dp.png",height: 30,width: 30,),
                            SizedBox(width: 6,),
                          ],
                        ),
                      )



                    ],
                  ),
                ),
                Container(
                  height: 120,
                  width: 600,
                  child: Column(
                    children: [

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Container(
                          child:            Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: AssetImage(
                                              'assets/123.png'),
                                          fit: BoxFit.fill,
                                        ),
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Container(
                                      width: 200,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Update Profile",style: TextStyle(fontWeight: FontWeight.w500),)),
                                          Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text("Enter your details to get more jobs",style: TextStyle(fontWeight: FontWeight.w300,fontSize: 11),)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),


                              Container(
                                width: 58,
                                height: 30,

                                child: OutlinedButton(
                                  onPressed: (){},
                                  style: ButtonStyle(
                                    side: MaterialStateProperty.all(BorderSide(
                                      color: Colors.green,
                                    )),
                                    overlayColor: MaterialStateProperty.all(Colors.green),
                                    backgroundColor: MaterialStateProperty.all(Colors.grey.shade200),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                                        )),
                                  ),
                                  child: Text("Skip",style: TextStyle(color: Colors.green,fontSize: 12,fontWeight: FontWeight.w500,),),
                                ),

                              ),



                            ],
                          ),

                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20)
                            ),

                            child: Row(
                              children: [

                                Container(
                                  padding: EdgeInsets.only(left: 40),

                                  width: 280,
                                  height: 10,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    child: LinearProgressIndicator(
                                      value: 0.7,
                                      valueColor: AlwaysStoppedAnimation<Color>(Color(0xff00ff00)),
                                      backgroundColor: Color(0xffD6D6D6),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("50%",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),)
                              ],
                            ),
                          )
                    ],
                  ),



                          height: 120,
                          width: 400,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4)
                          ),
                        ),
                      ),



                    ],
                  ),





                  decoration: BoxDecoration(

                    borderRadius: BorderRadius.circular(10)
                  ),
                ),
                SizedBox(height: 20,),

                Container(
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Text("Create Folio",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,),),
                          )),
                      SizedBox(height: 10,),
                      Container(
                        width: 500,
                        height: 32,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Container(

                             child: OutlinedButton(
                               onPressed: (){},
                               style: ButtonStyle(
                                 side: MaterialStateProperty.all(BorderSide(
                                   color: Colors.green,
                                 )),
                                 backgroundColor: MaterialStateProperty.all(Colors.green.shade50),
                                 shape: MaterialStateProperty.all(
                                     RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                                     )),
                               ),
                               child: Text("Create Folio",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,),),
                             ),

                            ),
                            SizedBox(width: 7,
                            ),
                            Stack(
                              children:[ Container(
                                child: CircleAvatar(
                                  radius: 48, // Image radius
                                  backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKrrBL83FsNgXZQyJMgpcN4Kc_lagonOHowg&usqp=CAU'),
                                ),
                                height: 32,
                                  width: 32,
                                decoration: BoxDecoration(

                                  shape: BoxShape.circle
                                ),
                              ),
                                Padding(
                                  padding: EdgeInsets.only(top: 28,left: 30),
                                  child: Container(
                                    height: 8,
                                    width: 8,
                                    decoration: BoxDecoration(
                                        color: Colors.lightGreen,
                                        shape: BoxShape.circle
                                    ),
                                  ),
                                ),
    ]
                            ),
                            SizedBox(width: 2,),
                            Stack(
                                children:[ Container(
                                  child: CircleAvatar(
                                    radius: 48, // Image radius
                                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKrrBL83FsNgXZQyJMgpcN4Kc_lagonOHowg&usqp=CAU'),
                                  ),
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(

                                      shape: BoxShape.circle
                                  ),
                                ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 28,left: 30),
                                    child: Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                            SizedBox(width: 2,),
                            Stack(
                                children:[ Container(
                                  child: CircleAvatar(
                                    radius: 48, // Image radius
                                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKrrBL83FsNgXZQyJMgpcN4Kc_lagonOHowg&usqp=CAU'),
                                  ),
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(

                                      shape: BoxShape.circle
                                  ),
                                ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 28,left: 30),
                                    child: Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                            SizedBox(width: 2,),
                            Stack(
                                children:[ Container(
                                  child: CircleAvatar(
                                    radius: 48, // Image radius
                                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKrrBL83FsNgXZQyJMgpcN4Kc_lagonOHowg&usqp=CAU'),
                                  ),
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(

                                      shape: BoxShape.circle
                                  ),
                                ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 28,left: 30),
                                    child: Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                            SizedBox(width: 2,),
                            Stack(
                                children:[ Container(
                                  child: CircleAvatar(
                                    radius: 48, // Image radius
                                    backgroundImage: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKrrBL83FsNgXZQyJMgpcN4Kc_lagonOHowg&usqp=CAU'),
                                  ),
                                  height: 32,
                                  width: 32,
                                  decoration: BoxDecoration(

                                      shape: BoxShape.circle
                                  ),
                                ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 28,left: 30),
                                    child: Container(
                                      height: 8,
                                      width: 8,
                                      decoration: BoxDecoration(
                                          color: Colors.lightGreen,
                                          shape: BoxShape.circle
                                      ),
                                    ),
                                  ),
                                ]
                            ),
                            Padding(
                              padding: EdgeInsets.all(4),
                              child: Container(
                                child: Center(
                                  child:
                                  Text("View All",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12,color: Colors.black),)
                                ),
                                height: 20,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(20)
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  height: 70,
                  width: 600,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10)
                  ),
                ),
                Divider(
                  color: Colors.grey.shade300,
                  thickness: 1.0,
                ),
                SizedBox(height:20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 80,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/123.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.rectangle,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 130,

                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                  child: Text("Alina Johnsan",style: TextStyle(fontWeight: FontWeight.w500),)),
                              Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text("Sr. UX Designer",style: TextStyle(fontWeight: FontWeight.w300),)),
                              Align(    alignment: Alignment.centerLeft,

                                  child: Text("10h Ago",style: TextStyle(fontWeight: FontWeight.w300),))
                            ],
                          ),
                        )
                      ],
                    ),

                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              'assets/1234.png'),
                          fit: BoxFit.fill,
                        ),
                        shape: BoxShape.rectangle,
                      ),
                    ),






                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: GoogleMap(
                    markers:Set<Marker>.of(_markers) ,

                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                    zoomControlsEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },

                  ),
                  height: 150,
                  width: 500,
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text("Apply Your Designation Related Jobs",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,),),
                    Text("Suggestions",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,),),
                  ],
                ),
                SizedBox(height: 10,),
                Container(
                  height: 85,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index){
                    return     Padding(
                      padding: EdgeInsets.all(2),
                      child: Container(
                        child:             Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Container(
                                    height: 80,
                                    width: 80,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/123.png'),
                                        fit: BoxFit.fill,
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10),
                                    width: 130,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Alina Johnsan",style: TextStyle(fontWeight: FontWeight.w500),)),
                                        Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text("Sr. UX Designer",style: TextStyle(fontWeight: FontWeight.w300),)),
                                        Align(    alignment: Alignment.centerLeft,

                                            child: Text("10h Ago",style: TextStyle(fontWeight: FontWeight.w300),))
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),


                            Container(
                              width: 100,

                              child: OutlinedButton(
                                onPressed: (){},
                                style: ButtonStyle(
                                  side: MaterialStateProperty.all(BorderSide(
                                    color: Colors.green,
                                  )),
                                  overlayColor: MaterialStateProperty.all(Colors.green),
                                  backgroundColor: MaterialStateProperty.all(Colors.grey.shade200),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8),
                                      )),
                                ),
                                child: Text("Apply",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w300,),),
                              ),

                            ),



                          ],
                        ),
                        height: 120,
                        width: 400,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4)
                        ),
                      ),
                    );
                  }


                  ),
                )





              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:new BottomNavigationBar(
        unselectedLabelStyle: TextStyle(color: Colors.grey.shade300),
        fixedColor: Colors.grey.shade600,
        type: BottomNavigationBarType.fixed,

        items: <BottomNavigationBarItem>[
          new BottomNavigationBarItem(
              icon: Image.asset("assets/Frame.png",height: 20,width: 20,),
            label: "Feed",

          ),
          new BottomNavigationBarItem(
              icon: Image.asset("assets/Frame-1.png",height: 20,width: 20,),
              label: "dev"
          ),
          new BottomNavigationBarItem(
              icon: Image.asset("assets/Frame-3.png",height: 20,width: 20,),
              label: "dev"

          ),
          new BottomNavigationBarItem(
              icon: Image.asset("assets/Frame-2.png",height: 20,width: 20,),
              label: "dev"

          ),
          new BottomNavigationBarItem(
              icon: Image.asset("assets/Frame-4.png",height: 30,width: 30,),
              label: "dev"

          )
        ],
        currentIndex: pageIndex,
        onTap: (int i){setState((){pageIndex = i;});},
      ),
    );
  }
}
