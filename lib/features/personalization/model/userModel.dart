import '../../../utils/constant/strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  String phoneNumber;
  String address;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.address,
  });

  static UserModel empty() =>
      UserModel(id: '',
          name: '',
          email: '',
          phoneNumber: '',
          address: '');

  Map<String, dynamic> toJson() {
    return {
      Strings.fieldId: id,
      Strings.fieldName: name,
      Strings.fieldEmail: email,
      Strings.fieldPhoneNumber: phoneNumber,
      Strings.fieldAddress: address
    };
  }

  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.exists) {
      final data = document.data()!;

      return UserModel(
        id: data[Strings.fieldId],
        name: data[Strings.fieldName],
        email: data[Strings.fieldEmail],
        phoneNumber: data[Strings.fieldPhoneNumber],
        address: data[Strings.fieldAddress],
      );
    } else {
      return UserModel.empty();
    }
  }
}