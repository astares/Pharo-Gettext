"
A translation within a template file
"
Class {
	#name : #POTranslation,
	#superclass : #Object,
	#instVars : [
		'id',
		'message',
		'reference'
	],
	#category : #'Gettext-Core-Model'
}

{ #category : #'instance creation' }
POTranslation class >> id: anID message: aString [

	^self id: anID message: aString reference: ''
]

{ #category : #'instance creation' }
POTranslation class >> id: anID message: aString reference: aReference [

	^(self basicNew)
		id: anID;
		message: aString;
		reference: aReference;
		yourself
]

{ #category : #accessing }
POTranslation >> id [
	^ id
]

{ #category : #accessing }
POTranslation >> id: anObject [
	id := anObject
]

{ #category : #initialization }
POTranslation >> initialize [
	super initialize.
	id := ''.
	message := ''.
	reference := ''
]

{ #category : #accessing }
POTranslation >> message [ 
	^ message 
]

{ #category : #accessing }
POTranslation >> message: aString [
	message := aString
]

{ #category : #accessing }
POTranslation >> reference [
	^ reference
]

{ #category : #accessing }
POTranslation >> reference: anObject [
	reference := anObject
]
