"
Unit tests for POFile
"
Class {
	#name : #POFileTest,
	#superclass : #TestCase,
	#category : #'Gettext-Tests-Model'
}

{ #category : #tests }
POFileTest class >> shouldInheritSelectors [
	^ true
]

{ #category : #tests }
POFileTest >> testFileExtension [

	self assert: POFile fileExtension equals: 'po'
]

{ #category : #tests }
POFileTest >> testHasHeader [

	self assert: POFile new header notNil
]
