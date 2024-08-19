
part of 'generate_equality_and_hash_code.dart';

class DeepEquality{
 bool equals(Object? e1, Object? e2){
  return const DeepCollectionEquality().equals(e1,e2);
 }

 int hash(Object? o){
  return const DeepCollectionEquality().hash(o);
 }
}