"
I represent a simple preference for my owner a profile.

To avoid preference name collision, I also have a section name that works as a namespace.
"
Class {
	#name : #RBACProfilePreference,
	#superclass : #Object,
	#instVars : [
		'owner',
		'section',
		'name',
		'value'
	],
	#category : 'RBAC-Core'
}

{ #category : #'instance creation' }
RBACProfilePreference class >> named: aString section: anotherString [
	^ self new
		section: anotherString;
		name: aString;
		yourself
]

{ #category : #'instance creation' }
RBACProfilePreference class >> section: sectionString named: nameString value: anObject [
	^ (self named: nameString section: sectionString)
		value: anObject;
		yourself
]

{ #category : #uncategorized }
RBACProfilePreference >> name [
	^ name
]

{ #category : #uncategorized }
RBACProfilePreference >> name: anObject [
	name := anObject
]

{ #category : #uncategorized }
RBACProfilePreference >> owner [
	^ owner
]

{ #category : #uncategorized }
RBACProfilePreference >> owner: anObject [
	owner := anObject
]

{ #category : #uncategorized }
RBACProfilePreference >> printOn: aStream [
	aStream
		print: self section;
		nextPut: $.;
		print: self name;
		nextPut: $=;
		print: self value
]

{ #category : #uncategorized }
RBACProfilePreference >> section [
	^ section
]

{ #category : #uncategorized }
RBACProfilePreference >> section: aString [
	section := aString
]

{ #category : #uncategorized }
RBACProfilePreference >> value [
	
	^value
]

{ #category : #uncategorized }
RBACProfilePreference >> value: anObject [
	value := anObject
]
