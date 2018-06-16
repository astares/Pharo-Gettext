"
Superclass for gettext UI tools
"
Class {
	#name : #GettextTool,
	#superclass : #ComposableModel,
	#instVars : [
		'menu'
	],
	#category : #'Gettext-Tools-UI'
}

{ #category : #specs }
GettextTool class >> defaultSpec [

	self subclassResponsibility 
]

{ #category : #'world menu' }
GettextTool class >> menuCommandOn: aBuilder [

	<worldMenu>	
 
	(aBuilder item: #'Gettext')
		parent: 'Tools';
		order: 20;
		action:[self open]; 
		icon: (GetTextIcons iconNamed: #gettextIcon).
	aBuilder withSeparatorAfter.
]

{ #category : #'instance creation' }
GettextTool class >> open [

	^(self new)
		openWithSpec;
		yourself
]

{ #category : #initialization }
GettextTool >> initializeWidgets [

	self subclassResponsibility 
]

{ #category : #accessing }
GettextTool >> menu [
	^ menu
]
