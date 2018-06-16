"
Gettext baseline
"
Class {
	#name : #BaselineOfGettext,
	#superclass : #BaselineOf,
	#category : #BaselineOfGettext
}

{ #category : #baseline }
BaselineOfGettext >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			package: 'Gettext-Core';
			package: 'Gettext-Tests' with: [
				spec requires: #('Gettext-Core' ). ];
			package: 'Gettext-Tools' with: [
				spec requires: #('Gettext-Core' ). ].
		spec 
			group: 'Core' with: #('Gettext-Core' );
			group: 'Tests' with: #('Gettext-Tests' );
			group: 'Tools' with: #('Gettext-Tools' ). ].

]
