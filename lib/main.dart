// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MyHomePage(title: "ALKU Mobile"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title});
  final imageName = [
    "Assets/slider/slider1.jpg",
    "Assets/slider/slider2.jpg",
    "Assets/slider/slider3.jpg",
    "Assets/slider/slider4.jpg",
    "Assets/slider/slider5.jpg",
    "Assets/slider/slider6.jpg",
    "Assets/slider/slider7.jpg"
  ];
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: const Icon(Icons.notifications),
              onPressed: () {},
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              width: 500,
              child: Text(
                "News and Events",
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
            ),
            Container(
              child: CarouselSlider(
                options: CarouselOptions(
                  height: 200.0,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  pauseAutoPlayOnTouch: true,
                  aspectRatio: 50.0,
                  enlargeCenterPage: true,
                ),
                items: widget.imageName.map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(i),
                      );
                    },
                  );
                }).toList(),
              ),
              color: Colors.blue[100],
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 100, 0, 50),
                child: Column(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BusRoutesFromJson()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                40.0, 40.0, 40.0, 40.0),
                            decoration: BoxDecoration(
                              color: Colors.red[400],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "Bus Routes",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DiningDetailsFromJson()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 40.0, 30.0, 40.0),
                            decoration: BoxDecoration(
                              color: Colors.green[400],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "Cafeteria Menu",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                    SizedBox(
                      height: 50.0,
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TeachersFromAPI()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                30.0, 40.0, 30.0, 40.0),
                            decoration: BoxDecoration(
                              color: Colors.blue[400],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "Academic Staff",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ExamResultsFromAPI()),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(
                                40.0, 40.0, 40.0, 40.0),
                            decoration: BoxDecoration(
                              color: Colors.amber[400],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Text(
                              "Exam Results",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    ),
                  ],
                ))
          ],
        ));
  }
}

class DiningDetails {
  int? id;
  String? name, date, soap, maindish, garniture, catering;
  DiningDetails(
      {this.id,
      this.name,
      this.date,
      this.soap,
      this.maindish,
      this.garniture,
      this.catering});
  DiningDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    date = json['date'];
    soap = json['soap'];
    maindish = json['maindish'];
    garniture = json['garniture'];
    catering = json['catering'];
  }
}

class _DiningDetailsFromJsonState extends State<DiningDetailsFromJson> {
  List<DiningDetails> diningList = [];

  Future getDiningDetailsFromJson() async {
    final String response =
        await rootBundle.loadString('Assets/data/diner.json');
    final data = json.decode(response);

    setState(() {
      for (var a in data["diningHours"]) {
        diningList.add(DiningDetails.fromJson(a));
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getDiningDetailsFromJson();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Dining Details'),
        centerTitle: true,
      ),
      body: Card(
        child: ListView.builder(
          itemCount: diningList.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(diningList[i].garniture!.toString()),
              subtitle: Text(diningList[i].soap!.toString()),
              trailing: Text(diningList[i].date!.toString()),
              leading: CircleAvatar(
                child: Icon(Icons.restaurant),
              ),
            );
          },
        ),
      ),
    );
  }
}

class DiningDetailsFromJson extends StatefulWidget {
  @override
  _DiningDetailsFromJsonState createState() => _DiningDetailsFromJsonState();
}

class Teacher {
  final String? name;
  final String? email;
  final String? userName;

  Teacher({this.name, this.email, this.userName});

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      name: json['name'],
      email: json['email'],
      userName: json['username'],
    );
  }
}

class _TeachersFromAPIState extends State<TeachersFromAPI> {
  Future getUserData() async {
    var response =
        await http.get(Uri.https('jsonplaceholder.typicode.com', 'users'));
    var jsonData = jsonDecode(response.body);
    List<Teacher> users = [];
    for (var u in jsonData) {
      Teacher user =
          Teacher(name: u['name'], email: u['email'], userName: u['username']);
      users.add(user);
    }
    return users;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Staff'),
        centerTitle: true,
      ),
      body: Card(
        child: FutureBuilder(
          future: getUserData(),
          builder: (context, snaphot) {
            if (snaphot.data == null) {
              return const Center(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: snaphot.data.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(snaphot.data[i].name),
                      subtitle: Text(snaphot.data[i].email),
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class TeachersFromAPI extends StatefulWidget {
  @override
  _TeachersFromAPIState createState() => _TeachersFromAPIState();
}

class ExamResultModel {
  int? id;
  int? result;
  String? exam;
  String? course;
  ExamResultModel({this.id, this.result, this.exam, this.course});
  ExamResultModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    result = json['result'];
    exam = json['exam'];
    course = json['course'];
  }
}

class _ExamResultsFromAPIState extends State<ExamResultsFromAPI> {
  List<ExamResultModel> examResults = [];

  Future getResultsFromJson() async {
    final String response =
        await rootBundle.loadString('Assets/data/examResult.json');
    final data = json.decode(response);

    setState(() {
      for (var a in data["examresults"]) {
        examResults.add(ExamResultModel.fromJson(a));
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getResultsFromJson();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Results'),
        centerTitle: true,
      ),
      body: Card(
        child: ListView.builder(
          itemCount: examResults.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(examResults[i].course!.toString()),
              subtitle: Text(examResults[i].exam!.toString()),
              trailing: Text(examResults[i].result!.toString()),
              leading: CircleAvatar(
                child: Icon(Icons.book),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ExamResultsFromAPI extends StatefulWidget {
  @override
  _ExamResultsFromAPIState createState() => _ExamResultsFromAPIState();
}

class BusRoutes {
  int? id;
  String? route, number, hour;
  BusRoutes({this.id, this.number, this.route, this.hour});
  BusRoutes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    number = json['number'];
    route = json['route'];
    hour = json['hour'];
  }
}

class _BusRoutesFromJsonState extends State<BusRoutesFromJson> {
  List<BusRoutes> busList = [];

  Future getBusRoutesFromJson() async {
    final String response = await rootBundle.loadString('Assets/data/bus.json');
    final data = json.decode(response);

    setState(() {
      for (var a in data["busses"]) {
        busList.add(BusRoutes.fromJson(a));
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await getBusRoutesFromJson();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bus Routes'),
        centerTitle: true,
      ),
      body: Card(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: ListView.builder(
          itemCount: busList.length,
          itemBuilder: (context, i) {
            return ListTile(
              title: Text(busList[i].number!.toString()),
              subtitle: Text(busList[i].route!.toString()),
              trailing: Text(busList[i].hour!.toString()),
              leading: CircleAvatar(
                child: Icon(Icons.directions_bus),
              ),
            );
          },
        ),
      ),
    );
  }
}

class BusRoutesFromJson extends StatefulWidget {
  @override
  _BusRoutesFromJsonState createState() => _BusRoutesFromJsonState();
}
