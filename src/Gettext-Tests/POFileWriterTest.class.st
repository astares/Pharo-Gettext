"
Unit tests for PO file writers
"
Class {
	#name : #POFileWriterTest,
	#superclass : #TestCase,
	#category : #'Gettext-Tests-IO'
}

{ #category : #tests }
POFileWriterTest >> testHeader [

	|writer file header |
	file := POFile new.
	header := file header.
	header fieldAt: 'X-Pharo-Feeling' put: 'Rocks'.
	
	writer := POFileWriter write: file on: String new writeStream.
	writer stream contents includes: '"X-Pharo-Feeling: Rocks"'
	
	
]
