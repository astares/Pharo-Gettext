"
Browser for text domains
"
Class {
	#name : #TextDomainBrowser,
	#superclass : #ComposablePresenter,
	#instVars : [
		'textDomainsModel'
	],
	#category : #'Gettext-Tools-UI'
}

{ #category : #specs }
TextDomainBrowser class >> defaultSpec [
	<spec>
	
	^SpecLayout composed
		newColumn: [:column |
			column
			newRow: [:row |
				row 
					add: self leftSpec ]]
]

{ #category : #examples }
TextDomainBrowser class >> example [
	
	self open
]

{ #category : #accessing }
TextDomainBrowser class >> icon [
	"Return the icon"
	
	^(GetTextIcons iconNamed: #gettextBrowseTranslationsIcon)
]

{ #category : #specs }
TextDomainBrowser class >> leftSpec [
	<spec>
	| searchBarOffset |
	searchBarOffset := 5 + StandardFonts defaultFont height + 10.
 
	^SpecLayout composed 
		add: #textDomainsModel origin: 0@0 corner: 1@1 offsetOrigin: 0@searchBarOffset offsetCorner: 0@0;
		add: #textDomainsSearchField origin: 0@0 corner: 1@0 offsetOrigin: 0@0 offsetCorner: 0@searchBarOffset
]

{ #category : #'world menu' }
TextDomainBrowser class >> menuCommandOn: aBuilder [

	<worldMenu>		 
		
	(aBuilder item: #'Text Domain Browser')
		parent: #'Gettext';
		order: 0;
		action: [ self open ]; 
		icon: self icon.
	aBuilder withSeparatorAfter.		
]

{ #category : #'instance creation' }
TextDomainBrowser class >> open [
	<script>	
	^(self new)
		title: 'TextDomainBrowser' translated;
		openWithSpec 
]

{ #category : #initialization }
TextDomainBrowser >> initialize [

	super initialize.		
	textDomainsModel := self instantiate: IconListPresenter. 
	textDomainsModel displayBlock: [ :textDomain | textDomain asString ].
	textDomainsModel items: #('Hello' 'World').
	textDomainsModel 
		 icons: [:e |  GetTextIcons iconNamed: #gettextTextDomainIcon ]. 
]

{ #category : #'private - initialization' }
TextDomainBrowser >> initializeWidgets [
]

{ #category : #'private - accessing' }
TextDomainBrowser >> textDomainsModel [

	^textDomainsModel
]

{ #category : #'private - accessing' }
TextDomainBrowser >> textDomainsSearchAccept: aString [ 
	 
]

{ #category : #'private - accessing' }
TextDomainBrowser >> textDomainsSearchField [
	
	^ SearchMorph new
		model: self;
		setIndexSelector: #textDomainsSearchAccept:; 
		updateSelector: #textDomainsSearchAccept:;
		searchList: #();
		asSpecAdapter
]
