"
The file header of a Portable object file
"
Class {
	#name : #POFileHeader,
	#superclass : #Object,
	#instVars : [
		'fields'
	],
	#category : #'Gettext-Core-Model'
}

{ #category : #'fields - default' }
POFileHeader >> contenTransferEncoding: aString [

	self fieldAt: #'Content-Transfer-Encoding' put: aString
]

{ #category : #'fields - default' }
POFileHeader >> contentTransferEncoding: aString [

	self fieldAt: #'Content-Transfer-Encoding' put: aString
]

{ #category : #'fields - default' }
POFileHeader >> contentType: aString [

	self fieldAt: #'Content-Type' put: aString
]

{ #category : #'fields - default' }
POFileHeader >> creationDate: dateString [

	self fieldAt: #'POT-Creation-Date' put: dateString
]

{ #category : #'private - utilities' }
POFileHeader >> currentDateAndTime [
	^ String
		streamContents: [:aStream | 
			aStream nextPutAll: Date today yyyymmdd;
				space.
			Time now
				print24: true
				showSeconds: false
				on: aStream.
			aStream nextPutAll: '-0000']
]

{ #category : #'private - defaults' }
POFileHeader >> defaultContentTransferEncoding [

	^'8bit'
	 
]

{ #category : #'private - defaults' }
POFileHeader >> defaultContentType [

	^'text/plain; charset=UTF-8'
]

{ #category : #accessing }
POFileHeader >> fieldAt: key put: value [
	"Put the given value at the given header key"
	
	^self fields at: key put: value
]

{ #category : #'private - accessing' }
POFileHeader >> fields [

	fields ifNil: [ fields := Dictionary new ].
	^fields
]

{ #category : #enumerating }
POFileHeader >> fieldsDo: aTwoArgumentBlock [
	"Iterate over the fields"
	
	fields associationsDo: [:each | 
		aTwoArgumentBlock value: each key value: each value ]
]

{ #category : #initialization }
POFileHeader >> initialize [
	"Initializes the receiver"

	super initialize.
	self 
		mimeVersion: '1.0';
		projectIDVersion: 'Pharo';
		creationDate: self currentDateAndTime;
		revisionDate: self currentDateAndTime;
		lastTranslator: '';
		languageTeam: '';
		contentType: self defaultContentType;
		contentTransferEncoding: self defaultContentTransferEncoding
	 
]

{ #category : #'fields - default' }
POFileHeader >> languageTeam: aString [

	self fieldAt: #'Language-Team' put: aString
]

{ #category : #'fields - default' }
POFileHeader >> lastTranslator: aString [

	self fieldAt: #'Last-Translator' put: aString
]

{ #category : #'fields - default' }
POFileHeader >> mimeVersion: versionString [

	self fieldAt: #'MIME-Version' put: versionString
]

{ #category : #printing }
POFileHeader >> printOn: aStream [

	self fieldsDo: [:key : value |
		aStream
			nextPut: $"; 
			nextPutAll: key;
			nextPut: $:;
			nextPut: Character space; 
			nextPutAll: value;
			nextPutAll: 	'\n';
			nextPut: $".
	aStream nextPut: Character lf ]	
]

{ #category : #'fields - default' }
POFileHeader >> projectIDVersion: aString [

	self fieldAt: #'Project-Id-Version' put: aString
]

{ #category : #'fields - default' }
POFileHeader >> revisionDate: dateString [

	self fieldAt: #'PO-Revision-Date' put: dateString
]

{ #category : #'fields - custom' }
POFileHeader >> systemVersion: aString [

	self fieldAt: 'X-Pharo-SystemVersion' put: aString
]
