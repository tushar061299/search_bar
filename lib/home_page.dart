import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String apiurl = "https://randomuser.me/api/?results=100";

  List<dynamic> _users = [];

  void fetchUsers() async {
    var response = await http.get(Uri.parse(apiurl));
    setState(() {
      _users = json.decode(response.body)['results'];
    });
  }

  String _name(dynamic user) {
    return user['name']['title'] +
        " " +
        user['name']['first'] +
        " " +
        user['name']['last'];
  }

  String _location(Map<dynamic, dynamic> user) {
    return user['location']['country'];
  }

  String _gender(dynamic user) {
    return user['gender'];
  }

  Widget _buildList() {
    return RefreshIndicator(
      child: ListView.builder(
        padding: const EdgeInsets.all(6),
        itemCount: _users.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(_name(_users[index])),
            subtitle: Text(_location(_users[index])),
            trailing: Text(_gender(_users[index])),
          );
        },
      ),
      onRefresh: _getData,
    );
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    double x = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          Expanded(
            child: Column(
              children: [
                Container(
                  height: 50,
                  color: Colors.white,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: x * 0.03, right: x * 0.03, bottom: 2, top: 5),
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(0.0),
                      ),
                      child: Padding(
                        // ignore: prefer_const_constructors
                        padding: EdgeInsets.all(0.0),
                        child: TextField(
                          // ignore: prefer_const_constructors
                          decoration: InputDecoration(
                            hintText: "Search user by ID, address, name..",
                            // ignore: prefer_const_constructors
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                            ),
                            // ignore: prefer_const_constructors
                            prefixIcon:
                                // ignore: prefer_const_constructors
                                Icon(Icons.search, color: Colors.grey),
                          ),
                          onChanged: (value) {
                            //_filter(value);
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        child: _buildList(),
      ),
    );
  }
}
