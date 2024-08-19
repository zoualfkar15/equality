
import 'package:build/build.dart';
import 'package:equality/generate_equality_and_hash_code.dart';
import 'package:source_gen/source_gen.dart';
import 'package:analyzer/dart/element/element.dart';


class EqualityGenerator extends GeneratorForAnnotation<Equality> {
//   @override
//   String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
//     final classElement = element as ClassElement;
//     final className = classElement.name;
//     final fields = classElement.fields.where((field) => !field.isStatic);
//
//     final classNameLower = toLowerSnakeCase(className);
//
//     return '''
// part of '$classNameLower.dart';
//
// extension ${className}Equality on $className {
//
//   bool customOperator (Object other) {
//
//          return identical(this, other) || other is ${classElement.name} &&
//          runtimeType == other.runtimeType &&
//          ${fields.map((field) => 'other.${field.name} == ${field.name}').join(' && ')};
//   }
//
//      int get customHashCode => runtimeType.hashCode ^ ${fields.map((field) => '${field.name}.hashCode').join(' ^ ')};
//
// }
// ''';
//   }


  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    final classElement = element as ClassElement;
    final className = classElement.name;
    final fields = classElement.fields.where((field) => !field.isStatic && field.name != 'hashCode');

    final classNameLower = toLowerSnakeCase(className);

    String generateEqualityCheck(FieldElement field) {
      if (field.type.isDartCoreList) {
        return ' DeepEquality().equals(other.${field.name}, ${field.name})';
      }else if (field.type.isDartCoreMap) {
        return ' DeepEquality().equals(other.${field.name}, ${field.name})';
      }else {
        return 'other.${field.name} == ${field.name}';
      }
    }

    return '''
part of '$classNameLower.dart';

extension ${className}Equality on $className {

  bool customOperator(Object other) {
    return identical(this, other) || other is ${classElement.name} &&
      ${fields.map((field) => generateEqualityCheck(field)).join(' && ')};
  }

  int get customHashCode => ${fields.map((field) => field.type.isDartCoreList ? ' DeepEquality().hash(${field.name})' : '${field.name}.hashCode').join(' ^ ')};
}
''';
  }


  String toLowerSnakeCase(String camelCase) {
    final buffer = StringBuffer();

    for (int i = 0; i < camelCase.length; i++) {


      String char = camelCase[i];
      if(i==0) char=char.toLowerCase();

      // Check if the current character is uppercase and not the first character
      if (i > 0 && char == char.toUpperCase()) {
        buffer.write('_'); // Add an underscore before the uppercase letter
        buffer.write(char.toLowerCase()); // Convert the uppercase letter to lowercase
      } else {
        buffer.write(char); // Add the character as is
      }
    }

    return buffer.toString();
  }
}

