# john jozwiak on 2019.05.14

all:	parseOED  uniqueWords  wordsToDefs
	# xcodebuild -alltargets -quiet
	-@mkdir -p built
	-@/bin/echo
	-@/bin/ls -F
	-@/bin/echo

parseOED:	src/parseOED/main.swift
	-@mkdir -p built
	swiftc  src/parseOED/main.swift -o built/parseOED

uniqueWords:	src/uniqueWords/main.swift src/uniqueWords/tokenize.swift
	-@mkdir -p built
	swiftc  src/uniqueWords/*.swift -o built/uniqueWords

wordsToDefs:	src/wordsToDefs/main.swift
	-@mkdir -p built
	swiftc  src/wordsToDefs/*.swift -o built/wordsToDefs

test:	all
	built/uniqueWords < data/fourLinesOf.txt

testlong:	all
	xzcat data/gutenberg/HoundBaskervilles.txt.xz | built/uniqueWords

testverbose:	all
	xzcat data/gutenberg/WarAndPeace.txt.xz       | built/uniqueWords

clean:	
	-@/bin/rm -fr built
	-@/bin/echo
	-@/bin/ls -F
	-@/bin/echo
