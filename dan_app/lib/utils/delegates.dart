import 'package:dan_app/controllers/firestore_controller.dart';
import 'package:flutter/material.dart';

class FriendsSearchDelegate extends SearchDelegate<MapEntry<String, String>> {
  String result = '';
  Map<String, dynamic> users = <String, dynamic>{};

  bool resultsLoaded = false;

  @override
  List<Widget> buildActions(BuildContext context) {
    getUsers(context);
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(
          context,
          MapEntry('', ''),
        );
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    if (query != '')
      return Column(
        children: users.values
            .where((dynamic element) {
              return ((element as Map<String, dynamic>)['username']! as String)
                  .startsWith(query);
            })
            .map((dynamic element) => Card(
                  child: Text(
                      (element as Map<String, dynamic>)['username']! as String),
                ))
            .toList(),
      );
    else {
      return Container();
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query != '') {
      return Column(
        children: users.values
            .where((dynamic element) {
              return ((element as Map<String, dynamic>)['username']! as String)
                  .startsWith(query);
            })
            .map((dynamic element) => GestureDetector(
                  onTap: () {
                    close(
                      context,
                      MapEntry(
                          (element as Map<String, dynamic>)['uid']! as String,
                          element['username']! as String),
                    );
                  },
                  child: Card(
                    child: SizedBox(
                      width: 500,
                      height: 50,
                      child: Center(
                        child: Text((element
                            as Map<String, dynamic>)['username']! as String),
                      ),
                    ),
                  ),
                ))
            .toList(),
      );
    } else {
      return Container();
    }
  }

  Future<void> getUsers(BuildContext context) async {
    result = '';
    users = await FirestoreController.getUsers();
    resultsLoaded = true;
  }
}
