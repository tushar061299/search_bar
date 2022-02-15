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

  String searchValue = '';

  List<dynamic> _users = [];
  List<dynamic> _foundUsers = [];
  final List<bool> _selected = List.generate(100, (i) => false);

  //Fetching Data From Api
  void fetchUsers() async {
    var response = await http.get(Uri.parse(apiurl));
    setState(() {
      _users = json.decode(response.body)['results'];
      _foundUsers = _users;
    });

    for (int i = 0; i < _users.length; i++) {
      _foundUsers[i]['name'] = _name(_users[i]);
      _foundUsers[i]['gender'] = _gender(_users[i]);
      _foundUsers[i]['location'] = _location(_users[i]);
    }
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

  //Highlighting The Searched Word

  List<TextSpan> highlightOccurrences(String source, String query) {
    // ignore: unnecessary_null_comparison
    if (query == null || query.isEmpty) {
      return <TextSpan>[TextSpan(text: source)];
    }

    final List<Match> matches = <Match>[];
    for (final String token in query.trim().toLowerCase().split(' ')) {
      matches.addAll(token.allMatches(source.toLowerCase()));
    }

    if (matches.isEmpty) {
      return <TextSpan>[TextSpan(text: source)];
    }
    matches.sort((Match a, Match b) => a.start.compareTo(b.start));

    int lastMatchEnd = 0;
    final List<TextSpan> children = <TextSpan>[];
    const Color matchColor = Colors.blue;
    for (final Match match in matches) {
      if (match.end <= lastMatchEnd) {
        // already matched -> ignore
      } else if (match.start <= lastMatchEnd) {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.end),
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: matchColor),
        ));
      } else {
        children.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),
        ));

        children.add(TextSpan(
          text: source.substring(match.start, match.end),
          style:
              const TextStyle(fontWeight: FontWeight.bold, color: matchColor),
        ));
      }

      if (lastMatchEnd < match.end) {
        lastMatchEnd = match.end;
      }
    }

    if (lastMatchEnd < source.length) {
      children.add(TextSpan(
        text: source.substring(lastMatchEnd, source.length),
      ));
    }

    return children;
  }

  // For Searching

  void _filter(String value) {
    searchValue = value;
    List<dynamic> suggestionList = [];
    setState(() {
      suggestionList = value.isEmpty
          ? _users
          : _users
              .where((element) =>
                  element['name'].toLowerCase().contains(value.toLowerCase()))
              .toList();

      _foundUsers = suggestionList;
    });
  }

  Future<void> _getData() async {
    setState(() {
      fetchUsers();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchUsers();
    super.initState();
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
                        padding: const EdgeInsets.all(0.0),
                        child: TextField(
                          onChanged: (value) => _filter(value),
                          decoration: const InputDecoration(
                            hintText: "Search user by ID, address, name..",
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.grey,
                              fontStyle: FontStyle.normal,
                            ),
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
                          ),
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
        child: _foundUsers.isNotEmpty
            ? RefreshIndicator(
                child: ListView.builder(
                  padding: const EdgeInsets.all(6),
                  itemCount: _foundUsers.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: RichText(
                        text: TextSpan(
                          children: highlightOccurrences(
                              _foundUsers[index]['name'], searchValue),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                      ),
                      subtitle: Text(_foundUsers[index]['location']),
                      trailing: Text(_foundUsers[index]['gender']),
                      tileColor: _selected[index] ? Colors.yellow[200] : null,
                      onTap: () =>
                          setState(() => _selected[index] = !_selected[index]),
                    );
                  },
                ),
                onRefresh: _getData,
              )
            : const Center(
                child: Text(
                  'No results found',
                  style: TextStyle(fontSize: 24),
                ),
              ),
      ),
    );
  }
}
