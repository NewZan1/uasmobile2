import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uasmobile2/models/match.dart';
import 'package:uasmobile2/services/database_services.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final TextEditingController _textEditingControllerMatch =
      TextEditingController();
  final TextEditingController _textEditingControllerScore =
      TextEditingController();

  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
      floatingActionButton: FloatingActionButton(
        onPressed: _displayTextInputDialog,
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildUI() {
    return SafeArea(
        child: Column(
      children: [
        _messagesListView(),
      ],
    ));
  }

  Widget _messagesListView() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.80,
      width: MediaQuery.sizeOf(context).width,
      child: StreamBuilder(
          stream: _databaseService.getMatches(),
          builder: (context, snapshot) {
            List matches = snapshot.data?.docs ?? [];
            if (matches.isEmpty) {
              return const Center(
                child: Text("No Matches in This Time"),
              );
            }
            return ListView.builder(
              itemCount: matches.length,
              itemBuilder: (context, index) {
                Matches match = matches[index].data();
                String matchId = matches[index].id;
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: ListTile(
                    tileColor: Theme.of(context).colorScheme.primaryContainer,
                    title: Text(match.match),
                    subtitle: Text(match.score),
                    trailing: Checkbox(
                      value: match.isDone,
                      onChanged: (value) {
                        Matches updatedMatches =
                            match.copyWith(isDone: !match.isDone);
                        _databaseService.updateMatches(matchId, updatedMatches);
                      },
                    ),
                    onLongPress: () {
                      _databaseService.deleteMatches(matchId);
                    },
                  ),
                );
              },
            );
          }),
    );
  }

  void _displayTextInputDialog() async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add a Match'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _textEditingControllerMatch,
                  decoration: const InputDecoration(hintText: "Match...."),
                ),
                TextField(
                  controller: _textEditingControllerScore,
                  decoration: const InputDecoration(hintText: "Score...."),
                ),
              ],
            ),
            actions: <Widget>[
              MaterialButton(
                color: Theme.of(context).colorScheme.primary,
                textColor: Colors.white,
                child: const Text('OK'),
                onPressed: () {
                  Matches matches = Matches(
                      match: _textEditingControllerMatch.text,
                      score: _textEditingControllerScore.text,
                      isDone: false,
                      date: Timestamp.now());
                  _databaseService.addMatches(matches);
                  Navigator.pop(context);
                  _textEditingControllerMatch.clear();
                  _textEditingControllerScore.clear();
                },
              ),
            ],
          );
        });
  }
}
