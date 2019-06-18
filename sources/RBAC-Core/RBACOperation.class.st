"
I represent a single operation that can be used a checkpoint in the execution of the code, but not limited to that.
"
Class {
	#name : #RBACOperation,
	#superclass : #RBACPermissionSubject,
	#category : 'RBAC-Core'
}

{ #category : #testing }
RBACOperation >> isOperation [

	^true
]
