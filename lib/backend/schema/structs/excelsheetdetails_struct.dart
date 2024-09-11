// ignore_for_file: unnecessary_getters_setters

import 'package:cloud_firestore/cloud_firestore.dart';

import '/backend/schema/util/firestore_util.dart';
import '/backend/schema/util/schema_util.dart';

import 'index.dart';
import '/flutter_flow/flutter_flow_util.dart';

class ExcelsheetdetailsStruct extends FFFirebaseStruct {
  ExcelsheetdetailsStruct({
    String? name,
    int? phoneNumber,
    String? email,
    FirestoreUtilData firestoreUtilData = const FirestoreUtilData(),
  })  : _name = name,
        _phoneNumber = phoneNumber,
        _email = email,
        super(firestoreUtilData);

  // "name" field.
  String? _name;
  String get name => _name ?? '';
  set name(String? val) => _name = val;

  bool hasName() => _name != null;

  // "phone_number" field.
  int? _phoneNumber;
  int get phoneNumber => _phoneNumber ?? 0;
  set phoneNumber(int? val) => _phoneNumber = val;

  void incrementPhoneNumber(int amount) => phoneNumber = phoneNumber + amount;

  bool hasPhoneNumber() => _phoneNumber != null;

  // "email" field.
  String? _email;
  String get email => _email ?? '';
  set email(String? val) => _email = val;

  bool hasEmail() => _email != null;

  static ExcelsheetdetailsStruct fromMap(Map<String, dynamic> data) =>
      ExcelsheetdetailsStruct(
        name: data['name'] as String?,
        phoneNumber: castToType<int>(data['phone_number']),
        email: data['email'] as String?,
      );

  static ExcelsheetdetailsStruct? maybeFromMap(dynamic data) => data is Map
      ? ExcelsheetdetailsStruct.fromMap(data.cast<String, dynamic>())
      : null;

  Map<String, dynamic> toMap() => {
        'name': _name,
        'phone_number': _phoneNumber,
        'email': _email,
      }.withoutNulls;

  @override
  Map<String, dynamic> toSerializableMap() => {
        'name': serializeParam(
          _name,
          ParamType.String,
        ),
        'phone_number': serializeParam(
          _phoneNumber,
          ParamType.int,
        ),
        'email': serializeParam(
          _email,
          ParamType.String,
        ),
      }.withoutNulls;

  static ExcelsheetdetailsStruct fromSerializableMap(
          Map<String, dynamic> data) =>
      ExcelsheetdetailsStruct(
        name: deserializeParam(
          data['name'],
          ParamType.String,
          false,
        ),
        phoneNumber: deserializeParam(
          data['phone_number'],
          ParamType.int,
          false,
        ),
        email: deserializeParam(
          data['email'],
          ParamType.String,
          false,
        ),
      );

  @override
  String toString() => 'ExcelsheetdetailsStruct(${toMap()})';

  @override
  bool operator ==(Object other) {
    return other is ExcelsheetdetailsStruct &&
        name == other.name &&
        phoneNumber == other.phoneNumber &&
        email == other.email;
  }

  @override
  int get hashCode => const ListEquality().hash([name, phoneNumber, email]);
}

ExcelsheetdetailsStruct createExcelsheetdetailsStruct({
  String? name,
  int? phoneNumber,
  String? email,
  Map<String, dynamic> fieldValues = const {},
  bool clearUnsetFields = true,
  bool create = false,
  bool delete = false,
}) =>
    ExcelsheetdetailsStruct(
      name: name,
      phoneNumber: phoneNumber,
      email: email,
      firestoreUtilData: FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
        delete: delete,
        fieldValues: fieldValues,
      ),
    );

ExcelsheetdetailsStruct? updateExcelsheetdetailsStruct(
  ExcelsheetdetailsStruct? excelsheetdetails, {
  bool clearUnsetFields = true,
  bool create = false,
}) =>
    excelsheetdetails
      ?..firestoreUtilData = FirestoreUtilData(
        clearUnsetFields: clearUnsetFields,
        create: create,
      );

void addExcelsheetdetailsStructData(
  Map<String, dynamic> firestoreData,
  ExcelsheetdetailsStruct? excelsheetdetails,
  String fieldName, [
  bool forFieldValue = false,
]) {
  firestoreData.remove(fieldName);
  if (excelsheetdetails == null) {
    return;
  }
  if (excelsheetdetails.firestoreUtilData.delete) {
    firestoreData[fieldName] = FieldValue.delete();
    return;
  }
  final clearFields =
      !forFieldValue && excelsheetdetails.firestoreUtilData.clearUnsetFields;
  if (clearFields) {
    firestoreData[fieldName] = <String, dynamic>{};
  }
  final excelsheetdetailsData =
      getExcelsheetdetailsFirestoreData(excelsheetdetails, forFieldValue);
  final nestedData =
      excelsheetdetailsData.map((k, v) => MapEntry('$fieldName.$k', v));

  final mergeFields = excelsheetdetails.firestoreUtilData.create || clearFields;
  firestoreData
      .addAll(mergeFields ? mergeNestedFields(nestedData) : nestedData);
}

Map<String, dynamic> getExcelsheetdetailsFirestoreData(
  ExcelsheetdetailsStruct? excelsheetdetails, [
  bool forFieldValue = false,
]) {
  if (excelsheetdetails == null) {
    return {};
  }
  final firestoreData = mapToFirestore(excelsheetdetails.toMap());

  // Add any Firestore field values
  excelsheetdetails.firestoreUtilData.fieldValues
      .forEach((k, v) => firestoreData[k] = v);

  return forFieldValue ? mergeNestedFields(firestoreData) : firestoreData;
}

List<Map<String, dynamic>> getExcelsheetdetailsListFirestoreData(
  List<ExcelsheetdetailsStruct>? excelsheetdetailss,
) =>
    excelsheetdetailss
        ?.map((e) => getExcelsheetdetailsFirestoreData(e, true))
        .toList() ??
    [];
