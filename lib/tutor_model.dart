// lib/tutor_model.dart


import 'package:equality/generate_equality_and_hash_code.dart';

part 'tutor_model.equality.g.dart';

@GenerateEqualityAndHashCode()
class TutorModel {
  String username;
  String aaa;


  TutorModel({required this.username,required this.aaa});
}

