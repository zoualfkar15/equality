
// **************************************************************************
// EqualityGenerator
// **************************************************************************

part of 'tutor_model.dart';

extension TutorModelEquality on TutorModel {

  bool customOperator (Object other) {
  
         return identical(this, other) || other is TutorModel &&
         runtimeType == other.runtimeType &&
         other.username == username && other.aaa == aaa;


  }

     int get customHashCode => runtimeType.hashCode ^ username.hashCode ^ aaa.hashCode;

}
