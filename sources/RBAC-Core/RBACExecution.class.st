"
I represent the Exection action
"
Class {
	#name : #RBACExecution,
	#superclass : #RBACAction,
	#category : 'RBAC-Core'
}

{ #category : #uncategorized }
RBACExecution >> canBeDoneBy: aRBACUser [
	^ aRBACUser canExecute: self role
]
