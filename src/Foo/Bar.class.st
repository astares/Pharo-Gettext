Class {
	#name : #Bar,
	#superclass : #Object,
	#category : #Foo
}

{ #category : #'as yet unclassified' }
Bar class >> test3 [

	'class side' translated
]

{ #category : #'as yet unclassified' }
Bar >> test [
	"Example in an array"
	
	'stringToTranslate' translate.
	'stringToTranslate' translated.
	
]

{ #category : #'as yet unclassified' }
Bar >> test2 [
	"Example in an array"
	
	{'hello' translated. 'more' foo }
	
]
