"
Browse the senders of #translate
"
Class {
	#name : #TranslationsBrowser,
	#superclass : #ComposablePresenter,
	#instVars : [
		'packagesModel',
		'methodsModel',
		'translationsModel',
		'packageFilter',
		'packages'
	],
	#category : #'Gettext-Tools-UI'
}

{ #category : #specs }
TranslationsBrowser class >> defaultSpec [
	<spec>
	
	^SpecLayout composed
		newColumn: [:column |
			column
			newRow: [:row |
				row 
					add: self leftSpec; 
					addSplitter;
					add:  #methodsModel;
					addSplitter;
					add:  #translationsModel ]
		 ]
]

{ #category : #examples }
TranslationsBrowser class >> example [
	"self example"

	self open
]

{ #category : #accessing }
TranslationsBrowser class >> icon [
	"Return the icon"
	
	^(GetTextIcons iconNamed: #gettextBrowseTranslationsIcon)
]

{ #category : #specs }
TranslationsBrowser class >> leftSpec [
	<spec>
	| searchBarOffset |
	searchBarOffset := 5 + StandardFonts defaultFont height + 10.
	^SpecLayout composed 
		add: #packagesModel origin: 0@0 corner: 1@1 offsetOrigin: 0@searchBarOffset offsetCorner: 0@0;
		add: #packageSearchField origin: 0@0 corner: 1@0 offsetOrigin: 0@0 offsetCorner: 0@searchBarOffset
]

{ #category : #'world menu' }
TranslationsBrowser class >> menuCommandOn: aBuilder [
	<worldMenu>		 
		
	(aBuilder item: #'Translations Browser')
		parent: #'Gettext';
		order: 0;
		action:[self open]; 
		icon: self icon.
	aBuilder withSeparatorAfter.		
]

{ #category : #'instance creation' }
TranslationsBrowser class >> open [
	<script>
	self new packages: RPackageOrganizer default packages;
		openWithSpec 
]

{ #category : #'private - actions' }
TranslationsBrowser >> browseMethod [

	methodsModel selectedItem key browse
]

{ #category : #'private - actions' }
TranslationsBrowser >> generatePOTFile [

	packagesModel selectedItem inspect
]

{ #category : #initialization }
TranslationsBrowser >> initialExtent [

	^800@500
]

{ #category : #initialization }
TranslationsBrowser >> initialize [

	super initialize.		
	packagesModel := self instantiate: IconListPresenter.
	packagesModel beMultipleSelection.
	packagesModel displayBlock: [ :package | package packageName ].
	packagesModel 
		 icons: [:e |  Smalltalk ui icons iconNamed: #package ].
 
	packagesModel whenSelectionChanged: [ self onPackageSelectionChanged ].
	packagesModel menu: [ :aMenu | self packageListMenu: aMenu ].	
		
	methodsModel := self instantiate: ListModel.
	methodsModel beSingleSelection.	
	methodsModel displayBlock: [ :association  | association key asString ].
	methodsModel whenSelectionChanged: [ self onMethodSelectionChanged ].
	methodsModel menu: [ :aMenu | self methodListMenu: aMenu ].		
	
	translationsModel  := self instantiate: IconListModel.
	translationsModel beSingleSelection.
	translationsModel displayBlock: [ :method  | method asString ].
	translationsModel icons: [:e | (GetTextIcons iconNamed: #gettextTranslationIcon) ]
]

{ #category : #'private - initialization' }
TranslationsBrowser >> initializeWidgets [
]

{ #category : #'private - menues' }
TranslationsBrowser >> methodListMenu: aMenu [
	methodsModel selectedItem ifNil: [ ^nil ].
	aMenu target: self.
	aMenu addTitle: 'Method' translated.
	aMenu	
		add: 'Browse' selector: #browseMethod.
	^aMenu
]

{ #category : #'private - accessing' }
TranslationsBrowser >> methodsModel [
	^methodsModel
]

{ #category : #'private - events' }
TranslationsBrowser >> onMethodSelectionChanged [
	| translations method |
	method := self methodsModel selectedItem.
	method isNil
		ifTrue: [ translationsModel items: #() ]
		ifFalse: [ 
			translations := self methodsModel selectedItem value.
			translationsModel items: translations ]
]

{ #category : #'private - events' }
TranslationsBrowser >> onPackageSelectionChanged [

	| filter result |
	methodsModel items: #().
	translationsModel items:#().
	filter := self packagesModel selectedItems.	 
	result := (TranslationStringFinder allStringsReceivingMessage: #translated inPackages: filter). 
	methodsModel items: (self sort: result).
	
]

{ #category : #'private - filtering' }
TranslationsBrowser >> packageFilterPattern: aRxMatcher [ 
	 
	 self packagesModel items: 
		(aRxMatcher isNil ifTrue: [self packages ]
					    ifFalse: [ self packages select: [ :each| aRxMatcher search: each asString ]]).

	 
]

{ #category : #'private - menues' }
TranslationsBrowser >> packageListMenu: aMenu [
	packagesModel selectedItem ifNil: [ ^nil ].
	aMenu target: self.
	aMenu addTitle: 'Package' translated.
	aMenu	
		add: 'Generate POT file' selector: #generatePOTFile.
	^aMenu
]

{ #category : #'private - filtering' }
TranslationsBrowser >> packageSearchAccept: aString [

	 aString isEmptyOrNil
		ifTrue: [ self packageFilterPattern: nil ]
		ifFalse: [ self packageFilterPattern: 
					([ aString asRegexIgnoringCase ] on: RegexSyntaxError do: [ aString ])].
 
]

{ #category : #'private - accessing' }
TranslationsBrowser >> packageSearchField [
	
	^ SearchMorph new
		model: self;
		setIndexSelector: #packageSearchAccept:; 
		updateSelector: #packageSearchAccept:;
		searchList: #();
		asSpecAdapter
]

{ #category : #accessing }
TranslationsBrowser >> packages [
	^ packages
]

{ #category : #accessing }
TranslationsBrowser >> packages: aCollection [
	packages := self sort: aCollection.
	packagesModel items: (self sort: aCollection)

]

{ #category : #'private - accessing' }
TranslationsBrowser >> packagesModel [
	^packagesModel
]

{ #category : #'private - utilities' }
TranslationsBrowser >> sort: aCollection [
	
	^ aCollection asOrderedCollection sort: [:e1 :e2 | (e1 asString) < (e2 asString)].
]

{ #category : #accessing }
TranslationsBrowser >> taskbarIcon [

	^ self class icon
]

{ #category : #accessing }
TranslationsBrowser >> title [

	^'Strings available for translation'
]

{ #category : #'private - accessing' }
TranslationsBrowser >> translationsModel [

	^translationsModel 
]
