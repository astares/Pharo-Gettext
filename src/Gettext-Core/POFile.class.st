"
An in-memory model for a Portable Object (*.po) file
"
Class {
	#name : #POFile,
	#superclass : #Object,
	#instVars : [
		'header'
	],
	#category : #'Gettext-Core-Model'
}

{ #category : #defaults }
POFile class >> fileExtension [
	"The file extension for a portable object file is *.po"
	
	^'po'
]

{ #category : #accessing }
POFile >> header [
	"Return the receivers header"
	
	^header
]

{ #category : #initialization }
POFile >> initialize [
	"Initializes the receiver"
	
	super initialize.
	header := POFileHeader new
	
]
