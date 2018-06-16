"
I hold criteria for deciding wheter a package belongs to domain. 
- packagePrefixes is collection of prefix of class category.
- packages is for specifying fine grained criterion.

"
Class {
	#name : #TextDomain,
	#superclass : #Object,
	#instVars : [
		'packagePrefixes',
		'packages'
	],
	#category : #'Gettext-Core-Domains'
}

{ #category : #initialization }
TextDomain >> initialize [
	super initialize.
	packagePrefixes := Set new.
	packages := IdentitySet new.

]

{ #category : #accessing }
TextDomain >> packagePrefixes [

	^packagePrefixes
]

{ #category : #accessing }
TextDomain >> packages [

	^packages 
]
