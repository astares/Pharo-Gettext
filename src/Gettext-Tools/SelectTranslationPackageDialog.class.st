"
Used to select a package
"
Class {
	#name : #SelectTranslationPackageDialog,
	#superclass : #ComposablePresenter,
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
SelectTranslationPackageDialog class >> defaultSpec [
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
					add:#removeAllButtonModel ] height: 25 ]
]

{ #category : #examples }
SelectTranslationPackageDialog class >> example [

	self open
		selectedPackages inspect
	
]

{ #category : #'instance creation' }
SelectTranslationPackageDialog class >> open [
	<script>
	^self openOn: World
]

{ #category : #'instance creation' }
SelectTranslationPackageDialog class >> openOn: parentWindow [
	<script: 'self openOn: World'>
	| dialog |
	dialog := (self new) 
				items: RPackageOrganizer default packages.
	dialog openDialogWithSpec.
	parentWindow openModal: dialog window window widget.
	^dialog  
]

{ #category : #accessing }
SelectTranslationPackageDialog >> addAllButtonModel [
	^ addAllButtonModel
]

{ #category : #'private - actions' }
SelectTranslationPackageDialog >> addAllItems [

	| tmp |
	tmp := self sort: (selectedModel listItems asOrderedCollection addAll: (toSelectModel listItems); yourself ).
	selectedModel  items: tmp.
	toSelectModel  items: {}.
	toSelectModel updateList.
	selectedModel updateList.  	  
]

{ #category : #accessing }
SelectTranslationPackageDialog >> addButtonModel [
	^ addButtonModel
]

{ #category : #'private - actions' }
SelectTranslationPackageDialog >> addItems [

	toSelectModel selectedItems
		ifNotNil: [ :items |  
			selectedModel items: (self sort: (selectedModel listItems asOrderedCollection addAll: items; yourself) ).
			toSelectModel items: (self sort: (toSelectModel listItems asOrderedCollection removeAll: items; yourself) ) ].
		toSelectModel updateList.
		selectedModel updateList.  	  
]

{ #category : #initialization }
SelectTranslationPackageDialog >> initialize [

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
SelectTranslationPackageDialog >> initializeButtons [

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
SelectTranslationPackageDialog >> initializeLists [
	 
]

{ #category : #initialization }
SelectTranslationPackageDialog >> initializeWidgets [
	self 
		initializeLists;
		initializeButtons;
		setFocusOrder 
]

{ #category : #accessing }
SelectTranslationPackageDialog >> items: aCollection [
	"Set the elements to be analysed"
	
	toSelectModel items: (self sort: aCollection)

]

{ #category : #'private - actions' }
SelectTranslationPackageDialog >> nextAction [
	
	| filter | 
	filter :=  self selectedModel listItems.
	
	"self window close"
]

{ #category : #accessing }
SelectTranslationPackageDialog >> nextButtonModel [
	^ nextButtonModel
]

{ #category : #accessing }
SelectTranslationPackageDialog >> removeAllButtonModel [
	^ removeAllButtonModel
]

{ #category : #'private - actions' }
SelectTranslationPackageDialog >> removeAllItems [

	| tmp |
	tmp := self sort: (toSelectModel listItems asOrderedCollection addAll: (selectedModel listItems);yourself ).
	toSelectModel   items: tmp.
	selectedModel items: {}.
	toSelectModel updateList.
	selectedModel updateList.  	  
]

{ #category : #accessing }
SelectTranslationPackageDialog >> removeButtonModel [
	^ removeButtonModel
]

{ #category : #'private - actions' }
SelectTranslationPackageDialog >> removeItems [
	
	selectedModel selectedItems
		ifNotNil: [:items | 
			toSelectModel items: ( self sort: (toSelectModel listItems asOrderedCollection addAll: items; yourself)).
			selectedModel items: (self sort: (selectedModel listItems asOrderedCollection removeAll: items; yourself)).
			].
		toSelectModel updateList.
		selectedModel updateList.  	  
]

{ #category : #accessing }
SelectTranslationPackageDialog >> selectedModel [
	^ selectedModel
]

{ #category : #accessing }
SelectTranslationPackageDialog >> selectedPackages [

	^self selectedModel listItems

]

{ #category : #'private - initialization' }
SelectTranslationPackageDialog >> setFocusOrder [

	self focusOrder
		add: addButtonModel;
		add: addAllButtonModel;
		add: removeButtonModel;
		add: removeAllButtonModel.
		
]

{ #category : #'private - utilities' }
SelectTranslationPackageDialog >> sort: aCollection [
	
	^ aCollection asOrderedCollection sort: [:e1 :e2 | (e1 asString) < (e2 asString)].
]

{ #category : #initialization }
SelectTranslationPackageDialog >> title [ 
	^'Select package'
]

{ #category : #accessing }
SelectTranslationPackageDialog >> toSelectModel [
	^ toSelectModel
]
