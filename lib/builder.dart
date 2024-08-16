
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/equality_generator.dart';


Builder equalityBuilder(BuilderOptions options) =>
    LibraryBuilder(
      EqualityGenerator(),
      generatedExtension: '.equality.g.dart',
      formatOutput: (code) => code,
      header: '',
    );
