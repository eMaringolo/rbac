"
I represent a group  in the framework, I can contain users and have different roles.
"
Class {
	#name : #RBACGroup,
	#superclass : #RBACProfile,
	#instVars : [
		'members'
	],
	#category : 'RBAC-Core'
}

{ #category : #accessing }
RBACGroup class >> displayName [

	^'Groups'
]

{ #category : #members }
RBACGroup >> addMember: aRBACUser [
	self members add: aRBACUser.
	aRBACUser onAddedToGroup: self
]

{ #category : #members }
RBACGroup >> includesMember: aRBACProfile [
	"Answer whether receiver includes aRBACProfile as one of its members."

	^ self members anySatisfy: [ :one | one = aRBACProfile ]
]

{ #category : #private }
RBACGroup >> initializeMembers [
	members := Set new
]

{ #category : #testing }
RBACGroup >> isGroup [

	^true
]

{ #category : #accessing }
RBACGroup >> members [
	"Answer the value of the receiver's ''members'' instance variable."

	members ifNil: [self initializeMembers].
	^members
]

{ #category : #accessing }
RBACGroup >> members: anObject [
	"Private - Set the value of the receiver's ''members'' instance variable to the argument, anObject."

	members := anObject
]

{ #category : #members }
RBACGroup >> removeAllMembers [
	self members copy
		do: [ :each | self removeMember: each ]
]

{ #category : #members }
RBACGroup >> removeMember: aRBACUser [ 
	"Adds aRBACProfile to the receiver members."

	self members remove: aRBACUser ifAbsent: [].
	aRBACUser onRemovedFromGroup: self
]
