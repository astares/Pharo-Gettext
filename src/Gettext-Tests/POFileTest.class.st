"
Unit tests for POFile
"
Class {
	#name : #POFileTest,
	#superclass : #TestCase,
	#category : #'Gettext-Tests-Model'
}

{ #category : #tests }
POFileTest >> testFileExtension [

	self assert: POFile fileExtension = 'po'
]

{ #category : #tests }
POFileTest >> testHasHeader [

	self assert: POFile new header notNil
]
