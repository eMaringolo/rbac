"
I'm an an abstract role and the central actor in this framework.


"
Class {
	#name : #RBACAbstractRole,
	#superclass : #RBACNamedModel,
	#instVars : [
		'profiles'
	],
	#category : #'RBAC-Core'
}

{ #category : #uncategorized }
RBACAbstractRole class >> isAbstract [
	"Answer whether the receiver is an Abstract class."
	
	^self == RBACAbstractRole
]

{ #category : #uncategorized }
RBACAbstractRole class >> prefixLength [ 

	^4
]

{ #category : #members }
RBACAbstractRole >> addProfile: aRBACProfile [

	(self hasProfile: aRBACProfile) ifFalse: [ 
		self profiles add: aRBACProfile.
		aRBACProfile onAddedToRole: self]
]

{ #category : #uncategorized }
RBACAbstractRole >> allSubroles [
	"Answer a collection of the receiver's subroles in 
	breadth-first order, with the immediate children first. 
	Breadth-first traversal is slightly less efficient, but results 
	in a more useful ordering (the standard does not specify the order)."

	| answer |
	answer := OrderedCollection new.
	self allSubrolesDo: [:each | answer add: each ].
	^answer
]

{ #category : #uncategorized }
RBACAbstractRole >> allSubrolesDo: aBlock [
	self subclassResponsibility
]

{ #category : #uncategorized }
RBACAbstractRole >> canExecute: aRBACSystemOperation [
	self subclassResponsibility
]

{ #category : #uncategorized }
RBACAbstractRole >> containsRole: aRole [
	"Answer true if the receiver or any of all its subroles includes aRole.
	The receiver isn't composite so it hasn't any subrole."
	
	self subclassResponsibility
]

{ #category : #uncategorized }
RBACAbstractRole >> equals: anObject [
	^ self = anObject
]

{ #category : #uncategorized }
RBACAbstractRole >> hasPermissionFor: target [
	| testBlock |
	testBlock := [ :each | 
	(each permissions anySatisfy: [ :perm | perm target = target ])
		ifTrue: [ ^ true ] ].
	testBlock value: self.
	self allSubrolesDo: testBlock.
	^ false
]

{ #category : #members }
RBACAbstractRole >> hasProfile: aRBACProfile [ 
	
	^(self profiles includes: aRBACProfile)
]

{ #category : #members }
RBACAbstractRole >> initialize [ 

	super initialize.
	profiles := Set new
]

{ #category : #uncategorized }
RBACAbstractRole >> isComposite [
	 "Answer whether receiver is composite."
	
	^false
]

{ #category : #members }
RBACAbstractRole >> onRemovedFromProfile: aRBACProfile [
	
	self profiles remove: aRBACProfile
]

{ #category : #uncategorized }
RBACAbstractRole >> permissionFor: anObject [
	"Answer the crud permission for anObject."
	
	^self subclassResponsibility
]

{ #category : #uncategorized }
RBACAbstractRole >> permissions [
	"Answer the CRUD permissions of the receiver."
	
	self subclassResponsibility
]

{ #category : #accessing }
RBACAbstractRole >> profiles [
	profiles ifNil: [ profiles := Set new ].
	^ profiles
]

{ #category : #permissions }
RBACAbstractRole >> removePermissionFor: target [
	| perm |
	(perm := self permissionFor: target) isTransient
		ifFalse: [ self permissions remove: perm ].
	^ perm
]

{ #category : #members }
RBACAbstractRole >> removeProfile: aRBACProfile [
	
	self profiles remove: aRBACProfile.
	aRBACProfile onRemovedFromRole: self
]

{ #category : #uncategorized }
RBACAbstractRole >> withAllSubroles [
	"Answer a <collection> with the receiver and its subroles in 
	breadth-first order, with the immediate children first. 
	Breadth-first traversal is slightly less efficient, but results 
	in a more useful ordering (the standard does not specify the order)."

	^self allSubroles
		addFirst: self;
		yourself
]
