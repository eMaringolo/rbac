"
I represent the Deletion action
"
Class {
	#name : #RBACDeletion,
	#superclass : #RBACAction,
	#category : 'RBAC-Core'
}

{ #category : #uncategorized }
RBACDeletion class >> isValidationActionClass [
	
	^true
]

{ #category : #uncategorized }
RBACDeletion >> canBeDoneBy: aRBACUser [
	"Answer true if the receiver can be done by aRBACUser."
	
	^aRBACUser canDelete: self role
]
