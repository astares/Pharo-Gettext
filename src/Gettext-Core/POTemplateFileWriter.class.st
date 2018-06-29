"
A writer for Portable Object (*.pot) files writing POTemplateFile instances
"
Class {
	#name : #POTemplateFileWriter,
	#superclass : #POFileWriter,
	#category : #'Gettext-Core-IO'
}

{ #category : #examples }
POTemplateFileWriter class >> example1 [

	|writer template|
	template := POTemplateFile new.
	template addTranslation: (POTranslation id: 'Hello World' message: 'Bonjour le monde').
	writer := self write: template on: String new writeStream.
	writer stream contents inspect
]

{ #category : #writing }
POTemplateFileWriter >> write [

	super write.
	stream cr.
	self writeTranslations
]

{ #category : #'private - writing' }
POTemplateFileWriter >> writeTranslation: aTranslation [

	stream 
		nextPutAll: 'msgid "';
		nextPutAll: aTranslation id;
		nextPut: $";
		cr;
		nextPutAll: 'msgstr "';
		nextPutAll: aTranslation message;
		nextPut: $"
		
]

{ #category : #'private - writing' }
POTemplateFileWriter >> writeTranslations [

	self portableObjectFile translations 
		do: [ :each | self writeTranslation: each ]
		separatedBy: [ stream cr; cr ]
]
