"
A model for a Portable Object (*.pot) template file 
"
Class {
	#name : #POTemplateFile,
	#superclass : #POFile,
	#category : #'Gettext-Core-Model'
}

{ #category : #defaults }
POTemplateFile class >> fileExtension [
	"The file extension for a portable object template file is *.pot"
	
	^'pot'
]
