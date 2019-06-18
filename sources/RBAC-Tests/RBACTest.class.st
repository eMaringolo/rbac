Class {
	#name : #RBACTest,
	#superclass : #TestCase,
	#instVars : [
		'users',
		'simpleRoles',
		'groups',
		'compositeRoles',
		'operations'
	],
	#category : 'RBAC-Tests'
}

{ #category : #uncategorized }
RBACTest class >> isAbstract [

	^self name = #RBACTest
]

{ #category : #accessing }
RBACTest >> compositeRoles [
	compositeRoles ifNil: [ self initializeCompositeRoles ].
	^ compositeRoles
]

{ #category : #accessing }
RBACTest >> groups [
	groups ifNil: [ self initializeRBACGroups ].
	^ groups
]

{ #category : #initializing }
RBACTest >> initializeCompositeRoles [
	compositeRoles := (1 to: 5) collect: [ :each | RBACCompositeRole new ]
]

{ #category : #initializing }
RBACTest >> initializeOperations [
	^ operations := (1 to: 5) collect: [ :i | RBACOperation new ]
]

{ #category : #initializing }
RBACTest >> initializeRBACGroups [
	groups := (1 to: 4) collect: [:each | RBACGroup new]
]

{ #category : #initializing }
RBACTest >> initializeSimpleRoles [
	simpleRoles := (1 to: 5) collect: [ :each | RBACRole new ]
]

{ #category : #initializing }
RBACTest >> initializeUsers [
	users := (1 to: 4) collect: [ :each | RBACUser new ]
]

{ #category : #accessing }
RBACTest >> operations [
	operations ifNil: [ self initializeOperations ].
	^ operations
]

{ #category : #initializing }
RBACTest >> setupProfile [
	"Private - Test the addition of roles to the user."

	| profile crudForCreateAndUpdate crudForDeleteAndRead sysop objectForCreate objectForUpdate objectForDelete objectForRead |
	objectForCreate := RBACNamedModel new.
	objectForUpdate := RBACNamedModel new.
	objectForDelete := RBACNamedModel new.
	objectForRead := RBACNamedModel new.
	profile := self users at: 1.
	profile addRole: (self simpleRoles at: 1).
	crudForCreateAndUpdate := RBACPermission target: objectForCreate.
	crudForCreateAndUpdate
		allowsCreation: true;
		allowsUpdate: true.
	crudForDeleteAndRead := RBACPermission target: objectForDelete.
	crudForDeleteAndRead
		allowsDeletion: true;
		allowsRead: true.
	sysop := RBACPermission
		role: (self simpleRoles at: 1)
		target: (self operations at: 1).
	(self simpleRoles at: 1)
		addPermission: crudForCreateAndUpdate;
		addPermission: crudForDeleteAndRead;
		addPermission: sysop
]

{ #category : #accessing }
RBACTest >> simpleRoles [
	simpleRoles ifNil: [ self initializeSimpleRoles ].
	^ simpleRoles
]

{ #category : #accessing }
RBACTest >> users [
	users ifNil: [ self initializeUsers ].
	^ users
]
