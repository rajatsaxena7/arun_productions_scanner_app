import 'dart:async';

import 'package:collection/collection.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class EventRecord extends FirestoreRecord {
  EventRecord._(
    DocumentReference reference,
    Map<String, dynamic> data,
  ) : super(reference, data) {
    _initializeFields();
  }

  // "ID" field.
  int? _id;
  int get id => _id ?? 0;
  bool hasId() => _id != null;

  // "Event_Name" field.
  String? _eventName;
  String get eventName => _eventName ?? '';
  bool hasEventName() => _eventName != null;

  // "Event_Date" field.
  DateTime? _eventDate;
  DateTime? get eventDate => _eventDate;
  bool hasEventDate() => _eventDate != null;

  // "Location" field.
  LatLng? _location;
  LatLng? get location => _location;
  bool hasLocation() => _location != null;

  // "Description" field.
  String? _description;
  String get description => _description ?? '';
  bool hasDescription() => _description != null;

  // "Contacts" field.
  List<DocumentReference>? _contacts;
  List<DocumentReference> get contacts => _contacts ?? const [];
  bool hasContacts() => _contacts != null;

  // "totalparticipants" field.
  int? _totalparticipants;
  int get totalparticipants => _totalparticipants ?? 0;
  bool hasTotalparticipants() => _totalparticipants != null;

  void _initializeFields() {
    _id = castToType<int>(snapshotData['ID']);
    _eventName = snapshotData['Event_Name'] as String?;
    _eventDate = snapshotData['Event_Date'] as DateTime?;
    _location = snapshotData['Location'] as LatLng?;
    _description = snapshotData['Description'] as String?;
    _contacts = getDataList(snapshotData['Contacts']);
    _totalparticipants = castToType<int>(snapshotData['totalparticipants']);
  }

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('Event');

  static Stream<EventRecord> getDocument(DocumentReference ref) =>
      ref.snapshots().map((s) => EventRecord.fromSnapshot(s));

  static Future<EventRecord> getDocumentOnce(DocumentReference ref) =>
      ref.get().then((s) => EventRecord.fromSnapshot(s));

  static EventRecord fromSnapshot(DocumentSnapshot snapshot) => EventRecord._(
        snapshot.reference,
        mapFromFirestore(snapshot.data() as Map<String, dynamic>),
      );

  static EventRecord getDocumentFromData(
    Map<String, dynamic> data,
    DocumentReference reference,
  ) =>
      EventRecord._(reference, mapFromFirestore(data));

  @override
  String toString() =>
      'EventRecord(reference: ${reference.path}, data: $snapshotData)';

  @override
  int get hashCode => reference.path.hashCode;

  @override
  bool operator ==(other) =>
      other is EventRecord &&
      reference.path.hashCode == other.reference.path.hashCode;
}

Map<String, dynamic> createEventRecordData({
  int? id,
  String? eventName,
  DateTime? eventDate,
  LatLng? location,
  String? description,
  int? totalparticipants,
}) {
  final firestoreData = mapToFirestore(
    <String, dynamic>{
      'ID': id,
      'Event_Name': eventName,
      'Event_Date': eventDate,
      'Location': location,
      'Description': description,
      'totalparticipants': totalparticipants,
    }.withoutNulls,
  );

  return firestoreData;
}

class EventRecordDocumentEquality implements Equality<EventRecord> {
  const EventRecordDocumentEquality();

  @override
  bool equals(EventRecord? e1, EventRecord? e2) {
    const listEquality = ListEquality();
    return e1?.id == e2?.id &&
        e1?.eventName == e2?.eventName &&
        e1?.eventDate == e2?.eventDate &&
        e1?.location == e2?.location &&
        e1?.description == e2?.description &&
        listEquality.equals(e1?.contacts, e2?.contacts) &&
        e1?.totalparticipants == e2?.totalparticipants;
  }

  @override
  int hash(EventRecord? e) => const ListEquality().hash([
        e?.id,
        e?.eventName,
        e?.eventDate,
        e?.location,
        e?.description,
        e?.contacts,
        e?.totalparticipants
      ]);

  @override
  bool isValidKey(Object? o) => o is EventRecord;
}
