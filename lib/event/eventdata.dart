import 'package:firebase_database/firebase_database.dart';

class EventData {
  String key;
  String activity1;
  String activity2;
  String eventName;
  String venue;

  EventData(this.activity1, this.activity2, this.eventName,this.venue);

  EventData.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    activity1 = snapshot.value["Activity 1"],
    activity2 = snapshot.value["Activity 2"],
    eventName = snapshot.value["EventName"],
    venue = snapshot.value["Venue"];

  toJson() {
    return {
      "Activity 1": activity1,
      "Activity 2": activity2,
      "EventName": eventName,
      "Venue":venue,
    };
  }
}