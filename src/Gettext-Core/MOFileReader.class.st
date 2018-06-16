"
A reader for MO files.

See https://www.gnu.org/software/gettext/manual/html_node/MO-Files.html for a description of the format.
"
Class {
	#name : #MOFileReader,
	#superclass : #Object,
	#instVars : [
		'stream',
		'magic',
		'isLittleEndian',
		'revision',
		'numberOfStrings',
		'originalTableOffset',
		'translatedTableOffset',
		'hashTableSize',
		'hashTableOffset',
		'translations',
		'translatedStrings'
	],
	#category : #'Gettext-Core-IO'
}

{ #category : #examples }
MOFileReader class >> example1 [
	
	|stream|
	stream := (FileSystem workingDirectory / 'hello.mo') readStream.
	[(MOFileReader on: stream) read; inspect] ensure: [ stream close ]
]

{ #category : #'instance creation' }
MOFileReader class >> on: aStream [

	^(self new)
		initStream: aStream;
		yourself
]

{ #category : #'instance creation' }
MOFileReader class >> readFile: fileName [
	|stream reader|
	[ stream := fileName asFileReference readStream.
	  reader := self on: stream.
	  reader read ] ensure: [ stream close ].
	^reader
]

{ #category : #accessing }
MOFileReader >> hashTableOffset [

	^hashTableOffset
]

{ #category : #accessing }
MOFileReader >> hashTableSize [

	^hashTableSize
]

{ #category : #'private - initialization' }
MOFileReader >> initStream: aStream [

	stream := aStream
]

{ #category : #testing }
MOFileReader >> isLittleEndian [
	"Return true if the file read is in little endian format"
	
	^isLittleEndian
]

{ #category : #'private - utilities' }
MOFileReader >> loadStringPointersUsingOffset: tableOffset [

	|offsetTable lengthTable length offset |
	offsetTable := IntegerArray new: numberOfStrings.
	lengthTable := IntegerArray new: numberOfStrings.
	stream binary.
	stream position: tableOffset.
	
	1 to: numberOfStrings do: [:index | 
		length := self nextInt32.
		offset := self nextInt32.
		offsetTable at: index put: offset.
		lengthTable at: index put: length. 
	].
	^Array with: offsetTable with: lengthTable


]

{ #category : #'private - utilities' }
MOFileReader >> loadStringsWithPointers: table [
	"We convert string encoding at load time.
	Currently, we do not take care to set the leadingChar for a languageEnvironment"
	
	^self loadStringsWithPointers: table encoding: #utf8 languageEnvironment: nil

]

{ #category : #'private - utilities' }
MOFileReader >> loadStringsWithPointers: tupple encoding: encodingName languageEnvironment: env [

	| offsetTable lenTable strings |
	stream ascii; 
		converter: (TextConverter newForEncoding: encodingName).
	offsetTable :=  tupple first.

	lenTable := tupple second.
	strings := Array new: numberOfStrings.
	1 to: numberOfStrings do: [:index | |  rawStr start byteLength endPos|
		start := offsetTable at: index.
		byteLength := lenTable at: index.
		endPos := start + byteLength.
		rawStr :=  (String new: byteLength) writeStream.
		stream position:  start.
		[stream position < endPos] whileTrue: [rawStr nextPut: stream next].
		strings at: index put: rawStr contents ].
	^strings.

]

{ #category : #'private - utilities' }
MOFileReader >> nextInt32 [

	^isLittleEndian 
			ifTrue: [ stream nextLittleEndianNumber: 4 ]
			ifFalse: [ stream nextInt32 ]
]

{ #category : #accessing }
MOFileReader >> numberOfStrings [

	^numberOfStrings
]

{ #category : #accessing }
MOFileReader >> originalTableOffset [

	^originalTableOffset
]

{ #category : #reading }
MOFileReader >> read [
	"read the .mo file structure"
	stream binary.
	self 
		readHeader;
		readTables
]

{ #category : #'private - reading header' }
MOFileReader >> readHashTableOffset [
	"Read the offset of hashing table"
	
	hashTableOffset := self nextInt32.
	
]

{ #category : #'private - reading header' }
MOFileReader >> readHashTableSize [
	"Read the size of hashing table"
	
	hashTableSize := self nextInt32.
	
]

{ #category : #'private - reading header' }
MOFileReader >> readHeader [

	self 
		readMagicBytes;
		readRevision;
		readNumberOfStrings;
		readOriginalTableOffset;
		readTranslatedTableOffset;
		readHashTableSize;
		readHashTableOffset
]

{ #category : #'private - reading header' }
MOFileReader >> readMagicBytes [

	magic := stream uint32.
	magic = 16rDE120495 
		ifTrue: [ isLittleEndian := true ]
		ifFalse: [
			magic = 16r950412DE 
				ifTrue: [isLittleEndian := false]
				ifFalse: [ self error: 'invalid MO']].
]

{ #category : #'private - reading header' }
MOFileReader >> readNumberOfStrings [
	"Read the number of strings"
	
	numberOfStrings := self nextInt32
]

{ #category : #'private - reading header' }
MOFileReader >> readOriginalTableOffset [
	"Read the offset of table with original strings"
	
	originalTableOffset := self nextInt32 
]

{ #category : #'private - reading header' }
MOFileReader >> readRevision [
	"Read the revision number"
	
	revision := self nextInt32
]

{ #category : #'private - reading other' }
MOFileReader >> readTables [
	| originalTable translatedTable originalStrings |
	originalTable := self loadStringPointersUsingOffset: originalTableOffset.
	translatedTable := self loadStringPointersUsingOffset: translatedTableOffset.
	originalStrings := self loadStringsWithPointers: originalTable.
	translatedStrings := self loadStringsWithPointers: translatedTable.
	
	translations := Dictionary new: numberOfStrings.  
	1 to: numberOfStrings do: [:index |
		| key |
		key := originalStrings at: index.
		translations at: key put: index.].
	
	originalStrings := nil
]

{ #category : #'private - reading header' }
MOFileReader >> readTranslatedTableOffset [
	"Read offset of table with translation strings"
	
	translatedTableOffset := self nextInt32 
]

{ #category : #accessing }
MOFileReader >> revision [

	^revision
]

{ #category : #accessing }
MOFileReader >> translatedTableOffset [

	^translatedTableOffset
]

{ #category : #accessing }
MOFileReader >> translations [
	
	^translations 
]
