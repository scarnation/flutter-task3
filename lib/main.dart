import 'dart:convert';
import 'package:task3/API.dart';
import 'package:task3/User.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Http App',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: MyListScreen(),
    );
  }
}

class MyListScreen extends StatefulWidget {
  @override
  createState() => _MyListScreenState();
}

class _MyListScreenState extends State {
  var users = new List<User>();

  _getUsers() {
    API.getUsers().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        users = list.map((model) => User.fromJson(model)).toList();
      });
    });
  }

  initState() {
    super.initState();
    _getUsers();
  }

  dispose() {
    super.dispose();
  }

  @override
  build(context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Oscar's List"),
        ),
        body: ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(users[index].name),
              // When a user taps the ListTile, navigate to the DetailScreen.
              // Notice that you're not only creating a DetailScreen, you're
              // also passing the current users to it.
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(users: users[index]),
                  ),
                );
              },
            );
          },
        ),
        );
  }
}

class DetailScreen extends StatelessWidget {
  // Declare a field that holds the User.
  final User users;

  // In the constructor, require a User.
  DetailScreen({Key key, @required this.users}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the User to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(users.name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text(users.name),
            Text(users.email),

          ],
        )

      ),
    );
  }
}
