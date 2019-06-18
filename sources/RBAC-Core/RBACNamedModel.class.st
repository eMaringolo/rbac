"
I'm an abstract superclas representing anything that has a name and a description.
"
Class {
	#name : #RBACNamedModel,
	#superclass : #RBACObject,
	#instVars : [
		'name',
		'description'
	],
	#category : 'RBAC-Core'
}

{ #category : #'instance creation' }
RBACNamedModel class >> newNamed: aString [

	^self new
		name: aString;
		yourself
]

{ #category : #accessing }
RBACNamedModel >> <= anObject [

	^self name <= anObject name
]

{ #category : #accessing }
RBACNamedModel >> description [
	^ description
]

{ #category : #accessing }
RBACNamedModel >> description: aString [
	description := aString
]

{ #category : #private }
RBACNamedModel >> initializeRandomName [
	name := (self class name copyFrom: 5 to: self class name size)
		, ((GRPlatform current newRandom nextInt: 1000000) printString)
]

{ #category : #accessing }
RBACNamedModel >> name [
	name ifNil: [ self initializeRandomName ].
	^name
]

{ #category : #accessing }
RBACNamedModel >> name: anObject [
	name := anObject
]

{ #category : #accessing }
RBACNamedModel >> printOn: aStream [
	super printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: self name;
		nextPut: $)
]
