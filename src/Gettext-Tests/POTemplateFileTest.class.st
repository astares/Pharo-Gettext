"
Unit tests for POTemplateFile
"
Class {
	#name : #POTemplateFileTest,
	#superclass : #POFileTest,
	#category : #'Gettext-Tests-Model'
}

{ #category : #defaults }
POTemplateFileTest >> defaultTestClass [

	^POTemplateFile 
]

{ #category : #tests }
POTemplateFileTest >> testFileExtension [

	self assert: self defaultTestClass fileExtension equals: 'pot'
]
