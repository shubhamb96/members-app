import 'package:firebase_database/firebase_database.dart';

class EventData {
  String key;
  int eventID;
  String eventName;
  String venue;

  EventData(this.eventID, this.eventName,this.venue);

  EventData.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    eventID = snapshot.value["EventID"],
    eventName = snapshot.value["EventName"],
    venue = snapshot.value["Venue"];

  toJson() {
    return {
      "EventID": eventID,
      "EventName": eventName,
      "Venue":venue,
    };
  }
}