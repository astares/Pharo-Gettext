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

{ #category : #defaults }
POFileTest >> defaultTestClass [

	^POFile 
]

{ #category : #tests }
POFileTest >> testFileExtension [

	self assert: self defaultTestClass fileExtension equals: 'po'
]

{ #category : #tests }
POFileTest >> testHasHeader [

	self assert: POFile new header notNil
]
