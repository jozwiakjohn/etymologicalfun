# etymologicalfun

[ john jozwiak  (summer 2019, with updates later, including restructuring to expose at public repo 2020 June 26). ]

This depends on Xcode being installed, and worked on 2019.11.10 on MacOS Catalina.

As of MacOS Catalina (10.15.x),

   xcode-select -s /Applications/Xcode.app/Contents/Developer

then you should be able to type "make" and it will use xcodebuild to
compile the stuff in the three subdirectories.   See the file Makefile, which "make" reads.

~~~~~~~~~~~~~~~~~~~

uniquewords reads standard input and spits out a list of unique words seen.

wordsToDefs reads standard input, which should be a single word per line,
            and looks each word up in the MacOS Dictionary Services, writing to stdout.

parseOED    does something else kinda off topic.

try:

xzcat data/WiktionaryWords.xz | wordsToDefs | less
xzcat data/WiktionaryWords.xz | wordsToDefs | parseOED | less
