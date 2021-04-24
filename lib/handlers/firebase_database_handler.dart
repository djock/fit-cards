import 'package:firebase_database/firebase_database.dart';
import 'package:fitcards/handlers/app_state.dart';
import 'package:fitcards/models/leaderboard_entry.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FirebaseDatabaseHandler {
  static String user;
  static List<LeaderBoardEntry> leaderBoard = [];

  static void updateLeaderBoard() {
    final dbRef = FirebaseDatabase.instance.reference().child("leaderboard");

    var firebaseUserId = '${user}_${AppState.userName}';
    dbRef.update({
      firebaseUserId.toString(): AppState.points,
    }).catchError((onError) {
      ScaffoldMessenger.of(Get.context)
          .showSnackBar(SnackBar(content: Text(onError.toString())));
    });
  }

  static Future<bool> getLeaderBoard() async {
    final dbRef = FirebaseDatabase.instance.reference().child("leaderboard");
    await dbRef.once().then((DataSnapshot snapshot) {
      Map<dynamic, dynamic> snapshotValues = snapshot.value;
      leaderBoard.clear();

      snapshotValues.forEach((key, value) {
        var entry = new LeaderBoardEntry(key, value);

        leaderBoard.add(entry);
      });

      leaderBoard.sort((b, a) {
        return a.points.compareTo(b.points);
      });

      return true;
    });

    return false;
  }
}
