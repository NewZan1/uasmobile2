import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uasmobile2/models/match.dart';

const String MATCH_COLLECTION_REF = "match";

class DatabaseService {
  final _firestore = FirebaseFirestore.instance;

  late final CollectionReference _matchRef;

  DatabaseService() {
    _matchRef = _firestore
        .collection(MATCH_COLLECTION_REF)
        .withConverter<Matches>(
            fromFirestore: (snapshots, _) =>
                Matches.fromJson(snapshots.data()!),
            toFirestore: (matches, _) => matches.toJson());
  }

  Stream<QuerySnapshot> getMatches() {
    return _matchRef.snapshots();
  }

  void addMatches(Matches matches) async {
    _matchRef.add(matches);
  }
}
