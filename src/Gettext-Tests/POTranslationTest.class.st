"
Unit tests for POTranslation
"
Class {
	#name : #POTranslationTest,
	#superclass : #TestCase,
	#instVars : [
		'translation'
	],
	#category : #'Gettext-Tests-Model'
}

{ #category : #defaults }
POTranslationTest >> defaultTestClass [

	^POTranslation 
]

{ #category : #running }
POTranslationTest >> setUp [

	super setUp.
	translation := self defaultTestClass new
]

{ #category : #tests }
POTranslationTest >> testInitialization [

	self 
		assert: translation id isEmpty;
		assert: translation message isEmpty;
		assert: translation reference isEmpty
]

{ #category : #tests }
POTranslationTest >> testInstanceCreation [

	| instance |
	instance := self defaultTestClass id: 'Hello' message: 'World'.
	
	self 
		assert: instance id equals: 'Hello';					
		assert: instance message equals: 'World'				
]

{ #category : #tests }
POTranslationTest >> testInstanceCreationWithReference [

	| instance |
	instance := self defaultTestClass id: 'Hello' message: 'World' reference: 'Foo>>bar'.
	
	self 
		assert: instance id equals: 'Hello';					
		assert: instance message equals: 'World';
		assert: instance reference equals: 'Foo>>bar'				
]
