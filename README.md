# Stella in Dart

This is a template for Stella implementation in Dart. The project consists of the external `stella` and internal `stella_generated` libraries, both of which were generated using [BNFC with Dart support](https://github.com/xdkomel/bnfc-dart). 

- `stella.cf` is the LBNF-grammar used by BNFC to generate the AST, AST Builder, Pretty-Printer and the EBNF-grammer used by ANTLR, which produced the lexer and the parser.
- `bin/main.dart` used to run the type checker once. An example of input/output:
    ```
    > dart bin/main.dart "language core; fn main() { return 10; }"
    All good
    > dart bin/main.dart "language core; fn (){}"
    line 1:18 missing StellaIdent at '('
    line 1:21 mismatched input '}' expecting {'fn', 'inline'}
    Error reading or parsing the program
    ```
- `test/main.dart` used to run tests located in the `test/data`. A type checker with well-typed input is supposed to return `Right<Unit>`, while ill-typed input should lead to a `Left<String>` with the error message. 
- `lib/type_checker/type_checker.dart` defines the `TypeChecker` behaviour. Consider working in the `lib/type_checker` directory while implementing the type checker.

### Functional Dart

The project uses `fpdart` and `fast_immutable_collections` libraries to leverage the functional paradigm and its advantages using Dart.