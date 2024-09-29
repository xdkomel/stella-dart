import 'package:antlr4/antlr4.dart';
import 'package:fpdart/fpdart.dart';
import 'package:stella_generated/stella_generated.dart';

class ProgramRunner {
  Task<Option<A Function(A Function(Program))>> run<A>(
    String contents,
  ) =>
      Task(
        () async {
          final input = await InputStream.fromString(contents);
          final lexer = stella_lexer(input);
          final tokens = CommonTokenStream(lexer);
          final parser = stella_parser(tokens);
          parser.addErrorListener(DiagnosticErrorListener());
          final output = buildProgram(parser.program());
          return switch (output) {
            final p? => Option.of((fun) => fun(p)),
            _ => const None(),
          };
        },
      );
}
