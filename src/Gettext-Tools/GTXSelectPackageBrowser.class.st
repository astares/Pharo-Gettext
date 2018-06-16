"
Used to select a package
"
Class {
	#name : #GTXSelectPackageBrowser,
	#superclass : #ComposableModel,
	#instVars : [
		'toSelectModel',
		'selectedModel',
		'addButtonModel',
		'addAllButtonModel',
		'nextButtonModel',
		'removeAllButtonModel',
		'removeButtonModel'
	],
	#category : #'Gettext-Tools-UI-Components'
}

{ #category : #specs }
GTXSelectPackageBrowser class >> defaultSpec [
	<spec>
	
	^ SpecLayout composed
		newColumn: [:c |
			c
			newRow: [:r |
				r 
					add: #toSelectModel; 
					addSplitter;
					add:  #selectedModel];
			newRow: [:r |
				r 
					add:#addButtonModel;
					add:#addAllButtonModel;
					add:#removeButtonModel;
					add:#removeAllButtonModel;
					add: #nextButtonModel ] height: 25 ]
]

{ #category : #examples }
GTXSelectPackageBrowser class >> example [

	self open
]

{ #category : #'instance creation' }
GTXSelectPackageBrowser class >> open [
	<script>
	self new items: RPackageOrganizer default packages;
		openWithSpec 
]

{ #category : #accessing }
GTXSelectPackageBrowser >> addAllButtonModel [
	^ addAllButtonModel
]

{ #category : #'private - actions' }
GTXSelectPackageBrowser >> addAllItems [

	| tmp |
	tmp := self sort: (selectedModel listItems asOrderedCollection addAll: (toSelectModel listItems); yourself ).
	selectedModel  items: tmp.
	toSelectModel  items: {}.
	toSelectModel updateList.
	selectedModel updateList.  	  
]

{ #category : #accessing }
GTXSelectPackageBrowser >> addButtonModel [
	^ addButtonModel
]

{ #category : #'private - actions' }
GTXSelectPackageBrowser >> addItems [

	toSelectModel selectedItems
		ifNotNil: [ :items |  
			selectedModel items: (self sort: (selectedModel listItems asOrderedCollection addAll: items; yourself) ).
			toSelectModel items: (self sort: (toSelectModel listItems asOrderedCollection removeAll: items; yourself) ) ].
		toSelectModel updateList.
		selectedModel updateList.  	  
]

{ #category : #initialization }
GTXSelectPackageBrowser >> initialize [

	| wrappingBlock |
	super initialize.
		
	toSelectModel := self instantiate: ListModel.
	selectedModel := self instantiate: ListModel.
	selectedModel beMultipleSelection.
	toSelectModel beMultipleSelection.
	
	wrappingBlock := [ :package | package packageName ].
	toSelectModel displayBlock: wrappingBlock.
	selectedModel displayBlock: wrappingBlock.
]

{ #category : #'private - initialization' }
GTXSelectPackageBrowser >> initializeButtons [

	self instantiateModels: #(
		addButtonModel ButtonModel
		addAllButtonModel ButtonModel 
		removeButtonModel ButtonModel
		removeAllButtonModel ButtonModel
		nextButtonModel ButtonModel ).
		
	addButtonModel
		state: false;
		label: 'Add';
		action: [ self addItems ].

	addAllButtonModel
		state: false;
		label: 'Add All';
		action: [ self addAllItems].
	
	removeButtonModel
		state: false;
		label: 'Remove';
		action: [ self removeItems ].
	
	removeAllButtonModel
		state: false;
		label: 'Remove All';
		action: [ self removeAllItems ].
	
	nextButtonModel
		state: false;
		label: 'Done';
		action: [ self nextAction ].
	

]

{ #category : #'private - initialization' }
GTXSelectPackageBrowser >> initializeLists [
	 
]

{ #category : #initialization }
GTXSelectPackageBrowser >> initializeWidgets [
	self 
		initializeLists;
		initializeButtons;
		setFocusOrder 
]

{ #category : #accessing }
GTXSelectPackageBrowser >> items: aCollection [
	"Set the elements to be analysed"
	
	toSelectModel items: (self sort: aCollection)

]

{ #category : #'private - actions' }
GTXSelectPackageBrowser >> nextAction [
	
	| filter |
 
	filter := self selectedModel listItems.
	(TranslationStringFinder allStringsReceivingMessage: #translated inPackages: filter) inspect.
	"self window close"
]

{ #category : #accessing }
GTXSelectPackageBrowser >> nextButtonModel [
	^ nextButtonModel
]

{ #category : #accessing }
GTXSelectPackageBrowser >> removeAllButtonModel [
	^ removeAllButtonModel
]

{ #category : #'private - actions' }
GTXSelectPackageBrowser >> removeAllItems [

	| tmp |
	tmp := self sort: (toSelectModel listItems asOrderedCollection addAll: (selectedModel listItems);yourself ).
	toSelectModel   items: tmp.
	selectedModel items: {}.
	toSelectModel updateList.
	selectedModel updateList.  	  
]

{ #category : #accessing }
GTXSelectPackageBrowser >> removeButtonModel [
	^ removeButtonModel
]

{ #category : #'private - actions' }
GTXSelectPackageBrowser >> removeItems [
	
	selectedModel selectedItems
		ifNotNil: [:items | 
			toSelectModel items: ( self sort: (toSelectModel listItems asOrderedCollection addAll: items; yourself)).
			selectedModel items: (self sort: (selectedModel listItems asOrderedCollection removeAll: items; yourself)).
			].
		toSelectModel updateList.
		selectedModel updateList.  	  
]

{ #category : #accessing }
GTXSelectPackageBrowser >> selectedModel [
	^ selectedModel
]

{ #category : #'private - initialization' }
GTXSelectPackageBrowser >> setFocusOrder [

	self focusOrder
		add: addButtonModel;
		add: addAllButtonModel;
		add: removeButtonModel;
		add: removeAllButtonModel.
		
]

{ #category : #'private - utilities' }
GTXSelectPackageBrowser >> sort: aCollection [
	
	^ aCollection asOrderedCollection sort: [:e1 :e2 | (e1 asString) < (e2 asString)].
]

{ #category : #initialization }
GTXSelectPackageBrowser >> title [ 
	^'Select package'
]

{ #category : #accessing }
GTXSelectPackageBrowser >> toSelectModel [
	^ toSelectModel
]
