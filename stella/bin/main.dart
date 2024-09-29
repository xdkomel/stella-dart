import 'package:fpdart/fpdart.dart';
import 'package:stella_example/program_runner.dart';
import 'package:stella_example/type_checker/type_checker.dart';

void main(List<String> args) async {
  final runner = ProgramRunner();
  final typeChecker = TypeChecker();

  final maybeRunner = switch (args.firstOrNull) {
    final contents? => runner.run<Either<String, Unit>>(contents),
    _ => Task.of(const None()),
  };
  final typeCheckingResult = await maybeRunner
      .map(
        (optProgram) => optProgram
            .toEither(() => 'Error reading or parsing the program')
            .flatMap((fun) => fun(typeChecker.run)),
      )
      .run();
  print(typeCheckingResult.match(identity, (_) => 'All good'));
}
