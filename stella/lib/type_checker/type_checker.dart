import 'package:antlr4/antlr4.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stella_generated/stella_generated.dart';

class TypeChecker {
  Either<String, Unit> run(Program p) => switch (p) {
        AProgram _ => Either.of(unit),
      };
}
