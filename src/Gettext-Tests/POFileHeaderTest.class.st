"
Unit test for PO file headers
"
Class {
	#name : #POFileHeaderTest,
	#superclass : #TestCase,
	#category : #'Gettext-Tests-Model'
}

{ #category : #tests }
POFileHeaderTest >> testInitialization [ 

	|header|
	header := POFileHeader new.
	self assert: header fields notEmpty
]
