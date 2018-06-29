"
|rs mb|
rs := MOFileReaderTest new littleEndianExampleFile readStream contents.
mb := MultiByteBinaryOrTextStream with: rs.
mb reset.
(MOFileReader on: mb) read
"
Class {
	#name : #MOFileReaderTest,
	#superclass : #TestCase,
	#category : #'Gettext-Tests-IO'
}

{ #category : #'examples files' }
MOFileReaderTest >> example1 [
	"Compile it using  
		msgfmt hello.po -o hello.mo
	 "


	^'msgid ""
msgstr ""
"Content-Type: text/plain; charset=utf-8\n"
"Content-Transfer-Encoding: 8bit\n"

msgid "Hello"
msgstr "World"'
]

{ #category : #'tests - data' }
MOFileReaderTest >> littleEndianExampleFile [
	"See example1"
	
	^#[222 18 4 149 "magic bytes"
		   0 0 0 0 	   "revision"
		   2 0 0 0       "number of strings"
		  28 0 0 0 	   "original table offset"
		  44 0 0 0 	   "translated table offset"
		  5 0 0 0 	   "hash table size"
		  60 0 0 0 	   "hash table offset"
		
		0 0 0 0 80 0 0 0 5 0 0 0 81 0 0 0 72 0 0 0 87 0 0 0 5 0 0 0 160 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 2 0 0 0 0 0 0 0 0 72 101 108 108 111 0 67 111 110 116 101 110 116 45 84 121 112 101 58 32 116 101 120 116 47 112 108 97 105 110 59 32 99 104 97 114 115 101 116 61 117 116 102 45 56 10 67 111 110 116 101 110 116 45 84 114 97 110 115 102 101 114 45 69 110 99 111 100 105 110 103 58 32 56 98 105 116 10 0 87 111 114 108 100 0]		
	
]

{ #category : #tests }
MOFileReaderTest >> testReading [

	| reader mb |
	mb := MultiByteBinaryOrTextStream with: self littleEndianExampleFile.
	mb reset.
	
	reader := MOFileReader on: mb.
	reader read.
	
	self assert: reader translations size = 2.
		 
]

{ #category : #tests }
MOFileReaderTest >> testReadingHeader [

	|reader|
	reader := MOFileReader on: self littleEndianExampleFile readStream.
	reader readHeader.
	
	self 
		assert: reader isLittleEndian;
		assert: reader revision equals: 0;
		assert: reader numberOfStrings equals: 2;
		assert: reader originalTableOffset equals: 28;
		assert: reader translatedTableOffset equals: 44.
		 
]
