"
I represent an authenticated session for a user.

All queries regarding whether a user can or cannot do some RBACAction should be asked to me.
"
Class {
	#name : 'RBACSession',
	#superclass : 'GRObject',
	#instVars : [
		'user',
		'creationTime',
		'attributes',
		'properties'
	],
	#classVars : [
		'Current'
	],
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'uncategorized' }
RBACSession class >> current [
	Current ifNil: [ self initializeCurrent ].
	^ Current
]

{ #category : 'uncategorized' }
RBACSession class >> current: aRBACSession [
	Current := aRBACSession
]

{ #category : 'uncategorized' }
RBACSession class >> currentUser [
	"Anwer the current user of receiver's current session."

	^self current user
]

{ #category : 'As yet unclassified' }
RBACSession class >> for: aRBACUser [
	"Answer a new instance of receiver, created for aRBACUser."
	
	^self new
		user: aRBACUser;
		creationTime: DateAndTime now;
		yourself
]

{ #category : 'uncategorized' }
RBACSession class >> initializeCurrent [
	"Private - Initializes the receiver."
	
	Current := self new
]

{ #category : 'uncategorized' }
RBACSession class >> reset [
	Current := nil
]

{ #category : 'accessing' }
RBACSession >> creationTime: aDateAndTime [ 
	creationTime := aDateAndTime
]

{ #category : 'accessing' }
RBACSession >> initializeProperties [

	^properties := GRSmallDictionary new
]

{ #category : 'accessing' }
RBACSession >> properties [

	properties ifNil: [self initializeProperties].
	^properties
]

{ #category : 'accessing' }
RBACSession >> propertyAt: aSymbol [

	^self propertyAt: aSymbol ifAbsent: [nil]
]

{ #category : 'accessing' }
RBACSession >> propertyAt: aSymbol ifAbsent: aBlock [

	^self properties at: aSymbol ifAbsent: aBlock
]

{ #category : 'accessing' }
RBACSession >> propertyAt: aSymbol put: anObject [

	^self properties at: aSymbol put: anObject
]

{ #category : 'actions' }
RBACSession >> request: aRBACAction ifGranted: grantBlock [
	"Request the execution of aRBACAction, evaluates grantBlock if the access is granted,
	otherwise evaluates denyBlock."

	^self request: aRBACAction
		ifGranted: grantBlock
		ifDenied: [aRBACAction notifyDenialFor: self user]
]

{ #category : 'actions' }
RBACSession >> request: aRBACAction ifGranted: grantBlock ifDenied: denyBlock [
	"Request the execution of aRBACAction, evaluates grantBlock if the access is granted,
	otherwise evaluates denyBlock."

	^(aRBACAction canBeDoneBy: self user) ifTrue: [grantBlock value] ifFalse: [denyBlock value]
]

{ #category : 'accessing' }
RBACSession >> user [
	"Answer the value of the receiver's ''user'' instance variable."

	^user
]

{ #category : 'accessing' }
RBACSession >> user: anObject [
	"Set the value of the receiver's ''user'' instance variable to the argument, anObject."

	user := anObject
]

{ #category : 'testing' }
RBACSession >> userCanCreate: target [ 
	"Answer whether the user can create objects of type target."

	^self userCanDo: (RBACCreation of: target)
]

{ #category : 'testing' }
RBACSession >> userCanDelete: target [
	"Answer whether the user can perform deletes on objects of type target."
	
	^self userCanDo: (RBACDeletion of: target)
]

{ #category : 'testing' }
RBACSession >> userCanDo: aRBACAction [
	"Answer whether the user can perform aRBACAction."
	
	^self request: aRBACAction ifGranted: [true] ifDenied: [false]
]

{ #category : 'testing' }
RBACSession >> userCanExecute: target [
	"Answer whether the user can execute objects of type target."
	
	^self userCanDo: (RBACExecution of: target)
]

{ #category : 'testing' }
RBACSession >> userCanRead: target [
	"Answer whether the user can read objects of type target."
	
	^self userCanDo: (RBACRead of: target)
]

{ #category : 'testing' }
RBACSession >> userCanUpdate: target [
	"Answer whether the user can perform updates on objects of type target."
	
	^self userCanDo: (RBACUpdate of: target)
]
