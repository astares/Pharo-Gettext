"
Unit tests for translation string finding
"
Class {
	#name : #TranslationStringFinderTest,
	#superclass : #TestCase,
	#category : #'Gettext-Tests-Export'
}

{ #category : #testing }
TranslationStringFinderTest >> testInstanceCreationWithDifferentSelectorInAllPackages [

	|translations|
	translations := TranslationStringFinder allStringsReceivingMessage: #translatedNoop.
	self assert: translations notEmpty.
	
	self assert: (translations anySatisfy: [ :each | each key = (SampleClassWithTranslations>>#methodWithNoopTranslation) asRingDefinition ]).
	 
]

{ #category : #testing }
TranslationStringFinderTest >> testInstanceCreationWithPackageName [

 	|translations|
	translations := TranslationStringFinder allStringsInPackageNamed: self class package name.
	self assert: translations notEmpty.
	
	self assert: (translations anySatisfy: [ :each | each key = (SampleClassWithTranslations>>#methodWithTranslation) asRingDefinition ]).
	self assert: (translations anySatisfy: [ :each | each key = (SampleClassWithTranslations>>#methodWithTranslationInArray) asRingDefinition ]).
		

	
]

{ #category : #testing }
TranslationStringFinderTest >> testInstanceCreationWithSelectorAndPackageName [

 	|translations|
	translations := TranslationStringFinder allStringsReceivingMessage: #translated inPackageNamed: self class package name.
	self assert: translations notEmpty.
	
	self assert: (translations anySatisfy: [ :each | each key = (SampleClassWithTranslations>>#methodWithTranslation) asRingDefinition ]).
	self assert: (translations anySatisfy: [ :each | each key = (SampleClassWithTranslations>>#methodWithTranslationInArray) asRingDefinition ]).
		

	
]

{ #category : #testing }
TranslationStringFinderTest >> testInstanceCreationWithSelectorAndPackages [

	|packages translations|
	packages := OrderedCollection with: self class package.
	translations := TranslationStringFinder allStringsReceivingMessage: #translated inPackages: packages.
	self assert: translations notEmpty.
	
	self assert: (translations anySatisfy: [ :each | each key = (SampleClassWithTranslations>>#methodWithTranslation) asRingDefinition ]).
	self assert: (translations anySatisfy: [ :each | each key = (SampleClassWithTranslations>>#methodWithTranslationInArray) asRingDefinition ]).
		

	
]
