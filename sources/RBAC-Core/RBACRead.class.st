"
I represent the Read action
"
Class {
	#name : 'RBACRead',
	#superclass : 'RBACAction',
	#vw_namespace : 'Root',
	#category : 'RBAC-Core'
}

{ #category : 'uncategorized' }
RBACRead >> canBeDoneBy: aRBACUser [
	"Answer true if the receiver can be done by aRBACUser."

	^aRBACUser canRead: self role
]
