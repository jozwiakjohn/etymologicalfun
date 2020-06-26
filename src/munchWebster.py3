# john jozwiak on 2019 Apr 22 for ModulusX.

import sys,platform # ,lzma

# Python2 lacks the lzma module, which i need.
# For that reason, and unicode etc, ensure we are on at least Python3.

if  int(platform.python_version_tuple()[0]) < 3:
  print("\n  I need python3 or this may produce unforeseen surprise nonsense.\n" )
  sys.exit(1)

import lzma,re

if len(sys.argv) < 2:
  print("\n  Oops!\n")
  print("  " + sys.argv[0] + " needs the name of the input file.\n")
  print("  The input file's name should end in .txt for a text file or .xz for an text file compressed by xz.")
  print("  The input file can be given as \"-\" to read uncompressed lines from stdin.")
  print("  For example:\n")
  print("    python3 " + sys.argv[0] + " GutenbergWebsterUnabridged.xz\n")
  sys.exit(1)

inputFile  = sys.argv[1]

calledOnce = False

#################################################

def  processLogLine( line ):
  fields = line.strip().lower().split(b' ')
  # print(fields)
  if 15==len(fields):

    d = (fields[0]).decode("utf-8")
    t = (fields[1]).decode("utf-8")
    s = (fields[2]).decode("utf-8")
    c = (fields[8]).decode("utf-8")

    knownGeosByIP[ s ] = True
    knownGeosByIP[ c ] = True
    global calledOnce
    if not calledOnce:
      calledOnce = True
      geoCoordsForIP( c )

    print( "  { \"date\"=\""   + d + "\" ," +
              " \"time\"=\""   + t + "\" ," +
              " \"server\"=\"" + s + "\" ," +
              " \"client\"=\"" + c + "\" }," 
         )
  else:
    return

#################################################

class  WebsterWord:
  def __init__(self,word):
    self.lines = [word.strip()]
  def plus(self,line):
    self.lines = self.lines + [line]
  def lines(self):
    return self.lines
  def parse(self):
    pass
  def parse(self):
    pass

#################################################

def  processJustFinishedChunk( strings ):
  print()

  newLineGroupings = [ strings[0] ]
  group            = ""

  if len(strings) > 1:
    for s in strings[1:]:

      if len(s.strip()) > 0:
        group = group + s
      else:
        newLineGroupings.append(group)
        group = ""

  for g in newLineGroupings:
      print("    |  " + g)

  print()

#################################################

lineCount = 0

def  processLinesOf( iterableInput , echoing = True ):

  currentWordDefLines = []
  accumulating        = False

  # lines read from a Webster Unabridged text file are grouped into definitions.
  # definitions have a structure respected by the code below:
  # a definition starts with an all uppercase line.

  try:
    for line in iterableInput:
      global lineCount
      lineCount = lineCount + 1

      line = line.strip().decode('utf-8')

      #  now capture the multi-line syntax of Webster Unabridged into individual records, bitch.

      if re.match("^[A-Z-']+$",line) :

        if accumulating:
          processJustFinishedChunk( currentWordDefLines )
        else:
          accumulating = True

        currentWordDefLines = [line]

        if echoing:
          print( "~~~~~~")

      else:
        if accumulating:
          currentWordDefLines.append( line )

      if echoing:
        print( line )

  except KeyboardInterrupt:
    sys.exit(1)

  print( "\n   There were " + str(lineCount) + " input lines." )

#################################################

if re.match( ".*\.txt$" , inputFile):
  with open(inputFile) as iterableInput:
    processLinesOf( iterableInput )

elif '-' == inputFile:
  with open(sys.stdin) as iterableInput:
    processLinesOf( iterableInput )

elif re.match( ".*\.xz$" , inputFile ):
  with lzma.open(inputFile) as iterableInput:
    processLinesOf( iterableInput )

else:
  print("NOTHING KNOWN ABOUT FILETYPE: YOU SUCK AT PROGRAMMING.")
  sys.exit(1)
