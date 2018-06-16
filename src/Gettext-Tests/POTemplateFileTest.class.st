"
Unit tests for POTemplateFile
"
Class {
	#name : #POTemplateFileTest,
	#superclass : #TestCase,
	#category : #'Gettext-Tests-Model'
}

{ #category : #tests }
POTemplateFileTest >> testFileExtension [

	self assert: POTemplateFile fileExtension equals: 'pot'
]
