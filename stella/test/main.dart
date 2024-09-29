import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:stella_example/program_runner.dart';
import 'package:stella_example/type_checker/type_checker.dart';
import 'package:test/test.dart';

void main() async {
  final runner = ProgramRunner();
  final typeChecker = TypeChecker();

  final List<({String name, String contents})> illTypedPrograms =
      await _getContentsIn('/test/data/ill_typed');
  final List<({String name, String contents})> wellTypedPrograms =
      await _getContentsIn('/test/data/well_typed');

  group(
    'Test well typed',
    () {
      final convert = _convertTask(runner, typeChecker);
      wellTypedPrograms.map(convert).forEach(
            (pr) => test(
              'Testing ${pr.name}',
              () async => expect(
                await pr.task.run(),
                TypeMatcher<Right>(),
              ),
            ),
          );
    },
  );

  group(
    'Test ill typed',
    () {
      final convert = _convertTask(runner, typeChecker);
      illTypedPrograms.map(convert).forEach(
            (pr) => test(
              'Testing ${pr.name}',
              () async => expect(
                await pr.task.run(),
                TypeMatcher<Left>(),
              ),
            ),
          );
    },
  );
}

Future<List<({String name, String contents})>> _getContentsIn(
  String path,
) async {
  final files = await Directory('${Directory.current.path}${path}').list(recursive: false).toList();
  return files.whereType<File>().map((file) async {
    final lines = await file.readAsLines();
    return (
      name: file.path,
      contents: lines.join('\n'),
    );
  }).wait;
}

({String name, Task<Either<String, Unit>> task}) Function(
  ({String contents, String name}) pr,
) _convertTask(
  ProgramRunner runner,
  TypeChecker typeChecker,
) =>
    (pr) => (
          name: pr.name,
          task: runner.run<Either<String, Unit>>(pr.contents).map(
                (maybeProgram) => maybeProgram
                    .toEither(() => 'Error reading or parsing the program')
                    .flatMap((fun) => fun(typeChecker.run)),
              ),
        );
