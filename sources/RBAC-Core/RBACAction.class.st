"
I represent an action that can be granted or denied to a profile
"
Class {
	#name : 'RBACAction',
	#superclass : 'Object',
	#instVars : [
		'subject'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'uncategorized' }
RBACAction class >> denialClass [
	^ Smalltalk at: (self name , 'Denied') asSymbol ifAbsent: [ RBACActionDenied ]
]

{ #category : 'uncategorized' }
RBACAction class >> isValidationActionClass [
	"Answer whether the receiver is a validation action class (used in Validation)"
	
	^false
]

{ #category : 'uncategorized' }
RBACAction class >> of: anObject [
	"Answer an instance of receiver with anObject as its subject."
	
	^self new
		entity: anObject;
		yourself
]

{ #category : 'uncategorized' }
RBACAction >> canBeDoneBy: aRBACUser [

	self subclassResponsibility
]

{ #category : 'uncategorized' }
RBACAction >> denialClass [
	^ self class denialClass
]

{ #category : 'uncategorized' }
RBACAction >> entity: anObject [
	subject := anObject
]

{ #category : 'uncategorized' }
RBACAction >> notifyDenialFor: aRBACUser [
	self denialClass signalForUser: aRBACUser
]

{ #category : 'uncategorized' }
RBACAction >> role [

	^subject
]
