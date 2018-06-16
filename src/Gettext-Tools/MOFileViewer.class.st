"
Editor for MOFile
"
Class {
	#name : #MOFileViewer,
	#superclass : #GettextTool,
	#instVars : [
		'list',
		'reader'
	],
	#category : #'Gettext-Tools-UI'
}

{ #category : #specs }
MOFileViewer class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c 
				add: #menu height: self toolbarHeight;
				add: #list  ];
		yourself
]

{ #category : #examples }
MOFileViewer class >> example1 [

	self open
]

{ #category : #'world menu' }
MOFileViewer class >> menuCommandOn: aBuilder [
	<worldMenu>	
		
	(aBuilder item: #'MO Viewer')
		parent: #'Gettext';
		order: 2;
		action:[self open]; 
		icon: (GetTextIcons iconNamed: #gettextMOFileViewerIcon).
]

{ #category : #'private - utilities' }
MOFileViewer >> importFile: filename [
	
	| stream |
	stream := filename asFileReference readStream.
	[ reader := (MOFileReader on: stream).
	  reader read.
	 ] ensure: [ stream close ].
	self updateList
]

{ #category : #'private - initialization' }
MOFileViewer >> initializeList [
	 
	| keyColumn columns valueColumn |
	list := self instantiate: TreeModel.
	keyColumn := TreeColumnModel new
		displayBlock: [ :node | node content asString ];
		headerLabel: 'Key'.
	valueColumn := TreeColumnModel new
		displayBlock: [ :node | node content asString ];
		headerLabel: 'Value'.	
	columns := OrderedCollection with: keyColumn with: valueColumn.	 
		
	list columns: columns.
	
]

{ #category : #'private - initialization' }
MOFileViewer >> initializeMenu [
	menu := MenuModel new
		addGroup: [ :group | 
			group
				addItem: [ :item | 
					item
						name: nil;
						description: 'Open file';
						icon: Smalltalk ui icons openIcon;
						action: [ self openFile ] ] ].
	menu applyTo: self
]

{ #category : #initialization }
MOFileViewer >> initializeWidgets [
	self 
		initializeMenu;
		initializeList
]

{ #category : #accessing }
MOFileViewer >> list [
	^ list
]

{ #category : #accessing }
MOFileViewer >> menu [
	^ menu
]

{ #category : #'private - actions' }
MOFileViewer >> openFile [

	| filename |
	filename := UITheme builder 
							chooseFileName: 'Choose a .mo file' 
							extensions: #('mo') 
							path: nil 
							preview: nil.
	filename isNil ifTrue:[^nil].
	self importFile: filename
]

{ #category : #accessing }
MOFileViewer >> reader [

	^reader
]

{ #category : #accessing }
MOFileViewer >> title [

	^ 'MO Editor'
]

{ #category : #'private - utilities' }
MOFileViewer >> updateList [
	 
	list roots: reader translations.
	reader translations inspect
]
