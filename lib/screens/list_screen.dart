import 'package:flutter/material.dart';
import 'package:uasmobile2/models/match.dart';
import 'package:uasmobile2/services/database_services.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  final DatabaseService _databaseService = DatabaseService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _buildUI(),
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
                  ),
                );
              },
            );
          }),
    );
  }
}
