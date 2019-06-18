"
I represent the Update action
"
Class {
	#name : #RBACUpdate,
	#superclass : #RBACAction,
	#category : 'RBAC-Core'
}

{ #category : #uncategorized }
RBACUpdate >> canBeDoneBy: aRBACUser [
	"Answer true if the receiver can be done by aRBACUser."

	^aRBACUser canUpdate: self role
]
