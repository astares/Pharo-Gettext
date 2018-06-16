"
A manager for text domains
"
Class {
	#name : #TextDomainManager,
	#superclass : #Object,
	#classVars : [
		'TextDomains'
	],
	#category : #'Gettext-Core-Domains'
}

{ #category : #initialization }
TextDomainManager class >> initialize [
	"Initializes the receiver class"
	
	TextDomains := IdentityDictionary new.
	
]

{ #category : #accessing }
TextDomainManager class >> textDomains [

	^TextDomains 
]
