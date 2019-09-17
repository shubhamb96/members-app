import 'package:firebase_database/firebase_database.dart';

class ActivityData {
  String key;
  int activityID;
  int eventID;
  int hoursNeeded;
  String name;

  ActivityData(this.activityID, this.eventID, this.hoursNeeded, this.name);

  ActivityData.fromSnapshot(DataSnapshot snapshot) :
    key = snapshot.key,
    activityID = snapshot.value["ActivityID"],
    eventID = snapshot.value["Event"],
    hoursNeeded = snapshot.value["HoursNeeded"],
    name = snapshot.value["Name"];

  toJson() {
    return {
      "ActivityID": activityID,
      "Event": eventID,
      "HoursNeeded":hoursNeeded,
      "Name":name,
    };
  }
}