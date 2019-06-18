"
I'm a transient permission, used internally for permission lookup and queries. I should not be stored anywhere.
"
Class {
	#name : #RBACTransientPermission,
	#superclass : #RBACPermission,
	#category : 'RBAC-Core'
}

{ #category : #uncategorized }
RBACTransientPermission class >> target: anObject [ 
	"Answer an instance of receiver with anObject as target."

	^(super target: anObject) denyAll
]

{ #category : #converting }
RBACTransientPermission >> asTransient [
	"Answer the receiver as a transient instance."
	
	^self
]

{ #category : #testing }
RBACTransientPermission >> isTransient [

	^true
]
