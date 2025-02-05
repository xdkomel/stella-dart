## File generated by the BNF Converter (bnfc 2.9.6).

LANG=stella
LEXER_NAME=stella_lexer
PARSER_NAME=stella_parser
ANTLR4=java -Xmx500M -cp "/usr/local/lib/antlr-4.13.1-complete.jar:$CLASSPATH" org.antlr.v4.Tool

.PHONY : all clean remove

all : ${LANG}

lexer : stella/stella_generated/lib/src/${LEXER_NAME}.g4
	${ANTLR4} -Dlanguage=Dart stella/stella_generated/lib/src/${LEXER_NAME}.g4

parser : stella/stella_generated/lib/src/${PARSER_NAME}.g4
	${ANTLR4} -Dlanguage=Dart -no-listener -no-visitor stella/stella_generated/lib/src/${PARSER_NAME}.g4

install-deps-external : ${LANG}/pubspec.yaml
	cd ${LANG}; dart pub get

install-deps-internal : ${LANG}/${LANG}_generated/pubspec.yaml
	cd ${LANG}/${LANG}_generated; dart pub get

${LANG} : lexer parser clean install-deps-external install-deps-internal

clean :
	rm -f stella/stella_generated/lib/src/${LEXER_NAME}.interp
	rm -f stella/stella_generated/lib/src/${LEXER_NAME}.tokens
	rm -f stella/stella_generated/lib/src/${PARSER_NAME}.interp
	rm -f stella/stella_generated/lib/src/${PARSER_NAME}.tokens
	rm -f stella/stella_generated/lib/src/${LEXER_NAME}.g4
	rm -f stella/stella_generated/lib/src/${PARSER_NAME}.g4

remove :
	rm -rf ${LANG}

