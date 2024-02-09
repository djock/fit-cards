// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:fitcards/handlers/workout_controller.dart';
// import 'package:flutter/foundation.dart' as Foundation;
//
// class AnalyticsHandler {
//   static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
//
//   static Future<void> logEvent(String eventName,
//       {Map<String, dynamic>? params}) async {
//     if (Foundation.kReleaseMode) {
//       await analytics.logEvent(
//         name: eventName,
//         parameters: params,
//       );
//
//       Foundation.debugPrint(
//           '[FIREBASE_ANALYTICS] Log $eventName ${params.toString()}');
//     }
//   }
//
//   static Future<void> logStartWorkout(workoutType type) async {
//     var _params = <String, dynamic>{
//       'type': type.toString(),
//     };
//
//     logEvent('start_workout', params: _params);
//   }
//
//   static Future<void> logStopWorkout(workoutType type, int points) async {
//     var _params = <String, dynamic>{
//       'type': type.toString(),
//       'points': points.toString(),
//     };
//
//     logEvent('stop_workout', params: _params);
//   }
//
//   static Future<void> logSkipExercise(String exercise) async {
//     var _params = <String, dynamic>{
//       'exercise': exercise,
//     };
//
//     logEvent('skip_exercise', params: _params);
//   }
//
//   // start workout: type
//   // end workout
//   // skip exercise
// }
