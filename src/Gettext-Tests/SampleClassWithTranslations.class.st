"
A sample class that provides some translatable texts
"
Class {
	#name : #SampleClassWithTranslations,
	#superclass : #Object,
	#category : #'Gettext-Tests-Export'
}

{ #category : #'some methods' }
SampleClassWithTranslations >> methodWithNoopTranslation [

	self foo: 'first text to translate' translatedNoop 
]

{ #category : #'some methods' }
SampleClassWithTranslations >> methodWithTranslation [

	self foo: 'first text to translate' translated 
]

{ #category : #'some methods' }
SampleClassWithTranslations >> methodWithTranslationInArray [

	 { 'first text to translate' translated } 
]
