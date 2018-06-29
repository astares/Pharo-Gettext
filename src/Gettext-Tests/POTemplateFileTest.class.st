"
Unit tests for POTemplateFile
"
Class {
	#name : #POTemplateFileTest,
	#superclass : #POFileTest,
	#category : #'Gettext-Tests-Model'
}

{ #category : #tests }
POTemplateFileTest >> testFileExtension [

	self assert: POTemplateFile fileExtension equals: 'pot'
]
