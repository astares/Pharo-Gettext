"
This tool can be used to load, edit and save gettext portable object files (*.po files).

You can also use it to generate a file from selected packagesn and compiler into a machine object file (*.mo file)
"
Class {
	#name : #POFileEditor,
	#superclass : #GettextTool,
	#instVars : [
		'text'
	],
	#category : #'Gettext-Tools-UI'
}

{ #category : #specs }
POFileEditor class >> defaultSpec [
	<spec: #default>
	
	^ SpecLayout composed
		newColumn: [ :c | 
			c 
				add: #menu height: self toolbarHeight;
				add: #text ];
		yourself
]

{ #category : #examples }
POFileEditor class >> example1 [

	self open
]

{ #category : #'world menu' }
POFileEditor class >> menuCommandOn: aBuilder [

	<worldMenu>		 
		
	(aBuilder item: #'PO Editor')
		parent: #'Gettext';
		order: 1;
		action:[self open]; 
		icon: (GetTextIcons iconNamed: #gettextPOEditIcon).
]

{ #category : #'private - actions' }
POFileEditor >> compile [
	"maybe use OS process to call 
	
	    msgfmt myFile.po -o myFile.mo
	
	"
]

{ #category : #'private - actions' }
POFileEditor >> generate [
	|selections file|
	file := POTemplateFile new.
	selections :=  SelectTranslationPackageDialog open selectedPackages.
	(TranslationStringFinder allStringsReceivingMessage: #translated inPackages: selections) do: [:each | 
		each value do: [:key | 
			file addTranslation: '' forKey: key
		]
	].

	self halt.
	  
]

{ #category : #'private - actions' }
POFileEditor >> help [

	Workspace openContents: self class comment 
]

{ #category : #'private - accessing' }
POFileEditor >> iconProvider [

	^GetTextIcons 
]

{ #category : #'private - utilities' }
POFileEditor >> importFile: aFile [
	
	text text: aFile asFileReference readStream contentsOfEntireFile.
	self window title: self title, ' - ', aFile asString
]

{ #category : #initialization }
POFileEditor >> initialExtent [
	^   600@460
]

{ #category : #initialization }
POFileEditor >> initializeWidgets [

	menu := MenuPresenter new
		addGroup: [ :group |			 
			group addItem: [ :item |
				item
					name: nil;
					description: 'Open file';
					icon: (Smalltalk ui icons iconNamed: #openIcon);
					action: [ self openFile ] ].
			group addItem: [ :item |
				item 
					name: nil;
					description: 'Save File';
					icon: (Smalltalk ui icons iconNamed: #smallSaveIcon);					
					action: [ self inform: 'Save File' ] ].
			group addItem: [ :item |
				item 
					name: nil;
					description: 'Generate text';
					icon: (self iconProvider iconNamed: #gettextAddIcon);
					action: [ self generate ] ].	
			 
			group addItem: [ :item |
				item 
					name: nil;
					description: 'Help';
					icon: (Smalltalk ui icons iconNamed: #smallHelpIcon);
					action: [ self help ] ].		
		].
		
	menu applyTo: self.
	text := self newText.
	self focusOrder add: text
]

{ #category : #'private - actions' }
POFileEditor >> openFile [

	| filename |
	filename := UITheme builder 
							chooseFileName: 'Choose a .po file' 
							extensions: #('po') 
							path: nil 
							preview: nil.
	filename isNil ifTrue:[^nil].
	self importFile: filename
]

{ #category : #accessing }
POFileEditor >> taskbarIcon [

	^(GetTextIcons iconNamed: #gettextPOEditIcon)
]

{ #category : #accessing }
POFileEditor >> text [
	^ text
]

{ #category : #accessing }
POFileEditor >> title [

	^ 'PO editor'
]
