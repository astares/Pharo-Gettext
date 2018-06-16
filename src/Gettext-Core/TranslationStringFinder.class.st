"
An utility class to find strings that should be translated
"
Class {
	#name : #TranslationStringFinder,
	#superclass : #Object,
	#instVars : [
		'packagesToLookAt',
		'messageToReceive'
	],
	#category : #'Gettext-Core-Export'
}

{ #category : #'instance creation' }
TranslationStringFinder class >> allStringsInPackageNamed: aString [ 

	^self allStringsReceivingMessage: #translated inPackageNamed: aString 
]

{ #category : #'instance creation' }
TranslationStringFinder class >> allStringsReceivingMessage: aSymbol [
	"Search in all packages for strings receiving the given method"
	
	^self allStringsReceivingMessage: aSymbol inPackages: RPackageOrganizer default packages 
	 
]

{ #category : #'instance creation' }
TranslationStringFinder class >> allStringsReceivingMessage: aSymbol inPackageNamed: aString [ 

	| filter |
	filter := Array with: (RPackageOrganizer default packageNamed: aString).
	^self allStringsReceivingMessage: aSymbol inPackages: filter
]

{ #category : #'instance creation' }
TranslationStringFinder class >> allStringsReceivingMessage: aSymbol inPackages: aCollection [ 
	 
	^(self new)
		packagesToLookAt: aCollection;
		messageToReceive: aSymbol;
		searchAllStrings
]

{ #category : #examples }
TranslationStringFinder class >> example1 [
	"self example1"
	
	(self allStringsInPackageNamed: 'Kernel') inspect 
]

{ #category : #examples }
TranslationStringFinder class >> example2 [
	"self example2"
	
	(self allStringsReceivingMessage: #translated) inspect

]

{ #category : #examples }
TranslationStringFinder class >> example3 [
	"self example3"
	
	| filter |
	filter := Array with: self package.
	(self allStringsReceivingMessage: #translated inPackages: filter) asSortedCollection inspect

]

{ #category : #examples }
TranslationStringFinder class >> example4 [
	"self example4"
	
	(self allStringsReceivingMessage: #translated inPackageNamed: 'Kernel') inspect 
]

{ #category : #examples }
TranslationStringFinder class >> example5 [
	"self example5"
	
	(self halt allStringsReceivingMessage: #translated inPackageNamed: 'Foo') inspect 
]

{ #category : #private }
TranslationStringFinder >> findStringLiteralsIn: aParseNode addTo: aCollection [
	aParseNode nodesDo: [:node | 
		node isMessage ifTrue: [
			node selector = messageToReceive ifTrue: [
				aCollection add: node]]].
	^aCollection
]

{ #category : #private }
TranslationStringFinder >> findWordsWith: aSymbol in: aMethodReference [ 
	"Find words for translation with the symbol in a method. See
	LanguageEditorTest >>testFindTranslatedWords"
	"| message | 
	message := MethodReference new setStandardClass: Morph class
	methodSymbol: #supplementaryPartsDescriptions.
	self new findWordsWIth: #translatedNoop in: message"
	| messages  aParseNode keywords |

	aParseNode := aMethodReference methodClass parseTreeFor: aMethodReference selector.
	"Find from string literal"
	messages := Set new.
 
	self
		search: aSymbol
		messageNode: aParseNode
		addTo: messages.
	keywords := OrderedCollection new.
	messages
		select: [:aMessageNode | aMessageNode receiver isLiteralNode]
		thenDo: [:aMessageNode | keywords add: aMessageNode receiver value ].
	^keywords	
	
]

{ #category : #accessing }
TranslationStringFinder >> messageToReceive: aSymbol [

	messageToReceive := aSymbol
]

{ #category : #accessing }
TranslationStringFinder >> packagesToLookAt: aCollection [

	packagesToLookAt := aCollection collect: [:each | each name asSymbol ]
]

{ #category : #private }
TranslationStringFinder >> search: aString messageNode: aParseNode addTo: aCollection [ 
	aParseNode nodesDo: [:node | 
		node isMessage ifTrue: [	 
			node selector = messageToReceive ifTrue: [
				aCollection add: node]]].
	^ aCollection
]

{ #category : #searching }
TranslationStringFinder >> searchAllStrings [
	| methodReferences keywords |
	methodReferences := SystemNavigation default allCallsOn: messageToReceive.
	"Apply package filter"
	methodReferences := methodReferences select: [:each | packagesToLookAt includes: each package name asSymbol ].
	
	^ methodReferences inject: OrderedCollection new into: [:list :next |
		keywords := self findWordsWith: messageToReceive in: next.
		keywords
			ifNotEmpty: [list add: next -> keywords].
		list]
]
