"
A writer for Portable Object (*.po) files writing POFile instances
"
Class {
	#name : #POFileWriter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'portableObjectFile'
	],
	#category : #'Gettext-Core-IO'
}

{ #category : #examples }
POFileWriter class >> example1 [

	|writer|
	writer := self write: POFile new on: String new writeStream.
	writer stream contents inspect
]

{ #category : #'instance creation' }
POFileWriter class >> write: aPOFile on: aStream [
 	"Write the given portable object file onto the given stream"
	
	^(self new)
		initPortableObjectFile: aPOFile;
		initStream: aStream;
		write;
		yourself
]

{ #category : #'private - initialization' }
POFileWriter >> initPortableObjectFile: aPOFile [

	portableObjectFile := aPOFile
]

{ #category : #'private - initialization' }
POFileWriter >> initStream: aStream [

	stream := aStream
]

{ #category : #'private - accessing' }
POFileWriter >> portableObjectFile [

	^portableObjectFile
]

{ #category : #'private - accessing' }
POFileWriter >> stream [

	^stream
]

{ #category : #writing }
POFileWriter >> write [

	self writeHeader
]

{ #category : #'private - writing' }
POFileWriter >> writeHeader [

	self portableObjectFile header fieldsDo: [:key :value | self writeHeader: key value: value]

]

{ #category : #'private - utilities' }
POFileWriter >> writeHeader: field value: aStringValue [ 
	"Write a header field entry"
	
	stream
		nextPut: $"; 
		nextPutAll: field;
		nextPut: $:;
		nextPut: Character space; 
		nextPutAll: aStringValue;
		nextPutAll: 	'\n';
		nextPut: $".
	self writeNewLine	
]

{ #category : #'private - utilities' }
POFileWriter >> writeNewLine [

	stream lf
]
