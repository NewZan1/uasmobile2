import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CrudScreen extends StatefulWidget {
  const CrudScreen({super.key});

  @override
  State<CrudScreen> createState() => _CrudScreenState();
}

class _CrudScreenState extends State<CrudScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();

  CollectionReference _users = FirebaseFirestore.instance.collection("users");

  void _addUser() {
    _users.add({
      'name': _nameController.text,
      'position': _positionController.text,
    });
    _nameController.clear();
    _positionController.clear();
  }

  void _deleteUser(String userId) {
    _users.doc(userId).delete();
  }

  void _editUser(DocumentSnapshot user) {
    _nameController.text = user['name'];
    _positionController.text = user['position'];

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Edit Player"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: "Player Name"),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: _positionController,
                  decoration: InputDecoration(labelText: "Player Position"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Cancel")),
              ElevatedButton(
                  onPressed: () {
                    _updateUser(user.id);
                    Navigator.pop(context);
                  },
                  child: Text("Update"))
            ],
          );
        });
  }

  void _updateUser(String userId) {
    _users.doc(userId).update(
        {'name': _nameController.text, 'position': _positionController.text});

    _nameController.clear();
    _positionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: "Enter Player Name"),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              controller: _positionController,
              decoration: InputDecoration(labelText: "Enter Position Player"),
            ),
            SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                _addUser();
              },
              child: Text("Add Player"),
            ),
            SizedBox(
              height: 16,
            ),
            Expanded(
                child: StreamBuilder(
              stream: _users.snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var user = snapshot.data!.docs[index];
                    return Dismissible(
                      key: Key(user.id),
                      background: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 16),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      onDismissed: (direction) {
                        _deleteUser(user.id);
                      },
                      direction: DismissDirection.endToStart,
                      child: Card(
                        elevation: 4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        child: ListTile(
                          title: Text(
                            user['name'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            user['position'],
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              _editUser(user);
                            },
                            icon: Icon(Icons.edit),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
